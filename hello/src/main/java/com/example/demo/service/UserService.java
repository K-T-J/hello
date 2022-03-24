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
	public UserDTO update(int id) {
		
		
		Optional<UserDTO> dto = UserRe.findById(id);
		//findById()메서드는 조회하려는 값이 존재할 수도, 존재하지 않을수도 있어서 		
		//null에 의한 오류를 최소화 하기 위해 리턴으로 Optional<T>를 받는다
		/*
		Optional에서 많이 사용하는 것 중 하나가 ifPresent() 메서드와 isPresent()메서드 이다.
		ifPresent() :	1.특정 결과를 반환하지 않는다
						2.Optional의 값이 존재할 경우에만 실행될 로직이 함수의 인자로 전달된다
						3.함수형 인자로 람다식이 넘어올 수 있다.
		
		isPresent() :	1.특정 결과를 반환하지 않는다.
						2.현재 Optional의 값이 null인지 확인한다.
						3.if-else문을 사용하지 않고도 null값 존재 검사를 할 수 있다.
		*/
		return UserRe.findById(id).orElseGet(() -> null);
		
		
		
	}
	
	
	//리스트
	public List<UserDTO> list(){
		
		List<UserDTO> list = UserRe.findAll();
		
		return list;
	}
	

	

}
