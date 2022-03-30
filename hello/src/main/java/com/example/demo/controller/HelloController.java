package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.demo.UserDTO.UserDTO;
import com.example.demo.UserDTO.UserVO;
import com.example.demo.service.UserService;

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

	//리스트 페이지
	@GetMapping("/list")
	public String list() {

		return "list";
	}
	
	//리스트,페이징
	@ResponseBody
	@GetMapping("/userlist")
	public Map<String, Object> userlist(@PageableDefault(page = 0,size = 3,sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		//page : 0이 1페이지를뜻함 size : 한페이지에 몇개를보여주는지 sort : 무엇을 기준으로 direction : 정렬 DESC(내림차순)
		
		Page<UserDTO> list = service.list(pageable);//페이지를 매개변수에 넣어 몇개를 리턴해올지 구한다.
		
		int pageNumber = list.getPageable().getPageNumber(); //현재 페이지 / getPageable():페이지 요청 정보 getPageNumber():반환할 페이지
		int totalPages = list.getTotalPages();//총 페이지 수, 검색에 따라 달라짐
		int pageBlock = 3; //페이징 블럭의 수 
		int startBlockPage = ((pageNumber)/pageBlock)*pageBlock+1; //(블럭의 수가 3개일 경우 and 현재 페이지가 5페이지 일경우) : (5/3)*3+1 = 4 시작번호
		int endBlockPage = startBlockPage+pageBlock-1; //시작번호가 4일경우 : 4+3-1 = 6 끝번호
		System.out.println("endBlockPage1 : " +endBlockPage);
		endBlockPage = totalPages<endBlockPage ? totalPages : endBlockPage;// 총페이지수가 끝번호보다 작으면 = 총페이지수 값이 끝번호가 된다.	
																			// 총페이지수가 끝번호보다 클경우 = 끝번호 값이 끝번호가 된다.
		//출력
		System.out.println("First : "+ list.isFirst()); //시작페이지 여부
		System.out.println("Number : "+ list.getNumber()); //현재 페이지 번호
		System.out.println("Last : "+ list.isLast());//마지막 페이지 여부
		System.out.println("pageNumber : " +pageNumber);//현재 페이지
		System.out.println("totalPages : " +totalPages);//총페이지수
		System.out.println("startBlockPage : " +startBlockPage);//시작 페이징 블럭
		System.out.println("endBlockPage2 : " + endBlockPage);//끝 페이징 블럭
		
		//ajax 리턴하기 위해 map에 담기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Number", list.getNumber());
		map.put("First", list.isFirst());
		map.put("Last", list.isLast());
		map.put("pageNumber", pageNumber);
		map.put("totalPages", totalPages);
		map.put("startBlockPage", startBlockPage);
		map.put("endBlockPage", endBlockPage);
		map.put("pageBlock", pageBlock);
		
		//Page<>리턴을 하면 ajax에서 인식을? 못하기때문에 List로 바꿔서 리턴
		List<UserDTO> dto = list.getContent();//getContent(), get() : 실제 컨텐츠를 가지고 오는 메서드. 
											//getContext는 List<Entity> 반환, get()은 Stream<Entity> 반환
		map.put("list", dto);//list도 map에 담기

		return map;
	}
	
	//가입등록
	@ResponseBody //ajax로 호출
	@PostMapping("/submit")
	public void submit(UserDTO dto) {
		service.signup(dto);
	}
	
	//수정
	@ResponseBody // ajax로 호출
	@PostMapping("/update")
	public void update(UserVO vo, Model model) {//만약 json타입으로 값이 넘어왔을경우@RequestBody를 사용하면 
												//json데이터를 요청했을때 -> java object로 변환해서 받아준다(MessageConverter의 jackson라이브러리가 변환해줌)
		service.update(vo);
		
	}
	
	//삭제
	@ResponseBody
	@PostMapping("/delete")
	public void delete(UserDTO dto) {
		
		service.userDelete(dto);
	}
	
	//유저 한명에 정보 가져오기
	//ajax
	//@RequestBody를 사용하면 json데이터를 요청했을때 -> java object로 변환해서 받아준다
	@ResponseBody //view페이지가 아닌 변환값 그대로 클라이언트한테 return 하고 싶은 경우 사용
	@RequestMapping("/modify")
	public UserDTO modify(UserDTO dto,Model model) {
		
		int id = dto.getId();//dto로 받은 값을 꺼내 id변수에 넣기
		dto = service.oneUser(id);//update매서드 재활용
		
		return dto;
	}
	
	/*
	//유저 리스트 (페이징)
	@GetMapping("/list")
	public String userlist(Model model,@PageableDefault(page = 0,size = 3,sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		//page는 0이 1페이지를뜻함 size는 한페이지에 몇개를보여주는지 sort는 무엇을 기준으로 direction는 정렬
		Page<UserDTO> list = service.list(pageable);
		
		int pageNumber = list.getPageable().getPageNumber(); //현제 페이지
		int totalPages = list.getTotalPages();//총 페이지 수, 검색에 따라 달라짐
		int pageBlock = 3; //블럭의 수 
		int startBlockPage = ((pageNumber)/pageBlock)*pageBlock+1; //(블럭의 수가 3개일경우,현재 페이지가 5페이지 일경우) : (5/3)*3+1 = 4 시작번호
		int endBlockPage = startBlockPage+pageBlock-1; //시작번호가 4일경우 : 4+3-1 = 6 끝번호
		System.out.println("endBlockPage1 : " +endBlockPage);
		endBlockPage = totalPages<endBlockPage ? totalPages : endBlockPage;// 총페이지수가 끝번호보다 작으면 = 총페이지수 값이 끝번호가 된다.	
																			// 총페이지수가 끝번호보다 클경우 = 끝번호 값이 끝번호가 된다.
		
		//출력
	
		System.out.println("pageNumber : " +pageNumber);
		System.out.println("totalPages : " +totalPages);
		System.out.println("startBlockPage2 : " +startBlockPage);
		System.out.println("endBlockPage2 : " + endBlockPage);

		
		model.addAttribute("startBlockPage", startBlockPage);
		model.addAttribute("endBlockPage", endBlockPage);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("list",list);
		return "list";
	}
	*/
	

	
	

}
