<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>영화등록</h1>
<form name="frm" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>영화제목</td>
			<td><input type="text" name="title" size=80></td>
		</tr>
		<tr>
			<td>영화배우</td>
			<td><input type="text" name="actor" size=80></td>
		</tr>
		<tr>
			<td>영화감독</td>
			<td><input type="text" name="director" size=20></td>
		</tr>
		<tr>
			<td>제작년도</td>
			<td><input type="text" name="pubDate" value="2022" size=4></td>
		</tr>
		<tr>
			<td>포스터</td>
			<td>
				<img id="image" src="https://dummyimage.com/110x157/bab6ba/FFFFFF" width=110>
				<input type="file" name="image" style="display:none;"> 
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button>영화등록</button>
		<button type="reset">등록취소</button>
	</div>
</form>
<script>
	$("#image").on("click", function(){
		$(frm.image).click();	
	});
	
	//이미지 미리보기
	$(frm.image).on("change", function(e){
		var reader = new FileReader();
		reader.readAsDataURL(this.files[0]);
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
	})
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		var title=$(frm.title).val();
		var image=$(frm.image).val();
		
		if(title==""){
			alert("제목을 입력하세요!");
			$(frm.title).focus();
			return;
		}
		
		if(image==""){
			alert("등록할 영화 포스터를 선택하세요!");
			return;
		}
		if(!confirm("영화를 등록하실래요?")) return;
		frm.submit();
	})
</script>

