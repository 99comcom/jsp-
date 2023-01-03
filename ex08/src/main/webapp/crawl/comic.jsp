<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <style>
	#container{
	overflow: hidden;
	}
	.box{
	width: 100px;float:left;margin: 20px;
	  width:25%;
    box-sizing: border-box;
	}


	</style>
    
    
<h2 style="margin-left: 500;font-size: 38px">추천웹툰</h2>


<div id="container"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each .}}
		<div class="box">
			<a href="{{link}}" id="image"><img src="{{image}}" width=150></a>
			<div id="title">{{title}}</div>
			<div id="user">{{user}}</div>
			<div id="content">{{content}}</div>
			<div id="star">{{star}}</div>
		</div>
	{{/each}}
</script>

<script>
	getList();
	
	
	

	function getList() {
		$.ajax({
			type:"get",
			url:"/crawl/naver/comic.json",
			dataType:"json",
			success:function(data){




				 var temp=Handlebars.compile($("#temp").html());
		         $("#container").html(temp(data));
		        
			}
		})
	}


</script>