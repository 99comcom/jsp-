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
      <input type="text" name="query" value="이말년">
      <button>검색</button>
      검색수: <span id="count"></span>권
   </form>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
   <tr class="title">
      <td><input type="checkbox" id="chkAll"></td>
      <td width="100">Image</td>
      <td width="300">Title</td>
      <td width="200">Authors</td>
      <td width="100">Price</td>
      <td width="200">Publisher</td>
   </tr>
   {{#each documents}}
   <tr class="row" isbn="{{isbn}}">
      <td><input type="checkbox" class="chk"></td>
      <td><img src="{{image thumbnail}}" contents="{{contents}}" width=70 class="thum"></td>
      <td class="subject">{{title}}</td>
      <td class="authors">{{authors}}</td>
      <td class="price">{{price}}</td>
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
   var size=5;
   var query="김미영";
   
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
   
   
   //선택버튼을 클릭한 경우
   $("#save").on("click", function(){
      var chk=$("#tbl .row .chk:checked").length;
      if(chk==0){
         alert("저장할 도서들을 선택하세요!");
         return;
      }
      
      if(!confirm(chk + "권의 도서를 저장하실래요?")) return;
      
      //반복저장
      $("#tbl .chk:checked").each(function(){
         var row=$(this).parent().parent();
         var thum=row.find(".thum").attr("src");
         var title=row.find(".subject").html();
         var authors=row.find(".authors").html();
         var price=row.find(".price").html();
         var publisher=row.find(".publisher").html();
         var contents=row.find(".thum").attr("contents");
         var isbn=row.attr("isbn");
         
         //저장하기
         $.ajax({
        	 type:"post",
        	 url:"/book/insert",
        	 data:{title:title ,contents:contents, isbn:isbn,  image:thum ,publisher:publisher, authors:authors , price:price},
        	 success:function(){}
       
         });
      });
      alert("등록을 완료했습니다.")
      getList();
   });
   
   //전체선택 체크박스를 클릭한 경우
   $("#tbl").on("click", "#chkAll", function(){
      if($(this).is(":checked")){ //체크O
         $("#tbl .chk").each(function(){
            $(this).prop("checked", true);
         })
      }else { //체크X
         $("#tbl .chk").each(function(){
            $(this).prop("checked", false);
         })
      }
   });
   
   //각행의 체크박스를 클릭한 경우
   $("#tbl").on("click", ".chk", function(){
      var all=$("#tbl .row .chk").length;
      var chk=$("#tbl .row .chk:checked").length;
      
      if(all==chk) $("#chkAll").prop("checked", true);
      else $("#chkAll").prop("checked", false);
   });
   
   $(frm).on("submit", function(e){
      e.preventDefault();
      page=1;
      getList();
   });
   
   $("#next").on("click", function(){
      page++;
      getList();
   });
   
   $("#prev").on("click", function(){
      page--;
      getList();
   });
   
   getList();
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