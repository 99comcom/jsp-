<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<style>
#info{overflow: hidden;}
#image{float:left;padding-right: 20px}
#content{float:left; border-left: 1px dotted gray;margin-left: 20px;padding-left: 20px}
.price2{text-decoration: line-through; margin-bottom: 5px}
.status{font-size: 15px;color: red;}

h2, h3{margin-bottom: 20px}
#cart {font-size:20px;  width: 230px; padding:20px 0px; 
float:left; text-align:center; cursor: pointer; 
background: #006AA7; color: rgb(254, 203, 0); }

#buy {font-size:20px;  width: 230px;padding:20px 0px; 
float:left; text-align:center; cursor: pointer; 
background: rgb(254, 203, 0); color: #006AA7; }




</style>
<h1>상품정보</h1>
<div id="info">
	<div id="image">
		<img src="/image/shop/${vo.image}" width=400>
	</div>
	<div id="content">
		<h2>
				${vo.prod_id}
		<span class="status"><c:out value="${vo.prod_del=='1' ? '판매중지' : ''}"/></span>

		</h2>
		<h2>${vo.prod_name}</h2>
		<h3 class="price2" style="border-top: 1px solid gray;"><span>일반가:</span><fmt:formatNumber value="${vo.price1}" pattern="#,###"/>원</h3>
		<h2 class="price1" style="border-bottom : 1px solid gray;"><span>판매가:</span><fmt:formatNumber value="${vo.price2}" pattern="#,###"/>원</h2>
		<h3>판매처:${vo.mall_name} / ${vo.mall_id}</h3>
		<h3>제조사:${vo.company}</h3>
		
		<div style="overflow: hidden;">
			<div id="buy">구매하기</div>
			<div id="cart">장바구니</div>
		</div>
	</div>
</div>

<script>
var status="${vo.prod_del}";
var prod_id="${vo.prod_id}";

$("#buy").on("click", function(){
	if(status=='1'){
		alert("팬매중지된 상품입니다.")
		return;
	}
})

	$("#cart").on("click", function(){
	if(status=='1'){
		alert("팬매중지된 상품입니다.")

	}
	
	$.ajax({
		type:"get",
		url:"/cart/insert",
		data:{id:prod_id},
		success:function(){
			if(!confirm("장바구니로 이동하시겠습니까?"))return;
			location.href="/cart/list";
			
		}
	})
})


</script>