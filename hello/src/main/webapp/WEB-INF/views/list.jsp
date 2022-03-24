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
$(document).ready(function() {
	$("#update").hide();//페이지 로딩될때 안보이게 설정
});

function onDisplay(data) {
	
	$("#update").show();//보여주기
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

</script>

</head>

<body>
	<!-- nav ber 시작 -->
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
	<!-- nav ber 끝-->
	<div style="margin-top: 30px">
		<h2>유저 리스트</h2>
		<button type="button" class="btn btn-outline-primary" onclick="window.location='/main'">메인</button>
	</div>
	<div>	
		<!--<form action="modify" method="post" id="inputForm"> -->
		<table class="table table-striped">
			<tr>
				<td>id</td>
				<td>username</td>
				<td>password</td>
				<td>email</td>
				<td>수정</td>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr>
				<td>${list.id}</td>
				<td>${list.username}</td>
				<td>${list.password}</td>
				<td>${list.email}</td>
				<td><button type="button" class="btn btn-outline-primary" onclick="onDisplay(${list.id})">수정</button></td>
																		<!--onDisplay함수 호출 id값 매개변수로 넣어 보내기 -->
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 회원 수정 -->
	
	<div id="update" style="margin-top: 30px">
		<table class="table table-striped">
			<tr>
				<td>
					<form action="update" method="post">
						username : <input type="text" name="username" id="username"/>
						password : <input type="text" name="password" id="password" />
						email : <input type="text" name="email" id="email" />
						<input type="hidden" name="id" id="id"/>
						<input type="submit" value="수정"/>
					</form>
				</td>
			</tr>
		</table>
	</div>
	
	
	
	
	
	
	
	
		<!-- <script type="text/javascript" scr=""></script> -->
</body>
</html>


