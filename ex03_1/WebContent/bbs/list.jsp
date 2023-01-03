<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>게시판목록</h1>
<div style="padding-left:10px;">

	<select id="type">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
	</select>
	<input id="query" type="text" placeholder="검색어">
	<button id="search" style="padding:5px 20px;">검색</button>
	
	검색글수: <span id="count"></span>
	<button style="float:right;" onclick="location.href='/bbs/insert'">글쓰기</button>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=70>No.</td>
		<td width=500>제목</td>
		<td width=200>날짜</td>
		<td width=100>글쓴이</td>
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
<div class="buttons">
	<button id="prev">이전</button>
	<span id="page">1/10</span>
	<button id="next">다음</button>
</div>

<script>
	var page=1;
	getList();
	
	$("#search").on("click", function(){
		page=1;
		getList();
	});
	
	$("#query").on("keydown", function(e){
		if(e.keyCode==13) $("#search").click();	
	});
	
	
	function getList(){
		var type=$("#type").val();
		var query=$("#query").val();	
		
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			data:{page:page, type:type, query:query},
			dataType:"json",
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.count);
				
				var last=Math.ceil(data.count/5);
				$("#page").html(page + "/" + last);
				
				if(page==1) $("#prev").attr("disabled",true);
				else $("#prev").attr("disabled",false);
				
				if(page==last) $("#next").attr("disabled",true);
				else $("#next").attr("disabled",false);
	
			}
		})	
	}
	
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		page--;
		getList();
	});
</script>








