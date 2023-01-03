<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container .box {overflow:hidden; border-bottom:1px dotted gray;padding:10px;}
	.box .image {width:100px; float:left;}
	.box .content{width:800px;float:left;}
	.up {color:red;}
	.down {color:blue;}
</style>    
<h1>증권뉴스</h1>
<table id="tbl" style="width:900px;margin-bottom:30px;"></table>
<script id="temp1" type="text/x-handlebars-template">
	<tr class="{{updown rate}}">
		<td width=300>{{title}}</td>
		<td width=100>{{price}}</td>
		<td width=100>{{rate}}%</td>
	</tr>
</script>
<script>
	Handlebars.registerHelper("updown", function(rate){
		var updown=rate.substring(0,2);
		if(updown=="상승") return "up";
		else return "down";
	});
</script>

<div id="container"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each .}}
	<div class="box">
		<div class="image"><img src="{{image}}"></div>
		<div class="content">
			<h5><a href="http://finance.naver.com/{{link}}">{{title}}</a></h5>
			<p>{{content}}</p>
		</div>
	</div>
	{{/each}}
</script>

<script>
	$.ajax({
		type:"get",
		url:"/crawl/naver/news.json",
		dataType:"json",
		success:function(data){
			var temp=Handlebars.compile($("#temp").html());
			$("#container").html(temp(data));
		}
	})
	
	//주식정보를 1~15위까지 2초간격으로 보여준다.
	$.ajax({
		type:"get",
		url:"/crawl/naver/top.json",
		dataType:"json",
		success:function(data){
			var temp=Handlebars.compile($("#temp1").html());
			
			var i=1;
			$("#tbl").html(temp(data[0]));
			var inteval=setInterval(function(){
				$("#tbl").html(temp(data[i%data.length]));
				i++;
			}, 2000);
		}
	});
</script>
