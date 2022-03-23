package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.UserDTO.UserDTO;


//DAO
//자동으로 Bean등록이 된다
//@Repository 생략 가능하다
public interface UserRepository extends JpaRepository<UserDTO, Integer>{//JpaRepository를 상속받을 때는 사용될 Entity 클래스와 ID(primary key)값이 들어가게 된다.
																		//즉,JpaRepository(테이블,PK)가 된다.
	//Entity의 기본적인 CRUD가 가능하도록 JpaRepository 인터페이스를 제공한다.
	//Spring Data JPA에서 제공하는 JpaRepository 인터페이스를 상속하기만 해도 되며,
	//@Repository등의 어노테이션을 추가할 필요가 없다.
	
}
