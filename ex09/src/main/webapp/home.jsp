<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="/css/home4.css">
	<link rel="stylesheet" href="/css/Lightbox.css">
	
	
	<style>
body {
  margin: 0;
}
#top{width: 100%;}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 20%;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}


li a:hover {
  background-color: rgb(43, 67, 255);
  color: white;

}


</style>
	
</head>

<body>
<ul>
	<img src="/img/12.png" id="top">
	<p style="font-size: 35px; text-align: center;">학사관리시스템<p>
  <li><a class="a" href="/"><p style="font-size: 20px; text-align: center;">홈</p></a></li>
  <li><a class="a" href="/pro/list"><p style="font-size: 20px; text-align: center;">교수관리</p></a></li>
  <li><a class="a" href="/stu/list"><p style="font-size: 20px; text-align: center;">학생관리</p></a></li>
  <li><a class="a" href="/cou/list"><p style="font-size: 20px; text-align: center;">강의관리</p></a></li>
  <li><a class="a" href="#"><p style="font-size: 20px; text-align: center;">성적관리</p></a></li>
</ul>



	<div id="mid">
		<jsp:include page="${pageName}"></jsp:include>
	</div>
	<div id="btm">
		<h3>Copyright 2022. 인천일보아카데미 All rights reserved</h3>
	</div>
</body>
</html>



