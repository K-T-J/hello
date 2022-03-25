package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.UserDTO.UserDTO;
import com.example.demo.UserDTO.UserVO;
import com.example.demo.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

//@RestController :view 페이지가 아니라 데이터를 리턴할때 사용
@Controller//프레젠테이션 레이어, 웹 요청과 응답을 처리함 
public class HelloController {
	
	@Autowired //의존성 주입 (DI) 
	private UserService service;
	
	//메인
	@GetMapping("/main")
	public String main() {
		
		return "main";
	}

	//가입등록
	@PostMapping("/submit")
	public String submit(UserDTO dto) {
		service.signup(dto);
		
		return "main";
	}
	
	//수정
	@ResponseBody
	@PostMapping("/update")
	public void update(UserVO vo, Model model) {//만약 json타입으로 값이 넘어왔을경우@RequestBody를 사용하면 
													//json데이터를 요청했을때 -> java object로 변환해서 받아준다(MessageConverter의 jackson라이브러리가 변환해줌)
		service.testupdate(vo);
		//model.addAttribute("dto",dto);
		
	}
	
	
	@GetMapping("/list")
	public String userlist(Model model,@PageableDefault(page = 0,size = 3,sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		//page는 0이 1페이지를뜻함 size는 한페이지에 몇개를보여주는지 sort는 무엇을 기준으로 direction는 정렬
		Page<UserDTO> list = service.list(pageable);
		
		int pageNumber = list.getPageable().getPageNumber(); //현제 페이지
		int totalPages = list.getTotalPages();//총 페이지 수, 검색에 따라 달라짐
		int pageBlock = 3; //블럭의 수 
		int startBlockPage = ((pageNumber)/pageBlock)*pageBlock+1; //현재 페이지가 7이라면 1*5 +1 = 6
		int endBlockPage = startBlockPage+pageBlock-1; //6+5-1=10  6,7,8,9,10 해서 10
		endBlockPage = totalPages<endBlockPage? totalPages : endBlockPage;

		
		model.addAttribute("startBlockPage", startBlockPage);
		model.addAttribute("endBlockPage", endBlockPage);
		model.addAttribute("list",list);
		return "list";
	}
	
	//ajax
	//@RequestBody를 사용하면 json데이터를 요청했을때 -> java object로 변환해서 받아준다
	@ResponseBody //view페이지가 아닌 변환값 그대로 클라이언트한테 return 하고 싶은 경우 사용
	@RequestMapping("/modify")
	public UserDTO modify(UserDTO dto,Model model) {
		
		int id = dto.getId();//dto로 받은 값을 꺼내 id변수에 넣기
		dto = service.update(id);//update매서드 재활용
		
		return dto;
	}

	
	

}
