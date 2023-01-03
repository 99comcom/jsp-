<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	전체데이터수: <span>${count}</span>건
	<button id="insert" style="float:right;padding:5px 20px;">상품등록</button>
</div>
<table>
	<tr class="title">
		<td width=100>No.</td>
		<td width=100>이미지</td>
		<td width=300>제목</td>
		<td width=100>가격</td>
		<td width=100>브랜드</td>
		<td width=150>등록일</td>
	</tr>
	<c:forEach items="${array}" var="vo">
	<tr class="row">
		<td>${vo.id}</td>
		<td><img src="/image${vo.image}" width=70></td>
		<td>${vo.title}</td>
		<td><fmt:formatNumber value="${vo.price}" pattern="#,###원"/></td>
		<td>${vo.brand}</td>
		<td>${vo.wdate}</td>
	</tr>
	</c:forEach>
</table>
<div class="buttons">
	<form name="frm">
		<input type="hidden" name="page" value="${page}">
		<button id="prev" <c:out value="${page==1?'disabled':''}"/> >이전</button>
		<span>${page}/${last}</span>
		<button id="next" <c:out value="${page==last?'disabled':''}"/>>다음</button>
	</form>
</div>

<script>
	var page="${page}";
	
	$("#insert").on("click", function(){
		location.href="/shop/insert";	
	});
	
	$("#next").on("click", function(){
		page++;
		$(frm.page).val(page);
	})
	
	$("#prev").on("click", function(){
		page--;
		$(frm.page).val(page);
	})
</script>




    