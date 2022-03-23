<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="2">
		<tr>
			<td>id</td>
			<td>createDate</td>
			<td>email</td>
			<td>password</td>
			<td>username</td>
		</tr>
		<c:forEach var="list" items="${list}">
		<tr>
			<td>${list.id}</td>
			<td>${list.createDate}</td>
			<td>${list.email}</td>
			<td>${list.password}</td>
			<td>${list.username}</td>
		</tr>	
		</c:forEach>
	</table>
	<button onclick="window.location='/main'">메인</button>
		
</body>
</html>