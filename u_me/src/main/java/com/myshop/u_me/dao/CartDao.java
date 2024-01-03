package com.myshop.u_me.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.SessionScope;

import com.myshop.u_me.vo.CartVo;
import com.myshop.u_me.vo.ProductVo;
import com.myshop.u_me.vo.UserVo;

@Component
public class CartDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	HttpSession session;

	public boolean addToCart(int product_id) {
		System.out.println("addTocart()");
		
		String sql = "SELECT COUNT(*) FROM cart WHERE product_id = ?";
		
		int result = jdbcTemplate.queryForObject(sql, Integer.class, product_id);
		
		if(result > 0)
			return true;
		else
			return false;
	}

	public int insertProduct(CartVo cartVo) {
		System.out.println("insertProduct()");
		
		List<Integer> args = new ArrayList<Integer>();
		System.out.println(cartVo.getProduct_id());
		System.out.println(cartVo.getUser_id());
		
		String sql = "INSERT INTO cart(";
		
		sql += "product_id, ";
		args.add(cartVo.getProduct_id());
		
		sql += "user_id)";
		args.add(cartVo.getUser_id());
		
		sql += " VALUES(?,?)";
	
	
		int result = -1;
		
		try {
			result = jdbcTemplate.update(sql, args.toArray());
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateQuantity(int product_id) {
        System.out.println("updateQuantity()");

        String sql = "UPDATE cart SET quantity = quantity + 1 WHERE product_id = ?";
        return jdbcTemplate.update(sql, product_id);
    }
	
	public CartVo selectAll() {
	    System.out.println("selectCartVoAll()");
	    
	    UserVo loginedUserVo = (UserVo) session.getAttribute("loginedUserVo");

	    if (loginedUserVo != null) {
	        String sql = "SELECT * FROM cart WHERE user_id = ?";
	        
	        List<CartVo> cartVos = new ArrayList<>();
	        
	        try {
	            cartVos = jdbcTemplate.query(sql, new Object[]{loginedUserVo.getId()}, new RowMapper<CartVo>() {
	                
	                @Override
	                public CartVo mapRow(ResultSet rs, int rowNum) throws SQLException {
	                    
	                    CartVo cartVo = new CartVo();
	                    
	                    cartVo.setProduct_id(rs.getInt("product_id"));
	                    cartVo.setUser_id(rs.getInt("user_id"));
	                    
	                    return cartVo;
	                }
	            });
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	        return cartVos.size() > 0 ? cartVos.get(0) : null;
	    } else {
	        return null;
	    }
	}





}
