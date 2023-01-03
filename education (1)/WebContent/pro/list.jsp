<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>교수목록</h1>
<div>
	검색 수 : <span id = "count"></span>
</div>
<div>
	<form name = "frm">	
		<select name = "key" id = "key">
			<option value = "pcode">교수번호</option>
			<option value = "pname">교수이름</option>
			<option value = "dept">교수학과</option>
		</select>
		<input type = "text" id = "word" placeholder = "검색어">
		<select name = "per" id = "per">
			<option value = "2">2행</option>
			<option value = "3">3행</option>
			<option value = "5" selected>5행</option>
			<option value = "10">10행</option>
		</select>
		<button>검색</button>
		<div style = "float: right;">
			<select name = "order" id = "order">
				<option value = "pcode">교수번호</option>
				<option value = "pname">교수이름</option>
				<option value = "dept">교수학과</option>
			</select>
			<select name = "desc" id = "desc">
				<option value = "asc">오름차순</option>
				<option value = "desc">내림차순</option>
			</select>
			<a href = "/pro/insert" style="margin-left: 20px;"><button type = "button">교수등록</button></a>
		</div>
	</form>
	
</div>
<table id = "tbl"></table>
<script id = "temp" type = "text/x-handlebars-template">
	<tr class = "title">
		<td width = 100>교수번호</td>
		<td width = 150>교수이름</td>
		<td width = 100>교수학과</td>
		<td width = 100>교수직급</td>
		<td width = 200>임용일자</td>
		<td width = 200>급여</td>
	</tr>
	{{#each array}}
	<tr class = "row" style = "text-align: center;" onclick = "location.href='/pro/read?pcode={{pcode}}'">
		<td class = "pcode">{{pcode}}</td>
		<td class = "pname">{{pname}}</td>
		<td class = "dept">{{dept}}</td>
		<td class = "ptitle">{{title}}</td>
		<td class = "hiredate">{{hiredate}}</td>			
		<td class = "salary">{{salary}}</td>			
	</tr>
	{{/each}}
</script>

<div class = "buttons" style = "text-align: center; margin-top: 20px;">
	<button id = "prev">이전</button>
	<span id = "page">1/10</span>
	<button id = "next">다음</button>
</div>

<script>
	var page = 1;
	getList();
	
	$("#next").on("click", function() {
		page++;
		getList();
	});
	
	$("#prev").on("click", function() {
		page--;
		getList();
	});
	
	$("#per, #order, #desc").on("change", function() {
		page = 1;
		getList();
	});
	
	$(frm).on("submit", function(e) {
		e.preventDefault();
		page = 1;
		getList();
	});
	
	function getList() {
		var key = $(frm.key).val();
		var word = $(frm.word).val();
		var per = $(frm.per).val();
		var order = $(frm.order).val();
		var desc = $(frm.desc).val();
		
		$.ajax ({
			type : "get",
			url : "/pro/list.json",
			dataType : "json",
			data : {key : key, word : word, per : per, order : order, desc : desc, page : page},
			success: function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.total);
				
				if(data.total == 0) {
					$("#tbl").append("<tr><td colspan = 6 class = 'none' style = 'text-align: center; color: red;'> 검색된 자료가 없습니다! </td></tr>");
					$(".buttons").hide();
				} 
				else {
					$("#page").html(page + "/" + data.last);
					
					if(page == 1) {
						$("#prev").attr("disabled", true);
					}
					else {
						$("#prev").attr("disabled", false);
					}
					
					if(page == data.last) {
						$("#next").attr("disabled", true);
					}
					else {
						$("#next").attr("disabled", false);
					}
					$(".buttons").show();
				}
				
				
				
			}
		});
	}
</script>