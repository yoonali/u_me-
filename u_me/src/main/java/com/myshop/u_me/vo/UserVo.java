package com.myshop.u_me.vo;

import java.sql.Timestamp;

public class UserVo {
	
	//사용자 정보에 해당하는 멤버 필드
	int id;
	String user_id;
	String password;
	String name;
	String phone;
	
	//멤버 필드에 대한 getters, setters
	

	public String getPassword() {
		return password;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}


	

}
