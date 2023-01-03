<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<meta charset="UTF-8">
	<title>주소정보</title>
</head>
<body>
	<h1>주소정보</h1>
	<form name="frm" method="post">
		<input type="hidden" name="id" value="${vo.id}">
		<input type="text" name="name" value="${vo.name}">
		<hr>
		<input type="text" name="tel" value="${vo.tel}">
		<hr>
		<input type="text" name="address" value="${vo.address}" size=50>
		<hr>
		<button type="submit">주소수정</button>
		<button type="reset">수정취소</button>
	</form>
</body>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("내용을 수정하실래요?")) return;
		//수정
		frm.action="/update";
		frm.submit();
	})
</script>
</html>




