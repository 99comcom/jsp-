<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>상품등록	</h1>

<form name="frm" method="post" enctype="multipart/form-data">

	<table>
		<tr>
			<td>상품아이디</td>
			<td><input type="text" name="id" value="${newId}" readonly="readonly"></td>
		</tr>
		<tr>
			<td>상품이름</td>
			<td><input type="text" name="title"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="price"></td>
		</tr>
		<tr>
			<td>브랜드명</td>
			<td><input type="text" name="baand"></td>
		</tr>
		<tr>
			<td>상품이미지</td>
			<td><img src="https://dummyimage.com/150x120/bab6ba/000000" width=150 id="image">
				<input type="file" name="image" >
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button>상품등록</button>
		<button type="reset">등록취소</button>
	</div>
</form>
<script>


$(frm).on("submit",function(e){
	e.preventDefault();
	var title=$(frm.title).val();
	var price=$(frm.price).val();
	var brand=$(frm.brand).val();
	var image=$(frm.image).val();
	
	if(title==""){
		alert("제목을 입력하세요 ")
		$(frm.title).focus();
		return;
	}
	if(price==""){
		alert("가격을 입력하세요 ")
		$(frm.price).focus();
		return;
	}
	if(brand==""){
		alert("브랜드명을 입력하세요 ")
		$(frm.brand).focus();
		return;
	}
	if(image==""){
		alert("사진을 입력하세요 ")
		return;
	}
	if(!confirm("상품을 등록하실래요?"))return;
	frm.action="/shop/register";
	frm.submit();
	
})


$("#image").on("click",function(){
	$(frm.image).click();	
})

//이미지미리보기
$(frm.image).on("change" , function(e) {
	var reader=new FileReader();
	reader.readAsDataURL(this.files[0]);
	reader.onload=function(e){
		$("#image").attr("src",e.target.result);
	}
	
})

</script>