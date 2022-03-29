<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"><!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script><!-- jquery -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script> <!-- js -->
<script type="text/javascript">

//페이지 로딩될때
$(document).ready(function() {
	$("#update").hide();//페이지 로딩될때 안보이게 설정
	$("#signup").hide();//페이지 로딩될때 안보이게 설정
 	$("#userlist").show() 
	list(0);
	
});

//페이지 이동될때
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
	//controller에서 넘어온 map 확인
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
		html += "<td><a href='javascript:void(0)' onclick='onDisplay("+data.list[i].id+")'>"+data.list[i].username+"</a></td>";
		html += "<td>"+data.list[i].password+"</td>";
		html += "<td>"+data.list[i].email+"</td>";
		html += "<td><button type='button' class='btn btn-outline-primary' onclick='onDelete("+data.list[i].id+")'>"+'삭제'+"</button></td>";
		html += "</tr>";
	};
	html += "</table>";
	//테이블 끝
	
	
	//페이징 시작
	html += "<nav aria-label='Page navigation example'>";
	html += "<ul class='pagination justify-content-center'>";
	html += "<li class='page-item'>";
	//처음,<-
	if(!First){
		var Numberminus = Number - 1; //계산값 변수에 담아서 뿌리기
		console.log("!First : if문 탔다!");
		html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list(0)'>"+'처음'+"</a></li>";
		html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ Numberminus +")'> &larr; </a></li>";
	};
	//중간 숫자
	for(var i = startBlockPage; i <= endBlockPage; i++){
		var minus  = i-1; //계산값 변수에 담아서 뿌리기
		console.log("startBlockPage : for문 탔다!");
		if(Pageable+1 == startBlockPage){
			console.log("Pageable+1 : if문 탔다!");
			html += "<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ minus +")'>"+ i +"</a></li>";//disabled
		}else{
			console.log("Pageable+1 : else문 탔다!");
			html +="<li class='page-item'><a class='page-link' href='javascript:void(0)' onclick='list("+ minus +")'>"+ i +"</a></li>";
		};
	};
	//마지막,->
	if(!Last){
		var plus = Number+1; //계산값 변수에 담아서 뿌리기
		var totalminus = totalPages-1; //계산값 변수에 담아서 뿌리기
		console.log("!Last : if문 탔다!");
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
		data : {id:id}, // 보내는 데이터 타입 : id를 id라고 부르겠다?
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
	var formData = $("form[name=signup]").serialize();
 	$.ajax({
		type : "post",
		url : "submit",
		data : formData,
		error : function(jqXHR, textStatus, errorThrown ){ //에러가 났을경우
			alert(error);
		},
		success : function(data) {
			location.reload();//리로드
		}
			
	}); 
}	

//수정 submit
function onUpdate() {
	var formData = $("form[name=update]").serialize();
 	$.ajax({
		type : "post",
		url : "update",
		data : formData,
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function() {
			location.reload();//리로드
		}
	}); 
}

