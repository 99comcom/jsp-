<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbdc4525ed318d294b4e25a628825185"></script>
   <style> 
   #map{width: 700px; height: 500px;}
   #condition{overflow:hidden;} 
   #condition #save{float:left;}
   #condition form{float:right;}
   </style>
    
    
<h1>지역검색</h1>
<div id="condition">
	<button id="save">선택저장</button>
	<form name="frm">
	<select name="local">
		<option> 인천</option>
		<option> 서울</option>
		<option> 경기도</option>
		
	</select>
	<input type="text" name="query" value="버거킹">
	<button>검색</button>
	검색수: <span id="count"></span>

	</form>
</div>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
  <tr class="title">
	<td><input type="checkbox" id="chkAll"></td>
    <td width="200">Name</td>
    <td width="400">Address</td>
	<td width="150">Phone</td>
	<td width="150">Map</td>
  </tr>
{{#each documents}}
   <tr class="row" id="{{id}}" x="{{x}}" y="{{y}}">
	<td><input type="checkbox" class="chk"></td>
    <td class="place">{{place_name}}</td>
    <td class="address">{{address_name}}</td>
	<td class="phone">{{phone}}</td>
	<td><button >위치보기</button></td>
  </tr>
{{/each}}


</script>

<div class="buttons">
	<button id="prev">이전</button>
	<span id="page">1/10</span>
	<button id="next">다음</button>

</div>

<!-- 지도 출력 -->
<div id="background">
	<div id="lightbox">
		<div id="map">
		</div>
		<button id="close">닫기</button>
	</div>
</div>

<script>
	var page=1;
	var size=5;
	var query="논현";
	
	getList();
	
	//저장버튼을 눌렀을떄
	$("#save").on("click", function () {
		var chk=$("#tbl .row .chk:checked").length;
		if(chk==0){
			alert("저장하실 데이터를 선택바랍니다.");
			return;
		}
		if(!confirm("선택한 항목들을 저장하시겠습니까?")) return;
		
		$("#tbl .row .chk:checked").each(function () {
			var row=$(this).parent().parent();
			var id=row.attr("id");
  			var name=row.find(".place").html(); 
			var address=row.find(".address").html(); 
			var phone=row.find(".phone").html(); 
			var x=row.attr("x");
			var y=row.attr("y");
			var keyword=$(frm.query).val();
			
			$.ajax({
				type:"post",
				url:"/local/insert",
				data:{id:id,address:address,name:name,phone:phone,x:x,y:y,keyword:keyword},
	        	 success:function(){}
				
			})
		});
		alert("저장되었습니다.");

		getList();
	})
	
	//체크박
	$("#tbl").on("click",".row .chk",function(){
		var all=$("#tbl .row .chk").length;
		var chk=$("#tbl .row .chk:checked").length;
		
		if(all==chk) $("#tbl #chkAll").prop("checked", true);
		else $("#tbl #chkAll").prop("checked",false);
			
		})
	$("#tbl").on("click","#chkAll",function(){
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
	
	$("#tbl").on("click",".row button", function () {
		$("#background").show();
		
		var x=$(this).attr("x");
		var y=$(this).attr("y")
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(y,x), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(y, x); 

		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var row=$(this).parent().parent();
		var place=row.find(".place").html();
		var phone=row.find(".phone").html();
		//alert(place+phone);
		
		var str="<div id='info'>"+ place +"<br>" +phone+ "</div>";
		

			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var iwContent = str  // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
			      // 마커 위에 인포윈도우를 표시합니다
			      infowindow.open(map, marker);  
			});
		
	});
	

	
	
	$("#close").on("click", function() {
		$("#background").hide();
		
	});
	
	
	
	$("#next").on("click", function() {
		page++;
		getList();
		
	});
	
	$("#prev").on("click", function() {
		page--;
		getList();
		
	});
	
	$(frm).on("submit", function (e) {
		e.preventDefault();
		papage=1;
		getList();
		
	})
	
	$(frm.local).on("change", function() {
		papage=1;
		getList();
		
	})
	

	   function getList(){
		   query=$(frm.local).val()+" "+$(frm.query).val();
	      $.ajax({
	         type:"get",
	         url:"https://dapi.kakao.com/v2/local/search/keyword.json",
	         dataType:"json",
	         headers:{"Authorization":"KakaoAK 5bbeb6dc555dfbbd4b564634b38277e6"},
	         data:{page:page, size:5, query:query},
	         success:function(data){
	            var temp=Handlebars.compile($("#temp").html());
	            $("#tbl").html(temp(data));
	            $("#count").html(data.meta.pageable_count);
	            
	            var last=Math.ceil(data.meta.pageable_count/5);
	            $("#page").html(page)
	            
	            if(page==1) $("#prev").attr("disabled",true);
	            else $("#prev").attr("disabled",false);
	            
	            if(data.meta.is_end==true) $("#next").attr("disabled",true);
	            else $("n#ext").attr("disabled",false);
	            

	         }
	      })
	   }
	</script>
