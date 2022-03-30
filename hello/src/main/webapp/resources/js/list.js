/*$(function () {
	
	test();
});

function test () {
	
}
*/
//페이지 실행,이동될때
function list(data){
	$.ajax({
		type : "get",
		url : "userlist?page="+data, //페이지번호 같이 넘기기
		dataType : "json",//받는 데이터 타입
		error : function(jqXHR, textStatus, errorThrown){
			alert(error);
		/*
			jqXHR.status : 500  : 오류번호를 출력한다.
			jqXHR.statusText : "Internal Server Error" : 오류 내용 텍스트 ->errorThrown와 동일
			jqXHR.responseText : url의 full response(아래 그림 참조) : url의 response ful text를 출력한다.
			jqXHR.readyState : 4	: ajax readyState를 출력한다.
			textStatus: error 고정출력 / errorThrown:inter Server Error, Not Found등 오류 메시지 출력
			
			1. jquery ajax의 error는 jqXHR, textStatus, errorThrown 의 세 가지 파라미터를 제공 한다.
			2. error의 두 번째 인자 textStatus와 세 번째 인자 errorThrown는 굳이 사용할 일이 없을 것 같다
			3. jqXHR.status는 http 오류 번호를 반환하며 케이스별 오류 메시지 판정에 사용하면 유용할 것 같다
			2. jqXHR.responseText는 url의 full response를 반환하기 때문에 ajax 오류 디버깅 시에 상당한 도움을 줄 것이다.
		*/	
		},
		success : function(data){resultHtml(data)}//성공했을경우 resultHtml 함수 호출
	});
	
}

//리스트,페이지 이동 ajax를 성공시 호출되는 함수
function resultHtml(data){
	//controller에서 넘어온 map 확인차 출력
	/*
 	console.log("Pageable :"+data.Pageable);
	console.log("Number :"+data.Number);
	console.log("First :"+data.First);
	console.log("Last :"+data.Last);
	console.log("pageNumber :"+data.pageNumber);
	console.log("totalPages : " + data.totalPages);
	console.log("startBlockPage : " + data.startBlockPage);
	console.log("endBlockPage : " + data.endBlockPage);
	console.log("pageBlock : " + data.pageBlock); 
	
	//controller에서 넘어온 map list확인
	for(var dto in data.list){
		console.log("id : " + data.list[dto].id);
		console.log("username : " + data.list[dto].username);
		console.log("password : " + data.list[dto].password);
		console.log("email : " + data.list[dto].email);
	}; */
	
	//변수에 담기
	var Pageable = data.Pageable;
	var Number = data.Number;
	var First = data.First;
	var Last = data.Last;
	var pageNumber = data.pageNumber;
	var totalPages = data.totalPages;
	var startBlockPage = data.startBlockPage;
	var endBlockPage = data.endBlockPage;
	var pageBlock = data.pageBlock;
	
	//테이블 시작
	var html = "<table class='table table-striped'>";
	html += "<tr>";
	html += "<td>id</td>";
	html += "<td>username</td>";
	html += "<td>password</td>";
	html += "<td>email</td>";
	html += "<td>삭제</td>";
	html += "</tr>";
	
	for(var i in data.list){ //리스트 뿌리기
		console.log("data.list : for문 탔다!");
		html += "<tr>";
		html += "<td>"+data.list[i].id+"</td>";
		html += "<td><a href='javascript:void(0)' onclick='onDisplay("+data.list[i].id+")'>"+data.list[i].username+"</a></td>";//username을 누르면 수정 함수 호출 (id)값을 포함해서 호출
		html += "<td>"+data.list[i].password+"</td>";
		html += "<td>"+data.list[i].email+"</td>";
		html += "<td><button type='button' class='btn btn-outline-primary' onclick='onDelete("+data.list[i].id+")'>"+'삭제'+"</button></td>";//삭제 버튼을 누르면 삭제 함수호출 (id)값을 포함해서 호출
		html += "</tr>";
	};
	html += "</table>";
	//테이블 끝
	
	
	//페이징 시작
	html += "<nav aria-label='Page navigation example'>";
	html += "<ul class='pagination justify-content-center'>";
	html += "<li class='page-item'>";
	//처음,<-
	if(!First){//첫 페이지가 아니면 실행
		var Numberminus = Number - 1; //계산값 변수에 담아서 뿌리기
		console.log("첫 페이지가 아니다 : if문 실행!");
		html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list(0)'>"+'처음'+"</a></li>";
		html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ Numberminus +")'> &larr; </a></li>";//함수 호출하여 페이징 처리
	};
	//중간 숫자
	for(var i = startBlockPage; i <= endBlockPage; i++){//시작블럭 ~ 마지막블럭 까지 반복
		var minus  = i-1; //계산값 변수에 담아서 뿌리기 : 시작블럭-1
		console.log("startBlockPage : for문 탔다!");
		if(pageNumber+1 == startBlockPage){//현재번호+1 == 시작블럭과 동일할 경우
			console.log("Pageable+1 : if문 탔다!");
			html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ minus +")'>"+ i +"</a></li>";//disabled
		}else{//동일하지 않을경우
			console.log("Pageable+1 : else문 탔다!");
			html +="<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ minus +")'>"+ i +"</a></li>";
		};
	};
	//마지막,->
	if(!Last){//마지막 페이지가 아니면 실행
		var plus = Number+1; //계산값 변수에 담아서 뿌리기 : 현재 페이지 +1
		var totalminus = totalPages-1; //계산값 변수에 담아서 뿌리기 : 총페이지 -1;
		console.log("마지막 페이지가 아니다 : if문 실행!");
		html +="<li class='page-item '><a class='page-link' href='javascript:void(0)' onclick='list("+ plus +")'> &rarr;</a></li>";
		html +="<li class='page-item '><a class='page-link' href='javascript:void(0)' onclick='list("+ totalminus + ")'>" + '마지막' + "</a></li>";
	};
	
	html += "</ul>";
	html += "</nav>";
	//페이징 끝
	
	$("#userlist").empty(); //.empty() 요소 내용을 지운다.
	$("#userlist").append(html);//.append()선택된 요소의 마지막에 새로운 요소나 콘텐츠를 추가한다

}

