<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="submit" method="post">
		아이디 : <input type="text" name="username"/>
		비밀번호 : <input type="text" name="password"/>
		이메일 : <input type="text" name="email"/>
		전송 <input type="submit" value="전송"/>
	</form>
	
</body>
</html>