package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.UserDTO.UserDTO;
import com.example.demo.service.UserService;

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
		
		return "submit";
	}
	
	//수정
	@GetMapping("/update")
	public String update(UserDTO dto,Model model) {
		
		model.addAttribute("dto",dto);
		
		return "update";
	}
	
	//updatePro
	@PostMapping("/updatePro")
	public String updatePro(UserDTO dto) {
		
		service.update(dto);
		
		return "main";
	}
	
	
	//리스트
	@GetMapping("/list")
	public String userlist(Model model) {
		
		List<UserDTO> list = service.list();
		model.addAttribute("list",list);
		return "list";
	}

	
	

}
