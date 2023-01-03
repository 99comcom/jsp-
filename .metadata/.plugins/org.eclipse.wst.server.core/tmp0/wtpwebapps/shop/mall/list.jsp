<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
	#condition{overflow: hidden;}
	#condition form{float: left;}
	#condition #right{float: right;}
	#condition button {padding: 5px 10px;}
	
</style>
<h1>업체목록</h1>

<div id="condition">
	<form name="frm">
		<select id="key">
			<option value="mall_id">업체코드</option>
			<option value="mall_name">업체이름</option>
			<option value="address">업체주소</option>
			<option value="tel">업체번호</option>
		</select>
		<input type="text" id="word" placeholder="검색어">
		<select id="per">
			<option value="2">2행</option>
			<option value="7">7행</option>
			<option value="10" selected>10행</option>
			<option value="15">15행</option>
		</select>
		<button>검색</button>검색수:<span id="total"></span>
	</form>
	<div id="right">
		<select id="order">
			<option value="mall_id">업체코드</option>
			<option value="mall_name">업체이름</option>
			<option value="address">업체주소</option>
			<option value="tel">업체번호</option>
		</select>
		<select id="desc">
			<option value="asc">오름차순</option>
			<option value="desc">내림차순</option>
		</select>
	</div>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
   <tr class="title">
      <td width=100>업체코드</td>
      <td width=250>업체이름</td>
      <td width=150>관리자</td>
      <td width=350>업체주소</td>
      <td width=200>업체번호</td>
      <td width=200>이메일</td>
   </tr>
   {{#each array}}
   <tr class="row" onclick="location.href='/mall/read?mall_id={{mall_id}}'">
      <td>{{mall_id}}</td>
      <td>{{mall_name}}</td>
      <td>{{manager}}</td>
      <td>{{address}}</td>
      <td>{{tel}}</td>
      <td>{{email}}</td>
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
			url:"/mall/list.json",
			data:{key:key,word:word,per:per,order:order,desc:desc, page:page},
			dataType:"json",
			success:function(data){
				 var temp=Handlebars.compile($("#temp").html());
		         $("#tbl").html(temp(data));
		         $("#total").html(data.total);
		            if(data.total==0){
		               $("#tbl").append("<tr><td colspan=6 class='none'>검색된 업체가 없습니다!</td></tr>");
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