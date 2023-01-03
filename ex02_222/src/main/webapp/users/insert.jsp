<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>사용자등록</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100>아이디</td>
			<td>
				<input type="text" name="id">
				<button type="button" id="check">중복체크</button>
			</td>
		</tr>
		<tr>
			<td width=100>비밀번호</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr>
			<td width=100>이름</td>
			<td>
				<input type="text" name="name">
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">사용자등록</button>
		<button type="reset">등록취소</button>
	</div>
</form>
<script>
	var check=false;
	
	$(frm.id).on("change", function(){
		check=false;
	});
	
	$("#check").on("click", function(){
		var id=$(frm.id).val();
		if(id==""){
			alert("아이디를 입력하세요!");
			$(frm.id).focus();
			return;
		}
		//중복체크
		$.ajax({
			type:"get",
			url:"/idcheck",
			data:{id:id},
			dataType:"json",
			success:function(data){
				if(data.id==null){
					alert("사용이 가능한 아이디입니다.");
					check=true;
				}else{
					alert("이미 사용중인 아이디입니다.")
				}
			}
		})
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		var id=$(frm.id).val();
		var password=$(frm.password).val();
		var name=$(frm.name).val();
		
		if(id==""){
			alert("아이디를 입력하세요!");
			$(frm.id).focus();
			return;
		}
		
		if(check==false){
			alert("중복체크를 하세요!");
			return;
		}
		
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
		
		if(!confirm("사용자를 등록하실래요?")) return;
		
		//사용자등록
		frm.submit();
	});
</script>
















