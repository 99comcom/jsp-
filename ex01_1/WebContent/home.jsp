<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>주소관리</title>
	<link rel="stylesheet" href="../css/home.css"/>
</head>
<body>
	<div id="top">
		<img src="back.png" width=960>
	</div>
	<div id="menu">
		<span class="item"><a href="/">Home</a></span>
		<span class="item"><a href="/list">주소관리</a></span>
	</div>
	<div id="middle">
		<jsp:include page="${pageName}"/>
	</div>
	<div id="bottom">
		<h3>Copyright 2022. 인천일보아카데미 All rights Reserved.</h3>
	</div>
</body>
</html>