<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"><!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script> <!-- js -->
</head>
<body>
	<!-- nav ber 시작 -->
	<div class="collapse" id="navbarToggleExternalContent">
	  <div class="bg-dark p-4">
	    <h5 class="text-white h4">메인</h5>
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
	<!--메인 시작  -->
	 <div class="px-4 py-5 my-5 text-center">
	    <img class="d-block mx-auto mb-4" src="/resources/imgs/img.svg" alt="" width="72" height="57">
	    <h1 class="display-5 fw-bold">메인 페이지</h1>
	    <div class="col-lg-6 mx-auto">
	      <p class="lead mb-4">Quickly design and customize responsive mobile-first sites with Bootstrap, the world’s most popular front-end open source toolkit, featuring Sass variables and mixins, responsive grid system, extensive prebuilt components, and powerful JavaScript plugins.</p>
	      <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
	        <button type="button" class="btn btn-primary btn-lg px-4 gap-3" onclick="window.location='/list'">리스트</button>
	      </div>
	    </div>
	  </div>
	<!--메인 끝  -->
</body>
</html>