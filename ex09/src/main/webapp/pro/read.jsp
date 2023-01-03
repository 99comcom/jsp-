<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <style>
	td{border: 1px dotted black;}
	.row {text-align:center;}
	.none {text-align:center; color:red;}
</style>
    
    
    
<h1>교수정보</h1>
<h2 style="border-top: 1px solid; gery;margin-top: 50px"></h2>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100 class="title">교수번호</td>
			<td width=100><input type="text" value="${vo.pcode}" name="pcode" size=5 readonly></td>
			<td width=100 class="title">교수학과</td>
			<td width=100>
				<select name="dept">
					<option value="전산" <c:out value="${vo.dept=='전산'?'selectde':''}"/>>컴퓨터정보공학과</option>
					<option value="전자"<c:out value="${vo.dept=='전자'?'selectde':''}"/>>전자공학과</option>
					<option value="건축"<c:out value="${vo.dept=='건축'?'selectde':''}"/>>건축공학과</option>
				</select>
			</td>
			<td width=100 class="title">임용일자</td>
			<td width=300><input type="date" value="${vo.hiredate}" name="hiredate"></td>
		</tr>
		<tr>
			<td class="title">교수이름</td>
			<td><input type="text" name="pname" value="${vo.pname}" size=8> </td>
			<td class="title">교수급여</td>
		 	<td><input type="text" name="salary" value="${vo.salary}"></td>
			<td class="title">교수직급</td>
			<td>
			<input type="radio" name="title" value="정교수" checked>정교수 &nbsp;&nbsp;
				<input type="radio" name="title" value="부교수">부교수 &nbsp;&nbsp;
				<input type="radio" name="title" value="조교수">조교수 &nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<div class="buttons" >
		<button>수정</button>
		<button>삭제 </button>
	</div>
</form>
<h2 style="border-top: 1px solid; gery;margin-top: 50px"></h2>
<h1 style="margin-bottom : 10px">담당과목</h1>
<table id="clist" ></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr class="title">
		<td width=150>강좌번호</td>
		<td width="200">강좌이름</td>
		<td width=100>강의실</td>
		<td width=100>강의시수</td>
		<td width=200>수강인원</td>
		<td width=150>강좌정보</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{lcode}}</td>
		<td>{{lname}}</td>
		<td>{{room}}</td>
		<td>{{hours}}</td>
		<td>{{persons}}/{{capacity}}</td>
		<td><button onclick="location.href='/cou/read?lcode={{lcode}}'">강좌정보</button></td>
	</tr>
	{{/each}}

</script>
<h2 style="border-top: 1px solid; gery;margin-top: 50px"></h2>
<h1 style="margin-bottom : 10px">담당학생</h1>
<table id="slist" ></table>
<script id="temp2" type="text/x-handlebars-template">
	<tr class="title">
		<td width=150>학생번호</td>
		<td width="200">학생이름</td>
		<td width=100>학생학과</td>
		<td width=100>학생학년</td>
		<td width=200>생년월일</td>
		<td width=150>학생정보</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td>{{scode}}</td>
		<td>{{sname}}</td>
		<td>{{dept}}</td>
		<td>{{year}}</td>
		<td>{{birthday}}</td>
		<td><a href="/stu/read?scode={{scode}}"><button>학생정보</button></a></td>
	</tr>
	{{/each}}

</script>


<script>
	var pcode="${vo.pcode}";
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("교수정보를 수정하시겠습니까?")) return;
		frm.action="/pro/update";
		frm.submit();
	})
	
	//담당학생출력
	$.ajax({
		type:"get",
		url:"/pro/slist.json",
		data:{pcode:pcode},
		dataType:"json",
		success:function(data){
			var temp=Handlebars.compile($("#temp2").html());
			$("#slist").html(temp(data));
			if(data.length==0){
				 $("#slist").append("<tr><td colspan=6 class='none'>담당할 학생이 없습니다!</td></tr>");
			}
		}
	})


	//담당과목출력
	$.ajax({
		type:"get",
		url:"/pro/clist.json",
		data:{pcode:pcode},
		dataType:"json",
		success:function(data){
			var temp=Handlebars.compile($("#temp1").html());
			$("#clist").html(temp(data));
			if(data.length==0){
				 $("#clist").append("<tr><td colspan=6 class='none'>담당강좌가 없습니다!</td></tr>");
			}	
		}
	})

</script>