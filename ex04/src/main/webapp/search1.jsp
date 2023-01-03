<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
   #condition {overflow:hidden;}
   #condition #save{float:left;}
   #condition form {float:right;}
   #condition button {padding:5px 20px;}
</style>    
<h1>도서검색</h1>
<div id="condition">
   <button id="save">선택저장</button>
   <form name="frm">
      <input type="text" name="query" value="자바">
      <button>검색</button>
      검색수: <span id="count"></span>권
   </form>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td><input type="checkbox" id="chkAll"></td>
		<td width="100">이미지</td>
		<td width="350">제목</td>
		<td width="100">저자</td>
		<td width="200">가격</td>
		<td width="200">출판사</td>
	</tr>
	{{#each documents}}
	<tr class="row">
		<td><input type="checkbox" class="chk"></td>
		<td><img src="{{thumbnail}}" contents="{{contents}} width=70 class="thum"></td>
		<td class="subject">{{title}}</td>
		<td class="authors"> {{authors}} </td>
		<td class="price"> {{price}}원 </td>
		<td class="publisher">{{publisher}}</td>
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
	<button id="perv">이전</button>
	<span id="page"> 1/10 </span>
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
   var size=5;
   var query="김미영";
   
   //닫기 버튼을 클릭한 경우
   $("#close").on("click", function () {
	   $("#background") hide();
	
})
   
   
   //각행의 이미지를 클릭한 경우
       $("#tbl").on("click", ".row .thum",function(){
	   var image=$(this).attr("src");
	   var contents=$(this).attr("contents");
	   $("#image").attr("src", thum )
	   $("#contents").html(contents);
	   $("#background").show();
	   
   })
   
   
      function getList(){
      query=$(frm.query).val();
      $.ajax({
         type:"get",
         url:"https://dapi.kakao.com/v3/search/book?target=title",
         dataType:"json",
         headers:{"Authorization":"KakaoAK 5bbeb6dc555dfbbd4b564634b38277e6"},
         data:{page:page, size:size, query:query},
         success:function(data){
            var temp=Handlebars.compile($("#temp").html());
            $("#tbl").html(temp(data));
            $("#count").html(data.meta.pageable_count);
            var last=Math.ceil(data.meta.pageable_count/5);
            $("#page").html(page)
            
            if(page==1) $("#prev").attr("disabled", true);
            else $("#prev").attr("disabled", false);
            
            if(data.meta.is_end==true) $("#next").attr("disabled", true);
            else $("#next").attr("disabled", false);
         }
      })
   }
</script>