<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>사용자정보</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100>아이디</td>
			<td>
				<input type="text" name="id" value="${vo.id}" readonly>
			</td>
		</tr>
		<tr>
			<td width=100>비밀번호</td>
			<td>
				<input type="password" name="password" value="${vo.password}">
			</td>
		</tr>
		<tr>
			<td width=100>이름</td>
			<td>
				<input type="text" name="name" value="${vo.name}">
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">사용자수정</button>
		<button type="reset">수정취소</button>
	</div>
</form>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var password=$(frm.password).val();
		var name=$(frm.name).val();
		
		if(password==""){
			alert("비밀번호를 입력하세요!");
			$(frm.password).focus();
			return;
		}
		
		if(name==""){
			alert("이름을 입력하세요!");
			$(frm.name).focus();
			return;
		}
		
		if(!confirm("사용자정보를 수정하실래요?")) return;
		
		//사용자수정
		frm.action="/users/update";
		frm.submit();
	});
</script>
















