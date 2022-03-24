package com.example.demo.UserDTO;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class UserVO {
	
	private int id; 
	
	private String username; // 아이디
	
	private String password; // 비밀번호
	
	private String email; //이메일
	
}
