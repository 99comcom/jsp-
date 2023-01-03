<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>홍길동의 홈페이지</title>
	<link rel="stylesheet" href="/css/home.css">
	<link rel="stylesheet" href="/css/lightbox.css">
</head>
<body>
	<div id="top">
		<img src="/img/back.png" width=960>
	</div>
	<div id="menu">
		<span class="item"><a href="/">Home</a></span>
		<span class="item"><a href="/movie/search">영화검색</a></span>
		<span class="item"><a href="/movie/list">영화목록</a></span>
		<span class="item"><a href="/crawl/cgv">무비챠트</a></span>
		<span class="item"><a href="/crawl/news">증권뉴스</a></span>
		<span class="item"><a href="/crawl/best">베스트웹툰</a></span>
	</div>
	<div id="middle">
		<jsp:include page="${pageName}"></jsp:include>
	</div>
	<div id="bottom">
		<h3>Copyright 2022. 인천일보아카데미 All rights reserved</h3>
	</div>
</body>
</html>