<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<style>
	#condition{overflow: hidden;}
	#condition form{float: left;}
	#condition #right{float: right;}
	#condition button {padding: 5px 10px;}
	
</style>
<h1>상품목록</h1>

<div id="condition">
	<form name="frm">
		<select id="key">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품명</option>
			<option value="company">업체명</option>
			<option value="detail">제조사</option>
			<option value="price1">가격</option>
		</select>
		<input type="text" id="word" placeholder="검색어">
		<select id="per">
			<option value="2">2행</option>
			<option value="5"selected>5행</option>
			<option value="10" >10행</option>
			<option value="15">15행</option>
		</select>
		<button>검색</button>검색수:<span id="total"></span>
	</form>
	<div id="right">
		<select id="order">
			<option value="prod_id" selected>상품코드</option>
			<option value="prod_name">상품명</option>
			<option value="company">업체명</option>
			<option value="detail">제조사</option>
			<option value="price2">가격</option>
		</select>
		<select id="desc">
			<option value="asc">오름차순</option>
			<option value="desc" selected>내림차순</option>
		</select>
	<a href="/pro/insert"><button>상품등록</button></a>
	</div>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
   <tr class="title">
      <td width=100>이미지</td>
      <td width=100>상품코드</td>
      <td width=400>상품명</td>
      <td width=100>상품가격</td>
      <td width=100>제조사</td>
 	  <td width=300>업체코드</td>
   </tr>
   {{#each array}}
   <tr class="row" onclick="location.href='/pro/read?prod_id={{prod_id}}'">
	<td><img src="/image/shop/{{image}}" width=80></td>
	<td>{{prod_id}}</td>
	<td>{{prod_name}}</td>
	<td>{{price1}}</td>
	<td>{{company}}</td>
	<td>{{mall_id}}/ {{mall_name}}</td>
   </tr>
   {{/each}}
</script>
<div class="buttons">
   <button id="prev">이전</button>
   <span id="page">1/10</span>
   <button id="next">다음</button>
</div>

<script>
	var page=1;
	getList();
	   
	   $("#next").on("click", function(){
	      page++;
	      getList();
	   });
	   
	   $("#prev").on("click", function(){
	      page--;
	      getList();
	   });
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		page=1;
		getList();
		
	})
	
	$("#per,#order,#desc").on("change",function(){
		getList();
	})
	function getList() {
		var key=$("#key").val();
		var word=$("#word").val();
		var per=$("#per").val();
		var order=$("#order").val();
		var desc=$("#desc").val();
		
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{key:key,word:word,per:per,order:order,desc:desc, page:page},
			dataType:"json",
			success:function(data){
				 var temp=Handlebars.compile($("#temp").html());
		         $("#tbl").html(temp(data));
		         $("#total").html(data.total);
		            if(data.total==0){
		               $("#tbl").append("<tr><td colspan=6 class='none'>검색된 상품이 없습니다!</td></tr>");
		               $(".buttons").hide();
		            }else{
		               $("#page").html(page + "/" + data.last);
		               
		               if(page==1) $("#prev").attr("disabled", true);
		               else $("#prev").attr("disabled", false);
		               
		               if(page==data.last) $("#next").attr("disabled", true);
		               else $("#next").attr("disabled", false);
		               $(".buttons").show();
		            }
		         }
		      })
		   }

</script>