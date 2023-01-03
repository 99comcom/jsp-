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
<h1>학생정보</h1>
<form name = "frm" method = "post">
	<table>
		<tr>
			<td width = 100 class = "tit">학생번호</td>
			<td width = 100><input type = "text" name = "scode" size = "10" value = "${vo.scode}" readonly></td>
			<td width = 100 class = "tit">학생학과</td>
			<td width = 150>
				<select name = "dept" disabled>
					<option value = "전산" <c:out value = "${vo.dept == '전산' ? 'selected' : ''}"/>>컴퓨터공학과</option>
					<option value = "전자" <c:out value = "${vo.dept == '전자' ? 'selected' : ''}"/>>전자공학과</option>
					<option value = "건축" <c:out value = "${vo.dept == '건축' ? 'selected' : ''}"/>>건축공학과</option>
				</select>
			</td>
			<td width = 100 class = "tit">생년월일</td>
			<td width = 300>
				<input type = "date" name = "birthday" value = "${vo.birthday}">			
			</td>
		</tr>
		<tr>
			<td class = "tit">학생이름</td>
			<td><input type = "text" name = "sname" size = "8" value = "${vo.sname}"></td>
			<td class = "tit">지도교수</td>
			<td>
				<select name = "advisor" id = "advisor"></select>
			</td>
			<td class = "tit">학생학년</td>
			<td>
				<input type = "radio" name = "tit" value = "1" <c:out value = "${vo.year == '1' ? 'checked' : ''}"/>>1학년&nbsp;&nbsp;
				<input type = "radio" name = "tit" value = "2" <c:out value = "${vo.year == '2' ? 'checked' : ''}"/>>2학년&nbsp;&nbsp;
				<input type = "radio" name = "tit" value = "3" <c:out value = "${vo.year == '3' ? 'checked' : ''}"/>>3학년&nbsp;&nbsp;
				<input type = "radio" name = "tit" value = "4" <c:out value = "${vo.year == '4' ? 'checked' : ''}"/>>4학년&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<div class = "buttons">
		<button type = "submit">정보수정</button>
		<button type = "reset">수정취소</button>
	</div>
</form>

<script id = "temp" type = "text/x-handlebars-template">
	{{#each array}}
		<option value = "{{pcode}}" {{selected pcode}}>
			{{pname}}({{dept}}:{{pcode}})
		</option>
	{{/each}}
</script>

<script>
	var advisor = "${vo.advisor}";
	
	Handlebars.registerHelper("selected", function(pcode) {
		if(advisor == pcode) {
			return "selected";
		}
	});
</script>

<h2>수강신청</h2>
<table>
	<tr>
		<td class = "tit" width = "150">수강신청과목 : </td>
		<td width = "900">
			<select id ="alist"></select>
			<button id = "register" style = "margin-left: 20px;">수강신청</button>
		</td>
	</tr>
</table>
	
<script id = "atemp" type = "text/x-handlebars-template">
	{{#each .}}
		<option value="{{lcode}}">
			{{lcode}} : {{lname}} : {{pname}} 
			({{persons}}/{{capacity}})
		</option>
	{{/each}}
</script>
<table id = "clist"></table>
<script id = "ctemp" type = "text/x-handlebars-template">
	<tr class = "tit">
		<td width = 100>강좌정보</td>
		<td width = 200>강좌이름</td>
		<td width = 200>수강신청일</td>
		<td width = 100>담당교수</td>
		<td width = 100>강의실</td>
		<td width = 100>강의시수</td>
		<td width = 100>수강인원</td>
		<td width = 150>수강취소</td>
	</tr>
	{{#each .}}
	<tr class = "row" style = "text-align: center;">
		<td>{{lcode}}</td>
		<td>{{lname}}</td>
		<td>{{edate}}</td>
		<td>{{pname}}</td>
		<td>{{room}}</td>
		<td>{{hours}}</td>
		<td>{{persons}}/{{capacity}}</td>
		<td><button lcode = "{{lcode}}">수강취소</button></td>
	</tr>
	{{/each}}
</script>

<script>
	var scode = "${vo.scode}";
	var dept = $(frm.dept).val();
	
	getClist();
	getAlist();
	
	$("#clist").on("click", ".row button", function() {
		var lcode = $(this).attr("lcode");
		if(!confirm(lcode + " 강좌를 수강취소 하시겠습니까?")) {
			return;
		}
		else {
			$.ajax ({
				type : "post",
				url : "/enroll/delete",
				data : {lcode : lcode, scode : scode},
				success : function() {
					alert("수강취소가 완료되었습니다.");
					getClist();
					getAlist();
				}
			});
		}
	});

	$("#register").on("click", function() {
		var lcode = $("#alist").val();
		$.ajax ({
			type : "get",
			url : "/enroll/check",
			data : {lcode : lcode, scode : scode},
			dataType : "json",
			success : function(data) {
				if(data.count == 1) {
					alert("이미 수강 신청된 강좌입니다.");
				}
				else {
					var capacity=$("#alist").find(".capacity").html();
					alert(capacity);
					if(!confirm(lcode + " 강좌를 수강신청하시겠습니까?")) {
						return;
					}
					else {
						$.ajax ({
							type : "post",
							url : "/enroll/insert",
							data : {lcode : lcode, scode : scode},
							success : function() {
								alert("수강신청이 완료되었습니다.");
								getClist();
								getAlist();
							}
						});
					}
				}
			}
		});
	});
	
	function getClist() {
		$.ajax ({
			type : "get",
			url : "/enroll/clist.json",
			dataType : "json",
			data : {scode : scode},
			success : function(data) {
				var temp = Handlebars.compile($("#ctemp").html());
				$("#clist").html(temp(data));
				if(data.length == 0) {
					$("#clist").append("<tr><td colspan = 8 class = 'none' style = 'text-align: center; color: red;'> 수강신청한 강좌가 없습니다 </td></tr>");
				}
			}
		});	
	}
	
	$.ajax ({
		type : "get",
		url : "/pro/list.json",
		dataType : "json",
		data : {key : "dept", word : dept, per : 100, order : "pname", desc : "", page : 1},
		success : function(data) {
			var temp = Handlebars.compile($("#temp").html());
			$("#advisor").html(temp(data));
		}
	});	
	
	function getAlist() {
		$.ajax ({
			type : "get",
			url : "/enroll/alist.json",
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#atemp").html());
				$("#alist").html(temp(data));
			}
		});	
	}
</script>