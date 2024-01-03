package com.myshop.u_me.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.u_me.dao.UserDao;
import com.myshop.u_me.vo.AddressVo;
import com.myshop.u_me.vo.UserVo;

@Service
public class UserService {
	
	final static public int ADMIN_ACCOUNT_ALREADY_EXIST = 0;
	final static public int ADMIN_ACCOUNT_CREATE_SUCCESS = 1;
	final static public int ADMIN_ACCOUNT_CREATE_FAIL = -1;
	
	final static public int ADDRESS_CREATE_SUCCESS = 1;
	final static public int ADDRESS_CREATE_FAIL = -1;
	final static public int ADDRESS_ALREADY_EXIST = 0;

	final static public int USER_UPDATE_SUCCESS = 1;
	final static public int USER_UPDATE_FAIL = -1;
	
	@Autowired
	UserDao userDao;
	
	public int join(UserVo userVo) {
		System.out.println("UserService signUpConfirm()");
		
		boolean isMember = userDao.isUserMember(userVo.getUser_id());
		
		if(!isMember) {
			int result = userDao.insertUserAccount(userVo);
		
			if(result > 0)
				return ADMIN_ACCOUNT_CREATE_SUCCESS;
			else
				return ADMIN_ACCOUNT_CREATE_FAIL;
		} else {
			return ADMIN_ACCOUNT_ALREADY_EXIST;
		}
	
	}
	
	public UserVo loginConfirm(UserVo userVo) {
		System.out.println("loginConfirm()");
		
		UserVo loginedUserVo = userDao.selectUser(userVo);
		
		if(loginedUserVo != null) {
			System.out.println("success");
		}else
			System.out.println("fail");
		
		return loginedUserVo;
	}

	public int addAddress(AddressVo addressVo) {
		System.out.println("addAddress()");
		
		boolean isAddress = userDao.addAddress(addressVo.getZipcode());
		System.out.println(addressVo.getZipcode());
		
		if(!isAddress) {
			int result = userDao.insertAddressInfo(addressVo);
			
			if(result > 0)
				return ADDRESS_CREATE_SUCCESS;
			else
				return ADDRESS_CREATE_FAIL;
		} else {
			//이미 주소가 있을 경우 
			//주소 업데이트
			int result = userDao.updateAddress(addressVo);
			if(result > 0)
				return ADDRESS_CREATE_SUCCESS;
			else
				return ADDRESS_CREATE_FAIL;
		}
	}

	public int updateUserInfo(UserVo userVo) {
		int result = userDao.updateUser(userVo);
		
		if(result > 0)
			return USER_UPDATE_SUCCESS;
		else
			return USER_UPDATE_FAIL;
	}

	public AddressVo getAddress() {
		return userDao.selectAll();
	}

}
