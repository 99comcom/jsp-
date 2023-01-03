<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h1>영화목록</h1>

<div>
	<button id="delete">영화삭제</button>
	<a href="/movie/insert"><button>영화등록</button></a>
	등록된 영화 수:<span>${count}</span>
	
</div>
<table id="tbl">
	 <tr class="title">
	      <td><input type="checkbox" id="chkAll"></td>
	      <td width=100>포스터</td>
	      <td width=300>제목</td>
	      <td width=200>출연진</td>
	      <td width=150>감독</td>
	      <td width=100>등록일</td>
	   </tr>
	   <c:forEach items="${array}" var="vo">
		   <tr class="row">
		     <td><input type="checkbox" class="chk" id="${vo.id}" image="${vo.image}"></td>
		      <td><img src="/image/${vo.image}" width=70></td>
		      <td>${vo.title}</td>
		      <td>${vo.actor}</td>
		      <td>${vo.director}</td>
		      <td><fmt:formatDate value="${vo.wdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		   </tr>
	   </c:forEach>
</table>
<div class="buttons">
	<form name="frm">
		<button id="prev" <c:out value="${page==1? 'disabled':''}" />>이전</button>
		<input type="text" size=1 value="${page}"name="page">/${last}
		<button id="next" <c:out value="${page==last? 'disabled':''}" />>다음</button>
	  </form>
</div>

<script>

var last="${last}";

$("#prev").on("click", function() {
	var page=$(frm.page).val();
	page--;
	$(frm.page).val(page);
	
})

$("#next").on("click", function() {
	var page=$(frm.page).val();
	page++;
	$(frm.page).val(page);
	
})

$("#delete").on("click",function(){
	  var chk=$("#tbl .row .chk:checked").length;
	  if(chk==0){
		  alert("삭제할 영화를 선택하세요");
		  return;
	  }
	if(!confirm(chk+"개의 영화를 삭제하실래요? "))return;
	$("#tbl .row .chk:checked").each(function(){
		var id=$(this).attr("id");
		var image=$(this).attr("image");
		$.ajax({
			type:"get",
			url:"/movie/delete",
			data:{id:id,image:image},
			success:function(){}
			
		})
	})
	alert(chk+"개의 영화를 삭제하였습니다. ")
		location.href="/movie/list";
})



$("#tbl").on("click", "#chkAll", function(){
      if($(this).is(":checked")){
         $("#tbl .row .chk").each(function(){
            $(this).prop("checked", true);
         });
      }else{
         $("#tbl .row .chk").each(function(){
            $(this).prop("checked", false);
         });
      }   
   });
   
   $("#tbl").on("click", ".row .chk", function(){
      var all=$("#tbl .row .chk").length;
      var chk=$("#tbl .row .chk:checked").length;
      
      if(all==chk) $("#chkAll").prop("checked", true)
      else $("#chkAll").prop("checked", false)
   });
   
   $("#tbl").on("click", ".row img", function(){
      var image=$(this).attr("src");
      if(!confirm(image + " 이미지를 다운로드하실래요?")) return;

});



 $(frm.page).on("keydown",function(e){
	if(e.keyCode==13){
		var page=$(this).val();
		if(page>last) alert("마지막 페이지가 " +last+"페이지입니다. ")
		else frm.submit();
	}
})
 
</script>

