package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.demo.UserDTO.UserDTO;
import com.example.demo.UserDTO.UserVO;
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
		
		//save함수는 id를 전달하지 않으면 insert를 해주고
		//save함수는 id를 전달하면 해당 id에 대한 데이터가 있으면 update를 해주고
		//save함수는 id를 전달하면 해당 id에 대한 데이터가 없으면 insert를 한다
		
		

	}
	//유저 한명에 정보 가져오기
	public UserDTO oneUser(int id) {
		
		UserDTO dto = UserRe.findById(id).orElseThrow(()->{
			return new IllegalArgumentException("가져오기 실패");
		});
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
		return dto;
		
		
		
	}
	//수정
	@Transactional // 트랜잭션 함수종료시 자동 commit이됨 / 더티체킹
	public void update(UserVO vo) {
		
		//이때 영속화가 된다
		UserDTO dto = UserRe.findById(vo.getId()).orElseThrow(()->{//orElseThrow 못찾는다면 어떤 함수를 실행해라 라는뜻이지만 
																//자바는 파라미터에 함수를 넣을수 없지만 람다식을 이용해 바로 함수를 쓸수있다.
			return new IllegalArgumentException("수정 실패");
		});
		
		//영속화로 가져온 DB데이터와 지금 변경된 데이터를 비교해서 변경이 되었다고 인식하면 update를 수행한다.
		dto.setPassword(vo.getPassword());
		dto.setEmail(vo.getEmail());
		
	}
	
	//삭제
	public String userDelete(UserDTO dto) {
		
		try {
			UserRe.deleteById(dto.getId()); //db에 없는 id로 삭제를 했을경우 에러가 뜰수 있기때문에 try catch로 작성
			
		}catch (EmptyResultDataAccessException e) {
			return "삭제 실패";
		}
		
		return null; //삭제가 잘 됐을경우 null
	}
	
	
	//리스트(페이징)
	public Page<UserDTO> list(Pageable pageable){
		
		Page<UserDTO> list = UserRe.findAll(pageable); //PageRequest.of(0, 0) 페이징 처리를 도와주는 JPA 
		//list타입 리턴이 아니라 Page타입으로 리턴
		
		return list;
	}
	//테스트 시작
	public List<UserDTO> userlist() {
		
		List<UserDTO> dto = UserRe.findAll();
		
		return dto;
		
	}
	//테스트 끝

	

	

}
