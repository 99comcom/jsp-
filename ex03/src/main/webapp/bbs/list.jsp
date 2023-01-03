<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>게시판목록</h1>

<h4>전체게시글수 : <h4 id=count></h4></h4>
<span><button style="float:  right; "onclick="location.href='/bbs/insert'">글쓰기</button></span>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
	 <td width=100>No.</td>
	 <td width=600>Title.</td>
	 <td width=200>Date.</td>
	 <td width=100>Writer.</td>
	</tr>
{{#each array}}
	<tr class="row" onclick="location.href='/bbs/read?no={{no}}'">
	 <td>{{no}}</td>
	 <td>{{title}}</td>
	 <td>{{wdate}}</td>
	 <td>{{writer}}</td>
	</tr>	
{{/each}}
</script>
<div id="sell">
	<select id="type"  style="text-align:center;">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
	</select>
	<input id="query" type="text" size="50" placeholder="검색어">
	<button id="search" style="pause: 5px 0px;text-align:center;">검색</button>
</div>
<div class="buttons">
	<button id="prev">이전</button>
	<span id="page">1/10</span>
	<button id="next">다음</button>
</div>


<script>

var page=1;
getList();

$("#search").on("click", function () {
	page=1;
	getList();
	
})

$("#query").on("keydown", function (e) {
	if(e.keyCode==13) $("#search").click();
	
})


$("#prev").on('click',function(){
	page--;
	getList();
	
})

$("#next").on('click',function(){
	page++;
	getList();
	
})



function getList(){
	var type=$("#type").val();
	 var query=$("#query").val(); 


		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			dataType:"json",
			data:{page:page,type:type,query:query},
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.count + "건")
				
				var last=Math.ceil(data.count/3);
				$("#page").html(page+"/"+last);
				
				if(page==1) $("#prev").attr("disabled",true);
				else $("#prev").attr("disabled",false);
				
				if(page==last) $("#next").attr("disabled",true);
				else $("#next").attr("disabled",false);
		}	
	})
}


</script>