//가입버튼을 눌렀을때
function onSignup() {
	$("#signup").show();//보여주기
	$("#update").hide();//페이지 로딩될때 안보이게 설정
}

//수정 버튼을 눌렀을때
function onDisplay(data) {
	$("#update").show();//보여주기
	$("#signup").hide();//페이지 로딩될때 안보이게 설정
	var id = data; //매개변수를 id변수에 넣기
 	$.ajax({
		type : "post", //method get,post
		url : "modify", // 보낼주소
		data : {id:id}, // 보내는 데이터 타입 : map 형태로 보내기   data는 string 또는 map으로
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function(data){ // 성공했다면
		 	var username = data["username"]; // key값으로 꺼낸 value를 변수에 넣기
		 	var password = data["password"];// key값으로 꺼낸 value를 변수에 넣기
		 	var email = data["email"];// key값으로 꺼낸 value를 변수에 넣기
			
		 	$("#id").val(id);//id라는 id값에 value에 변수넣기
		 	$("#username").val(username);//username이라는 id값에 value에 변수넣기
		 	$("#password").val(password);//password이라는 id값에 value에 변수넣기
		 	$("#email").val(email);//email이라는 id값에 value에 변수넣기
		}
	});  
}

//가입 submit
function onSubmit() {
	var formData = $("form[name=signup]").serialize(); //serialize() : form요소 name값(value)를 문자열로 변환하는 함수
 	$.ajax({
		type : "post",
		url : "submit",
		data : formData,
		error : function(jqXHR, textStatus, errorThrown ){ //에러가 났을경우
			alert(error);
		},
		success : function(data) {
			location.reload();//성공시 리로드
		}
			
	}); 
}	

//수정 submit
function onUpdate() {
	var formData = $("form[name=update]").serialize(); //serialize() : form요소 name값(value)를 문자열로 변환하는 함수
 	$.ajax({
		type : "post",
		url : "update",
		data : formData,
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function() {
			location.reload();//성공시 리로드
		}
	}); 
}

//삭제
function onDelete(data) {
	var id = data;
	$.ajax({
		type : "post",
		url : "delete",
		data : {id:id},
		error : function (xhr, status, errer) {
			alert(error);
		},
		success : function() {
			location.reload();//리로드
		}
	});
}