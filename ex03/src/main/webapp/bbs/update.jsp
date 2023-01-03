<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>게시글 수정</h1>
<form name="frm" method="post">
<input type="hidden" name="no" value="${vo.no}">
	<table>
		<tr>
			<td>
				<input type="text" name="title" size="95" value="${vo.title}" >
			</td>
		</tr>
		<tr>
			<td>
				<textarea rows="10" cols="78" name="content">${vo.content}</textarea>
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	</div>

</form>

<script>

	$(frm).on("submit", function(e){
		e.preventDefault();
		
		//유효성 체크
		var title=$(frm.title).val();
		var content=$(frm.content).val();
		
		if(title==""){
			alert("제목을 입력하세요 ");
			$(frm.title).focus();
			return;
			
		}
		
		if(content==""){
			alert("내욜을  입력하세요 ");
			$(frm.content).focus();
			return;
			
		}
		if(!confirm("내용을 저장하실래요?"))return;
		frm.submit();
		
	});

</script>