//삭제
function onDelete(data) {
	console.log("삭제 탔나?");
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

</script>

</head>

<body>
	<%-- nav ber 시작 --%>
	<div class="collapse" id="navbarToggleExternalContent">
	  <div class="bg-dark p-4">
	    <h5 class="text-white h4">유저 리스트</h5>
	  </div>
	</div> 
	<nav class="navbar navbar-dark bg-dark">
	  <div class="container-fluid">
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	  </div>
	</nav>
	<%-- nav ber 끝--%>
	<%-- 유저 리스트 --%>
	<div style="margin-top: 30px">
		<h2>유저 리스트</h2>
		<button type="button" class="btn btn-outline-primary" onclick="window.location='/main'">메인</button>
		<button type="button" class="btn btn-outline-primary" onclick="onSignup()">가입</button>
	</div>
	<div id="userlist"></div>
	
	
	<%--유저 리스트 시작 --%>
	<!--  
	<div style="margin-top: 30px">
		<h2>유저 리스트</h2>
		<button type="button" class="btn btn-outline-primary" onclick="window.location='/main'">메인</button>
		<button type="button" class="btn btn-outline-primary" onclick="onSignup()">가입</button>
	</div>
	<div>
		<table class="table table-striped">
			<tr>
				<td>id</td>
				<td>username</td>
				<td>password</td>
				<td>email</td>
				<td>삭제</td>
			</tr>
			<c:forEach var="list" items="${list.content}"> <%--Page로 리턴을 받는다면 오류!!! 그럴땐 list.content 라고 적어주면 해결--%>
			<tr>
				<td>${list.id}</td>
				<td><a href="javascript:void(0)" onclick="onDisplay(${list.id})">${list.username}</a></td>
				<td>${list.password}</td>
				<td>${list.email}</td>
				<td><button type="button" class="btn btn-outline-primary" onclick="onDelete(${list.id})">삭제</button></td>
			</tr>
			</c:forEach>
		</table>
		<%-- 페이징 --%>
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		      <%-- 이전 --%>
		      <c:choose> <%-- c:choose : 비교문  --%>
		      	<c:when test="${list.first}"></c:when><%--c:when : 데이터값이 true일때 실행 --%>
		      	<c:otherwise> <%-- c:otherwise : c:when에 해당하지 않을경우 여기문을 탄다 --%>
					<li class="page-item"><a class="page-link" href="list?page=0">처음</a></li>
					<li class="page-item"><a class="page-link" href="list?page=${list.number-1}">&larr;</a></li>
				</c:otherwise>
			</c:choose>
			<%-- 페이지 그룹 --%> 
			<c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i"> <%-- 시작번호부터 끝 번호까지 반복 --%>
				<c:choose>
					<c:when test="${list.pageable.pageNumber+1 == i}"> <%-- pageable.pageNumber+1이 i값과 같을때 실행 --%>
						<li class="page-item disabled"><a class="page-link" href="list?page=${i-1}">${i}</a></li>
					</c:when>
					<c:otherwise> <%-- 해당하지 않을때 실행 --%>
						<li class="page-item"><a class="page-link" href="list?page=${i-1}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<%-- 다음 --%> 
			<c:choose> 
				<c:when test="${list.last}"></c:when> <%-- list.last가 true일때 실행 --%>
				<c:otherwise> <%-- 해당하지 않을때 실행 --%>
					<li class="page-item "><a class="page-link" href="list?page=${list.number+1}">&rarr;</a></li>
					<li class="page-item "><a class="page-link" href="list?page=${list.totalPages-1}">마지막</a></li>
				</c:otherwise>
			</c:choose>
		  </ul>
		</nav>
	</div>
	-->
	<%--유저 리스트 끝 --%>
	
	<%-- 회원 가입 --%>
	<div id="signup" style="margin-top: 30px">
		<form name="signup" method="post">
		  <div class="mb-3">
		    <label for="exampleInputEmail1" class="form-label">아이디</label>
		    <input type="text" name="username" class="form-control" aria-describedby="emailHelp">
		  </div>
		  <div class="mb-3">
		    <label for="exampleInputPassword1" class="form-label">비밀번호</label>
		    <input type="password" name="password" class="form-control">
		  </div>
		  <div class="mb-3">
		    <label for="exampleInputPassword1" class="form-label">이메일</label>
		    <input type="text" name="email" class="form-control">
		  </div>
		  <button type="button" class="btn btn-outline-primary" onclick="onSubmit()">가입</button>
		</form>
	</div>
	
	<%-- 회원 수정 --%>
	<div id="update" style=" margin-top: 30px">
		<table class="table table-striped">
			<tr>
				<td>
					<form name="update" method="post">
						username : <input type="text" id="username" disabled="disabled"/>
						password : <input type="text" name="password" id="password" required />
						email : <input type="text" name="email" id="email" required />
						<input type="hidden" name="id" id="id"/>
						<button type="button" class="btn btn-outline-primary" onclick="onUpdate()">수정</button>
					</form>
				</td>
			</tr>
		</table>
	</div>
	
		<%-- <script type="text/javascript" src=""></script> --%>
</body>
</html>


