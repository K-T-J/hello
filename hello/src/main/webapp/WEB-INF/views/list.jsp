<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"><%-- bootstrap --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script><%-- jquery --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script> <%-- js --%>
<script type="text/javascript" src="resources/js/list.js"></script><%--list.js 링크 --%>

<script type="text/javascript">
//페이지 로딩될때
$(document).ready(function() {
	$("#update").hide();//페이지 로딩될때 안보이게 설정
	$("#signup").hide();//페이지 로딩될때 안보이게 설정
 	$("#userlist").show() //페이지 로딩될때 userlist 보이게 설정
	list(0);//페이지 로딩될때 list() 함수 호출하면서 page=0을 같이 넣어서 보내기
});
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


