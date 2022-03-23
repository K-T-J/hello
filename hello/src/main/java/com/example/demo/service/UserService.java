package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.UserDTO.UserDTO;
import com.example.demo.repository.UserRepository;

@Service //서비스 레이어, 내부에서 자바 로직을 처리함
public class UserService {
	
	@Autowired //필요한 의존 객체의 타입에 해당하는 빈을 찾아 주입한다. 1.생성자, 2.setter, 3.필드
	private UserRepository UserRe; 
	//save()	:레코드 저장 (insert,update)
	//findOne()	:primary key로 레코드 한건 찾기
	//findAll()	:전체 레코드 불러오기, 정렬(sort), 페이징(pageable)가능
	//count()	:레코드 갯수
	//delete()	:레코드 삭제
	
	//저장
	public void signup(UserDTO dto){ 
		
		UserRe.save(dto);//저장

	}
	
	//수정
	public void update(UserDTO dto) {
		
		UserRe.save(dto);//저장
		
	}
	
	
	//리스트
	public List<UserDTO> list(){
		
		List<UserDTO> list = UserRe.findAll();
		
		return list;
	}
	

	

}
