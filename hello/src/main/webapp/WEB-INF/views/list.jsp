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
});

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
		url : "modify", // 주소
		data : {id:id}, // id를 id라고 부르겠다?
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function(data){ // 성공했다면
		 	var username = data["username"]; // key값으로 꺼낸 value를 변수에 넣기
		 	var password = data["password"];// key값으로 꺼낸 value를 변수에 넣기
		 	var email = data["email"];// key값으로 꺼낸 value를 변수에 넣기
			
		 	$("#id").val(id);//username이라는 id값에 value에 변수넣기
		 	$("#username").val(username);//username이라는 id값에 value에 변수넣기
		 	$("#password").val(password);//password이라는 id값에 value에 변수넣기
		 	$("#email").val(email);//email이라는 id값에 value에 변수넣기
			
		}
	});  
}
//가입 submit
function onSubmit() {

	var formData = $("form[name=signup]").serialize();
	console.log("formData : " + formData);
 	$.ajax({
		type : "post",
		url : "submit",
		data : formData,
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function(data) {
			location.reload();//리로드
		}
			
	}); 
}	

//수정 submit
function onUpdate() {
	console.log("탔나?");
	var formData = $("form[name=update]").serialize();
	console.log("formData : " + formData);
 	$.ajax({
		type : "post",
		url : "update",
		data : formData,
		error : function(xhr, status, errer){ //에러가 났을경우
			alert(error);
		},
		success : function() {
			alert("123");
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
				<td>수정</td>
			</tr>
			<c:forEach var="list" items="${list.content}"> <%-- Page로 리턴을 받는다면 오류!!! 그럴땐 list.getcontent 라고 적어주면 해결 --%>
			<tr th:each="list : ${list}">
				<td>${list.id}</td>
				<td>${list.username}</td>
				<td>${list.password}</td>
				<td>${list.email}</td>
				<td><button type="button" class="btn btn-outline-primary" onclick="onDisplay(${list.id})">수정</button></td>
																		<%--onDisplay함수 호출 id값 매개변수로 넣어 보내기 --%>
			</tr>
			</c:forEach>
		</table>
		<%-- 페이징 --%>
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		      <%-- 이전 --%>
		      <c:choose><%-- c:choose : 비교문  --%>
		      	<c:when test="${list.first}"></c:when><%--c:when : 데이터값이 true일때 실행 --%>
		      	<c:otherwise><%-- c:otherwise : c:when에 해당하지 않을경우 여기문을 탄다 --%>
					<li class="page-item"><a class="page-link" href="list?page=0">처음</a></li>
					<li class="page-item"><a class="page-link" href="list?page=${list.number-1}">&larr;</a></li>
				</c:otherwise>
			</c:choose>
			<%-- 페이지 그룹 --%> 
			<c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i"> <%-- 시작블럭부터 끝 블럭까지 반복 --%>
				<c:choose>
					<c:when test="${list.pageable.pageNumber+1 == i}"><%-- pageable.pageNumber+1이 i값과 같을때 실행 --%>
						<li class="page-item disabled"><a class="page-link" href="list?page=${i-1}">${i}</a></li>
					</c:when>
					<c:otherwise><%-- 해당하지 않을때 실행 --%>
						<li class="page-item"><a class="page-link" href="list?page=${i-1}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<%-- 다음 --%> 
			<c:choose> 
				<c:when test="${list.last}"></c:when> <%-- list.last가 true일때 실행 --%>
				<c:otherwise><%-- 해당하지 않을때 실행 --%>
					<li class="page-item "><a class="page-link" href="list?page=${list.number+1}">&rarr;</a></li>
					<li class="page-item "><a class="page-link" href="list?page=${list.totalPages-1}">마지막</a></li>
				</c:otherwise>
			</c:choose>
		  </ul>
		</nav>
	</div>
	
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
						<button type="button" class="btn btn-outline-primary" onclick="onUpdate()">가입</button>
					</form>
				</td>
			</tr>
		</table>
	</div>
	
	
	
	
	
	
	
	
		<%-- <script type="text/javascript" src=""></script> --%>
</body>
</html>


