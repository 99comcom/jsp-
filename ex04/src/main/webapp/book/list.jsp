<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h1>도서목록</h1>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
   <tr class="title">
      <td width="100">Image</td>
      <td width="300">Title</td>
      <td width="200">Authors</td>
      <td width="100">Price</td>
      <td width="200">Date</td>
   </tr>
   {{#each array}}
   <tr class="row" isbn="{{isbn}}">
      <td><img src="{{image}}" contents="{{contents}}" width=70 class="thum"></td>
      <td class="subject">{{title}}</td>
      <td class="authors">{{authors}}</td>
      <td class="price">{{price}}</td>
      <td class="wdate">{{fdate}}</td>
   </tr>
   {{/each}}
</script>
<script>
   Handlebars.registerHelper("image", function(thum){
      if(thum) return thum
      else return "https://via.placeholder.com/70x100";;
   })
</script>

<div class="buttons">
   <button id="prev">이전</button>
   <span id="page">1/10</span>
   <button id="next">다음</button>
</div>

<div id="background">
	<div id="Lightbox">
		<div>
			<img src="" id="image" width=500>
			<p id="contents"></p>
		</div>	
		<div>
		<button id="close">닫기</button>
		</div>
	
	</div>

</div>

<script>

var page=1;
getList();

//닫기 버튼을 클릭한 경우
$("#close").on("click", function () {
	   $("#background").hide();
	
})



//각행의 이미지를 클릭한 경우
    $("#tbl").on("click", ".row .thum",function(){
		   var thum=$(this).attr("src");
		   var contents=$(this).attr("contents");
		   $("#image").attr("src", thum)
		   $("#contents").html(contents);
		   $("#background").show();
		   
})


function getList(){
 
    $.ajax({
       type:"get",
       url:"/book/list.json",
       dataType:"json",
       data:{page:page},
       success:function(data){
          var temp=Handlebars.compile($("#temp").html());
          $("#tbl").html(temp(data));
          $("#count").html(data.count);
          
          var last=Math.ceil(data.count/5);
          $("#page").html(page + "/" + last)
          
          if(page==1) $("#prev").attr("disabled", true);
          else $("#prev").attr("disabled", false);
          
          if(page==last) $("#next").attr("disabled", true);
          else $("#next").attr("disabled", false);

       }
    })
 }
</script>