<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <style> 
   #map{width: 700px; height: 500px;}
   #condition{overflow:hidden;} 
   #condition #save{float:left;}
   #condition form{float:right;}
   </style>
<h1>상품검색</h1>
<div id="condition">
	<button  id="save">선택저장</button>
	<form name="frm">
		<input type="text" value="스타벅스" name="query">
		<button style="padding: 5px 20px" >검색</button>
	</form>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td><input type="checkbox" id="chkAll"></td>
		<td width=150 >No.</td>
		<td width=100 >Image.</td>
		<td width=400 >Name.</td>
		<td width=100 >Price.</td>
		<td width=150 >Brand</td>
	</tr>
	{{#each items}}
	<tr class="row">
		<td><input type="checkbox" class="chk"></td>
		<td class="id">{{productId}}</td>
		<td ><img src="{{image}}" width=70></td>
		<td class="name">{{{title}}}</td>
		<td class="price">{{lprice}}</td>
		<td class="brand">{{brand}}</td>
	</tr>
	{{/each}}

</script>

<div class="buttons">
	<button id="prev">이전</button>
	<span id="page">1/10</span>
	<button id="next">다음</button>

</div>

<script>
	getList();
	var page=1;


	$("#save").on("click", function () {
		var chk=$("#tbl .row .chk:checked").length;
		if(chk==0){
			alert("저장할 목록들을 선택하세여!");
			return;
		}	
		if(!confirm(chk+"개 삼품들을 저장하실래요?")) return;
		$("#tbl .row .chk:checked").each(function() {
			var row=$(this).parent().parent();
			var title=row.find(".name").html();
			var id=row.find(".id").html();
			var url=row.find("img").attr("src");
			var price=row.find(".price").html();
			var brand=row.find(".brand").html();
			
			$.ajax({
				type:"post",
				url:"/shop/insert",
				data:{id:id , title,title, url:url, price:price, brand:brand},
				success:function(){}
			})
		})
		getList();
		
	})
	
	//체크박스	
	$("#tbl").on("click", "#chkAll",function(){
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function () {
				 $(this).prop("checked", true);
				
			})
		}else{
			$("#tbl .row .chk").each(function () {
				$(this).prop("checked", false);
			})
		}
			
	})
	
	$("#tbl").on("click", ".row .chk", function(){
		var all=$("#tbl .row .chk").length;
		var chk=$("#tbl .row .chk:checked").length;
		
		if(all==chk) $("#tbl #chkAll").prop("checked", true);
		else $("#tbl #chkAll").prop("checked",false);
			
		})
	
	
	
	
	
	
	//각홰의 이미지를 클릭한 경우
	$("#tbl").on("click",".row img",function(){
		var url=$(this).attr("src");
		if(!confirm("이미즐 다운로드 하실래요?"))
		
		$.ajax({
			type:"get",
			url:"/download",
			data:{url:url},
			success:function(){
				alert("다운로드 완료")
			}
		})
	})

	$("#next").on("click", function() {
		page++;
		getList();
		
	});
	
	$("#prev").on("click", function() {
		page--;
		getList();
		
	});
	
	
	$(frm).on("submit", function(e){  //검색버튼 눌렀을 경
		e.preventDefault();
		page=1;
		getList();
		
	})
	
	
	
	function getList() {
		var query=$(frm.query).val();
		$.ajax({
			type:"get",
			url:"/shop/search.json",
			data:{query:query , page:page},
			dataType:"json",
			success:function(data){
			var temp=Handlebars.compile($("#temp").html());
			$("#tbl").html(temp(data));
	            
	            var last=0;
				if(data.total >=100){
					last=Math.ceil(100/5);
				}else{
					Math.ceil(data.total/5);
				}
	            
	            $("#page").html(page +"/"+last)
	            
	            
	            if(page==1) $("#prev").attr("disabled",true);
	            else $("#prev").attr("disabled",false);
	            
	            if(page==last) $("#next").attr("disabled",true);
	            else $("#next").attr("disabled",false);

			}
		})
	}

</script>