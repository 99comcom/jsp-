<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.tit {
    	background:gray;
    	color:white;
    	text-align: center;
	}
	td {
		border: 1px solid black;
	}
	button {
		background: gray;
	}
</style>
<h1>교수정보</h1>
<form name = "frm" method = "post">
	<table>
		<tr>
			<td width = 100 class = "tit">교수번호</td>
			<td width = 100><input type = "text" name = "pcode" size = 5 value = "${vo.pcode}" readonly></td>
			<td width = 100 class = "tit">교수학과</td>
			<td width = 200>
				<select name = "dept">
					<option value = "전산" <c:out value = "${vo.dept == '전산' ? 'selected' : ''}"/>>컴퓨터공학과</option>
					<option value = "전자" <c:out value = "${vo.dept == '전자' ? 'selected' : ''}"/>>전자공학과</option>
					<option value = "건축" <c:out value = "${vo.dept == '건축' ? 'selected' : ''}"/>>건축공학과</option>
				</select>
			</td>
			<td width = 100 class = "tit">입용일자</td>
			<td width = 250>
				<input type = "date" name = "hiredate" value = "${vo.hiredate}">				
			</td>
		</tr>
		<tr>
			<td class = "tit">교수이름</td>
			<td><input type = "text" name = "pname" size = "8" value = "${vo.pname}"></td>
			<td class = "tit">교수급여</td>
			<td><input type = "text" name = "salary" value = "${vo.salary}"></td>
			<td class = "tit">교수직급</td>
			<td>
				<input type = "radio" name = "title" value = "정교수" <c:out value = "${vo.title == '정교수' ? 'checked' : ''}"/>>정교수&nbsp;&nbsp;
				<input type = "radio" name = "title" value = "부교수" <c:out value = "${vo.title == '부교수' ? 'checked' : ''}"/>>부교수&nbsp;&nbsp;
				<input type = "radio" name = "title" value = "조교수" <c:out value = "${vo.title == '조교수' ? 'checked' : ''}"/>>조교수&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<div class = "buttons">
		<button type = "submit">정보수정</button>
		<button type = "reset">수정취소</button>
	</div>
</form>

<h2 style = "margin-top: 20px;">담당 과목</h2>
<table id = "clist"></table>
<script id = "temp" type = "text/x-handlebars-template">
	<tr class = "tit">
		<td width = 100>강좌번호</td>	
		<td width = 300>강좌이름</td>	
		<td width = 100>강의실</td>	
		<td width = 100>강의시수</td>	
		<td width = 200>수강인원</td>	
		<td width = 150>강좌정보</td>	
	</tr>
	{{#each .}}
	<tr class = "row" style = "text-align: center;">
		<td>{{lcode}}</td>	
		<td>{{lname}}</td>	
		<td>{{room}}</td>	
		<td>{{hours}}</td>	
		<td>{{persons}}/{{capacity}}</td>	
		<td><button onclick="location.href='/cou/read?lcode={{lcode}}'">강좌정보</button></td>	
	</tr>
	{{/each}}
</script>

<h2 style = "margin-top: 20px;">담당 학생</h2>
<table id = "slist"></table>
<script id = "temp1" type = "text/x-handlebars-template">
	<tr class = "tit">
		<td width = 100>학생번호</td>	
		<td width = 300>학생이름</td>	
		<td width = 100>학과</td>	
		<td width = 100>학년</td>	
		<td width = 200>생년월일</td>	
		<td width = 150>학생정보</td>	
	</tr>
	{{#each .}}
	<tr class = "row" style = "text-align: center;">
		<td>{{scode}}</td>	
		<td>{{sname}}</td>	
		<td>{{dept}}</td>	
		<td>{{year}}</td>	
		<td>{{birthday}}</td>	
		<td><button onclick = "location.href='/stu/read?scode={{scode}}'">학생정보</button></td>	
	</tr>
	{{/each}}
</script>

<script>
	var pcode = "${vo.pcode}";
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("교수 정보를 수정하실래요?")) return;
		frm.action="/pro/update";
		frm.submit();
	});
	
	//담당 과목 출력
	$.ajax ({
		type : "get",
		url : "/pro/clist.json",
		data : {pcode : pcode},
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp").html());
			$("#clist").html(temp(data));	
			if(data.length == 0) {
				$("#clist").append("<tr><td colspan = 6 class = 'none' style = 'text-align: center; color: red;'> 당당 강좌가 존재하지 않습니다. </td></tr>");
			}
				
		}
	});
	
	// 담당 학생 출력
	$.ajax ({
		type : "get",
		url : "/pro/slist.json",
		data : {pcode : pcode},
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp1").html());
			$("#slist").html(temp(data));	
			if(data.length == 0) {
				$("#slist").append("<tr><td colspan = 6 class = 'none' style = 'text-align: center; color: red;'> 당당 학생이 존재하지 않습니다. </td></tr>");
			}
				
		}
	});

</script>