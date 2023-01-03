<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container {overflow:hidden;}
	#group1, #group2, #group3 {width:300px; float:left;}
	.box {overflow:hidden;}
	.image {width:100px; float:left;}
	.info {float:left; font-size:12px;}
</style>    
<h1>베스트웹툰</h1>
<div id="container">
<div id="group1"></div>
<script id="temp1" type="text/x-handlebars-template">
	<h5>에피소드</h5>
	{{#each group1}}
	<div class="box">
		<div class="image">
			<img src="{{image}}">
		</div>
		<div class="info">
			<div>{{title}}</div>
			<div>{{summary}}</div>
			<div>{{star}}</div>
		</div>
	</div>
	{{/each}}
</script>
<div id="group2"></div>
<script id="temp2" type="text/x-handlebars-template">
	<h5>옴니버스</h5>
	{{#each group2}}
	<div class="box">
		<div class="image">
			<img src="{{image}}">
		</div>
		<div class="info">
			<div>{{title}}</div>
			<div>{{summary}}</div>
			<div>{{star}}</div>
		</div>
	</div>
	{{/each}}
</script>
<div id="group3"></div>
<script id="temp3" type="text/x-handlebars-template">
	<h5>스토리</h5>
	{{#each group3}}
	<div class="box">
		<div class="image">
			<img src="{{image}}">
		</div>
		<div class="info">
			<div>{{title}}</div>
			<div>{{summary}}</div>
			<div>{{star}}</div>
		</div>
	</div>
	{{/each}}
</script>
</script>
</div>

<script>
	$.ajax({
		type:"get",
		url:"/crawl/best.json",
		dataType:"json",
		success:function(data){
			var temp1=Handlebars.compile($("#temp1").html());
			var temp2=Handlebars.compile($("#temp2").html());
			var temp3=Handlebars.compile($("#temp3").html());
			$("#group1").html(temp1(data));
			$("#group2").html(temp2(data));
			$("#group3").html(temp3(data));
		}
	})
</script>