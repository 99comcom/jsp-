<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>사용자정보</h1>
<form name="frm" method="post">
	<table width=900>
		<tr>
			<td> <b>[${vo.no}]]</b> ${vo.title}</td>
		
		
			<td style="float:right: ; "> <b>[${vo.wdate}]]</b> ${vo.writer}</td>
			
		</tr>
		<tr>
			<td>${vo.content}]</td>
		</tr>
	</table>
	<div class="buttons">
		<button type="button" onclick="location.href='/bbs/update?no=${vo.no}'">게시글수정</button>
		<button type="button"  id="delete">게시글삭제</button>
	</div>
</form>
<script>
	$("#delete").on("click", function () {
		var no="${vo.no}";
		if(!confirm(no+"번을 삭제하실래요?")) return;
		location.href="/bbs/delete?no="+no;
		
		
	})
</script> 
