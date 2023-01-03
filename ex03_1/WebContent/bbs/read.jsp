<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>게시글 정보</h1>
<table width=800>
	<tr>
		<td><b>[${vo.no}]</b> ${vo.title}</td>
	</tr>
	<tr>
		<td>${vo.wdate} (<b>${vo.writer}</b>)</td>
	</tr>
	<tr>
		<td>${vo.content}</td>
	</tr>
</table>
<div class="buttons">
	<button onclick="location.href='/bbs/update?no=${vo.no}'">게시글수정</button>
	<button id="delete">게시글삭제</button>
</div>

<script>
	$("#delete").on("click", function(){
		var no="${vo.no}";
		if(!confirm(no + "번을 삭제하실래요?")) return;
		location.href="/bbs/delete?no=" + no;
	});
</script>



