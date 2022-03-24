package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.UserDTO.UserDTO;
import com.example.demo.UserDTO.UserVO;
import com.example.demo.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller//프레젠테이션 레이어, 웹 요청과 응답을 처리함
public class HelloController {
	
	@Autowired //의존성 주입 (DI) 
	private UserService service;
	
	//메인
	@GetMapping("/main")
	public String main() {
		
		return "main";
	}
	//가입
	@GetMapping("/signup")
	public String signup() {
		
		return "signup";
	}
	//가입등록
	@PostMapping("/submit")
	public String submit(UserDTO dto) {
		service.signup(dto);
		
		return "main";
	}
	
	//수정
	@PostMapping("/update")
	public String update(UserDTO dto, Model model) {
		
		int id = dto.getId();
		
		dto = service.update(id);
		model.addAttribute("dto",dto);
		
		return "main";
	}
	
	//리스트
	@GetMapping("/list")
	public String userlist(Model model) {
		
		List<UserDTO> list = service.list();
		model.addAttribute("list",list);
		return "list";
	}
	
	//ajax
	@ResponseBody
	@RequestMapping("/modify")
	public UserDTO modify(UserDTO dto,Model model) {
		
		int id = dto.getId();//dto로 받은 값을 꺼내 id변수에 넣기
		dto = service.update(id);//update매서드 재활용
		
		return dto;
	}

	
	

}
