<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <style>
	#container{
	overflow: hidden;
	}
	.box{
	width: 170px;float:left;margin: 20px;
	}

	</style>
    
    
<h2 style="margin-left: 500;font-size: 38px">cgv무비차트</h2>
<table id="tbl"></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr>
		<td width=300>{{title}}</td>
		<td width=200>{{price}}</td>
		<td width=200>{{rate}}%</td>
	</tr>

</script>


<div id="container"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each .}}
		<div class="box">
			<a href="{{link}}"><img src="{{image}}" width=150></a>
			<div>{{title}}</div>
			<div>{{date}}</div>
			<div>{{percent}}</div>
		</div>
	{{/each}}
</script>

<script>

	getList();
	
	
	
	function getList() {
		$.ajax({
			type:"get",
			url:"/crawl/cgv.json",
			dataType:"json",
			success:function(data){
				 var temp=Handlebars.compile($("#temp").html());
		         $("#container").html(temp(data));
			}
		})
		
	}


</script>