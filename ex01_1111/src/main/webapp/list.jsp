<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<h1>주소목록</h1>
	<a href="/insert">주소등</a>
	<table id="list" border=1></table>
	<script id="temp" type="text/x-handlebars-template">
	{{#each array}}
	<tr Class="row">
	<td>{{id}}</td>
	<td><a href="/read?id={{id}}">{{name}}</a></td>
	<td>{{tel}}</td>
	<td>{{address}}</td>
	<td><button id="{{id}}">삭제</button></td>
	{{/each}}
	</script>


<script>

getList();

	//삭제버튼을 클릭한 경우
	$("#list").on("click",".row button", function() {
		var sel=$(this).html();
		var id=$(this).attr("id");
		if(!confirm(id+""+sel+"하실래요?"))return;
		$.ajax({
			type:"post",
			url:"/users/delete",
			data:{id:id ,sel:sel},
			success:function(){
				alert(sel+"완료!");
				getList();
			}
			
			
		})
		
	})
function getList(){
		$.ajax({
			type:"get",
			url:"/list.json",
			dataType:"json",
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#list").html(temp(data));
			}
		});
	}
	
</script>
