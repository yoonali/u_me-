package com.myshop.u_me.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.myshop.u_me.vo.AddressVo;
import com.myshop.u_me.vo.UserVo;

@Component
public class UserDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	HttpSession session;
	
	public boolean isUserMember(String user_id) {
		System.out.println("dao isUserMember()");
		
		String sql = "SELECT COUNT(*) FROM user "
				+ "WHERE user_id = ?";
		
		int result = jdbcTemplate.queryForObject(sql, Integer.class, user_id);
		
		if(result > 0)
			return true;
		else
			return false;
	}
	
	public int insertUserAccount(UserVo userVo) {
		System.out.println("dao insertUserAccount()");

		List<String> args = new ArrayList<String>();
		
		String sql = "INSERT INTO user(";
		
		sql += "user_id, ";
		args.add(userVo.getUser_id());
		
		sql += "password, ";
		args.add(passwordEncoder.encode(userVo.getPassword()));
		
		sql += "name, ";
		args.add(userVo.getName());
		
		sql += "phone) ";
		args.add(userVo.getPhone());
		
		sql += "VALUES(?,?,?,?)";
		
		int result = -1;
		System.out.println(sql);
		try {
			
			result = jdbcTemplate.update(sql, args.toArray());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public UserVo selectUser(UserVo userVo) {
		System.out.println("selectUser()");
		
		//입력한 아이디가 일치하는지 확인
		String sql = "SELECT * FROM user WHERE user_id = ?";
		
		List<UserVo> userVos = new ArrayList<UserVo>();
		
		try {
			//회원을 조회하는 쿼리를 실행하고 결과를 userVos에 할당
			userVos = jdbcTemplate.query(sql, new RowMapper<UserVo>() {
				
				@Override
				public UserVo mapRow(ResultSet rs, int rowNum) throws
				SQLException {
					UserVo userVo = new UserVo();
					
					userVo.setId(rs.getInt("id"));
					userVo.setUser_id(rs.getString("user_id"));
					userVo.setPassword(rs.getString("password"));
					userVo.setName(rs.getString("name"));
					userVo.setPhone(rs.getString("phone"));
					
					return userVo;
					//rs = db에서 조회된 데이터셋이 저장되어 있음 / rowNum = 데이터셋의 현재 행 번호 저장
				}
			}, userVo.getUser_id());

			//비밀번호 비교하는 코드
			if(!passwordEncoder.matches(userVo.getPassword(), userVos.get(0).getPassword()))
				userVos.clear();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return userVos.size() > 0 ? userVos.get(0) : null;
		
	}

	public boolean addAddress(String zipcode) {
		System.out.println("addAddress");
		
		String sql = "SELECT COUNT(*) FROM user_address WHERE zipcode = ?";
		
		int result = jdbcTemplate.queryForObject(sql, Integer.class, zipcode);
		
		if(result > 0)
			return true;
		else
			return false;
	}

	public int insertAddressInfo(AddressVo addressVo) {
		System.out.println("insertAddress");
		
		List<Object> args = new ArrayList<Object>();
		
		String sql = "INSERT INTO user_address(";
		
		sql += "user_id, ";
		args.add(addressVo.getUser_id());
		
		sql += "zipcode, ";
		args.add(addressVo.getZipcode());
		
		sql += "addr, ";
		args.add(addressVo.getAddr());
		
		sql += "addrdetail)";
		args.add(addressVo.getAddrdetail());
		
		sql +=  " VALUES(?,?,?,?)";
		
		int result = -1;
		
		try {
			result = jdbcTemplate.update(sql, args.toArray());
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateAddress(AddressVo addressVo) {
		System.out.println("updateAddress()");
		
		String sql = "UPDATE user_address SET zipcode = ?, addr = ?, addrdetail = ? WHERE user_id = ?";

		List<Object> args = new ArrayList<>();
		args.add(addressVo.getZipcode());
		args.add(addressVo.getAddr());
		args.add(addressVo.getAddrdetail());
		args.add(addressVo.getUser_id());

		int result = -1;

		try {
		    result = jdbcTemplate.update(sql, args.toArray());
		} catch (Exception e) {
		    e.printStackTrace();
		}

		return result;

	}

	public int updateUser(UserVo userVo) {
		
		String sql = "UPDATE user SET password = ?, name = ? WHERE user_id = ?";
		
		List<String> args = new ArrayList<String>();
		args.add(userVo.getPassword());
		args.add(userVo.getName());
		
		int result = -1;
		
		try {
		    result = jdbcTemplate.update(sql, args.toArray());
		} catch (Exception e) {
		    e.printStackTrace();
		}

		return result;
	}

	public AddressVo selectAll() {
		
		UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");
		
		if(loginedUserVo != null) {
			String sql = "SELECT * FROM user_address WHERE user_id = ?";
			
			List<AddressVo> addressVos = new ArrayList<>();
			
			try {
				addressVos = jdbcTemplate.query(sql, new Object[]{loginedUserVo.getId()}, new RowMapper<AddressVo>() {
					
					@Override
					public AddressVo mapRow(ResultSet rs, int rowNum) throws SQLException {
						
						AddressVo addressVo = new AddressVo();
						
						addressVo.setZipcode(rs.getString("zipcode"));
						addressVo.setAddr(rs.getString("addr"));
						addressVo.setAddrdetail(rs.getString("addrdetail"));
						
						return addressVo;
					}
				});
			}catch (Exception e) {
				e.printStackTrace();
			}
			return addressVos.size() > 0 ? addressVos.get(0) : null;
		}else {
			 return null;
		}
		
	}
	
	
}
