<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
  <style>
	td{border: 1px dotted black;}
	.row {text-align:center;}
	.none {text-align:center; color:red;}
</style>
    
    
    
<h1>강좌정보</h1>
<h4 style="border-top: 1px solid; gery;margin-top: 20px"></h4>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=200 class="title">강좌번호</td>
			<td width=150><input type="text" value="${vo.lcode}" name="lcode" size=5></td>
			<td width=200 class="title">강의실</td>
			<td width=150><input type="text" value="${vo.room}" name="room" size=5></td>
			<td width=200 class="title">강의시수</td>
			<td width=200><input type="text" value="${vo.hours}" name="hours" size=5></td>
		</tr>
		<tr>
			<td width=200 class="title">강좌이름</td>
			<td colspan="3"><input type="text" value="${vo.lname}" name="lname" size=40></td>
			<td width=200 class="title">최대수강인원</td>
			<td width=200><input type="text" value="${vo.capacity}" name="capacity" size=5></td>
		</tr>
		<tr>
			<td width=200 class="title">담당교수</td>
			<td colspan="3">
				<input type="text" value="${vo.instructor}" name="instructor" size=5>
				<span>${vo.pname}</span>
			</td>
			<td width=200 class="title">수강신청인원</td>
			<td width=200><span>${vo.persons}</span></td>
		</tr>
				
	</table>
	<div class="buttons" >
		<button>수정</button>
		<button>삭제 </button>
	</div>
</form>
<h2 style="border-top: 1px solid; gery;margin-top: 50px"></h2>
<h1 style="margin-bottom : 10px">수강학생</h1>
<button id="update">선택수정</button>
<table id="slist" ></table>
<script id="stemp" type="text/x-handlebars-template">
	<tr class="title">
		<td ><input type="checkbox" id="all"></td>
		<td width=150>학번</td>
		<td width=200>학생이름</td>
		<td width=200>학과</td>
		<td width=100>학년</td>
		<td width=200>수강신청일</td>
		<td width=200>점수</td>
	</tr>
	{{#each .}}
	<tr class="row">
		<td><input type="checkbox" class="chk"></td>
		<td class="scode">{{scode}}</td>
		<td>{{sname}}</td>
		<td>{{dept}}</td>
		<td>{{year}}</td>
		<td>{{edate}}</td>
		<td>
			<input type="text" class="grade" value=  "{{grade}}" size=5>
			<button>수정</button>
		</td>
	</tr>
	{{/each}}

</script>


<script>
	var lcode="${vo.lcode}";
	getlist();
	
	
		$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("강좌정보를 수정하시겠습니까?")) return;
		frm.action="/cou/update";
		frm.submit();
	})
	
function getlist() {
	$.ajax({
		type:"get",
		url:"/enroll/slist.json",
		data:{lcode:lcode},
		dataType:"json",
		success:function(data){
			var temp=Handlebars.compile($("#stemp").html());
			$("#slist").html(temp(data));
			if(data.length==0){
				 $("#slist").append("<tr><td colspan=6 class='none'>담당할 학생이 없습니다!</td></tr>");
			}
		}
	})
}

$("#slist").on("click", ".row button", function() {
	var row=$(this).parent().parent();
	var scode=row.find(".scode").html();
	var grade=row.find(".grade").val();
	if(confirm(scode+"학생의 점수를"+grade+"로 수정하시겠습니까?"))
		$.ajax({
			type:"post",
			url:"/enroll/update",
			data:{lcode:lcode,scode:scode,grade:grade},
			success:function(){
				alert("수정완료 하였습니다.")
				getlist();
				
			}
		})
});
	
	

$("#update").on("click",function(){
	  var chk=$("#slist .row .chk:checked").length;
	  if(chk==0){
		  alert("수정할 학생을  선택하세요");
		  return;
	  }
	if(confirm(chk+"명 학생의 점수를 수정하시겠습니까?"))
	$("#slist .row .chk:checked").each(function(){
		var row=$(this).parent().parent();
		var scode=row.find(".scode").html();
		var grade=row.find(".grade").val();
			$.ajax({
				type:"post",
				url:"/enroll/update",
				data:{lcode:lcode,scode:scode,grade:grade},
				success:function(){}

		})
	})
	alert("학생들의 점수가 수정되었습니다.")
		getlist();
})

	


$("#slist").on("click", "#all", function(){
      if($(this).is(":checked")){
         $("#slist .row .chk").each(function(){
            $(this).prop("checked", true);
         });
      }else{
         $("#slist .row .chk").each(function(){
            $(this).prop("checked", false);
         });
      }   
   });
   
   $("#slist").on("click", ".row .chk", function(){
      var all=$("#slist .row .chk").length;
      var chk=$("#slist .row .chk:checked").length;
      
      if(all==chk) $("#all").prop("checked", true);
      else $("#all").prop("checked", false);
   });
   


   



</script>