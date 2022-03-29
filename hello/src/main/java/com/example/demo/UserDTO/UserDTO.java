package com.example.demo.UserDTO;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicInsert;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data //getter setter
@NoArgsConstructor//빈생성자
@AllArgsConstructor//모든 생성자
@Table(name="user")
//@DynamicInsert insert시에 null인 필드를 제외시켜준다
@Entity//데이터베이스에 저장하기 위해 유저가 정의한 클래스가 필요한데 그런 클래스를 Entity라고 한다.
public class UserDTO {
	
	@Id //pk라는걸 알려주기위해
	@GeneratedValue(strategy = GenerationType.IDENTITY) //프로젝트에서 연결된 DB의 넘버링(시퀀스,auto_increment 등) 전략을 따라간다.+1
	@Column(name="id")
	private int id; //시퀀스, mysql : auto_increment
	
	@Column(name="username",unique = true, nullable = false, length = 30)//null이 될수없고 30자 이내
	private String username; // 아이디
	
	@Column(name="password", nullable = false, length = 100)//null이 될수없고 100자 이내 (해쉬 : 암호화)
	private String password; // 비밀번호
	
	@Column(name="email", nullable = false, length = 50)//null이 될수없고 50자 이내
	private String email; //이메일
	
	//@ColumnDefault("'user'")//기본값 user 문자는 중간에 ''로 문자인걸 나타내야함
	//private String role; //Enum을 쓰는게 좋다 (admin,user,manager 도메인을 줄수있다.) 도메인 : 어떤 범위를 말한다.
	
//	@CreationTimestamp //시간이 자동 입력
//	@Column(name="createDate")
//	private Timestamp createDate; //시간

	
	
	
	

}
