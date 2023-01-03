<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ec0c68668b0593432929af9642a7a380"></script>
<style>
	form button {padding:5px 20px;}
	.address {width:400;}
	#map {width:700px; height:400px;}
	#info {width:200px; text-align:center; padding:5px; font-size:12px;
		background:yellow;}
	#condition{overflow:hidden;}
	#condition #save {float:left;}
	#condition form {float:right;}	
</style>    
<h1>지역검색</h1>
<div id="condition">
	<button id="save">선택저장</button>
	<form name="frm">
		<select name="local">
			<option>인천</option>
			<option>서울</option>
			<option>경기도</option>
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
		<td width="200">장소이름</td>
		<td width="400">주소</td>
		<td width="200">전화번호</td>
		<td width="150">위치보기</td>
	</tr>
	{{#each documents}}
	<tr class="row" id="{{id}}" x="{{x}}" y="{{y}}">
		<td><input type="checkbox" class="chk"></td>
		<td class="place">{{place_name}}</td>
		<td class="address">{{address_name}}</td>
		<td class="phone">{{phone}}</td>
		<td style="text-align:center;"><button x="{{x}}" y="{{y}}">위치보기</button></td>
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
		<div id="map"></div>
		<button id="close">닫기</button>
	</div>
</div>

<script>
	var page=1;
	var query="인천 버거킹";
	getList();
	
	//선택저장버튼을 클릭한 경우
	$("#save").on("click", function(){
		var chk=$("#tbl .row .chk:checked").length;
		if(chk==0){
			alert("저장할 항목을 선택해 주세요!");
			return;
		}
		
		if(!confirm("선택한 항목들을 저장하실래요?")) return;
		
		$("#tbl .row .chk:checked").each(function(){
			var row=$(this).parent().parent();
			var id = row.attr("id");
			var name= row.find(".place").html();
			var phone= row.find(".phone").html();
			var x=row.attr("x");
			var y=row.attr("y");
			var keyword=$(frm.query).val();
			var address=row.find(".address").html();
			//alert(id+"\n"+name+"\n"+phone+"\n"+x+"\n"+y+"\n"+keyword);
			
			$.ajax({
				type:"post",
				url:"/local/insert",
				data:{id:id,address:address,name:name,phone:phone,x:x,y:y,keyword:keyword},
				success:function(){}
			});
		});	
		
		alert("저장이 완료되었습니다.");
		getList();
	});
	
	//각행의 체크박스를 클릭한 경우
	$("#tbl").on("click", ".row .chk", function(){
		var all=$("#tbl .row .chk").length;
		var chk=$("#tbl .row .chk:checked").length;
		
		if(all==chk) $("#tbl #chkAll").prop("checked", true);
		else $("#tbl #chkAll").prop("checked", false);
	});
	
	//전체선택 체크박스를 클릭한경우
	$("#tbl").on("click", "#chkAll", function(){
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", true);
			})
		}else{
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", false);
			})
		}	
	});
	
	$("#tbl").on("click", ".row button", function(){
		$("#background").show();
		
		var x=$(this).attr("x");
		var y=$(this).attr("y");
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
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
		//alert(place + phone);
		
		var str="<div id='info'>";
		str += place + "<br>";
		str += phone;
		str +="</div>";
		
		// 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: str // 인포윈도우에 표시할 내용
	    });
		
	 	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	    
	 	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	    function makeOverListener(map, marker, infowindow) {
	        return function() {
	            infowindow.open(map, marker);
	        };
	    }

	    // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	    function makeOutListener(infowindow) {
	        return function() {
	            infowindow.close();
	        };
	    }
	});
	
	$("#close").on("click", function(){
		$("#background").hide();	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		getList();
	});
	
	$(frm.local).on("change", function(){
		page=1;
		getList();
	});
	
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	function getList(){
		query = $(frm.local).val() + " " + $(frm.query).val();
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v2/local/search/keyword.json",
			dataType:"json",
			headers:{"Authorization":"KakaoAK cab3c0af05cec9545fedf00d493f2260"},
			data:{page:page, size:5, query:query},
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#count").html(data.meta.pageable_count);
				$("#page").html(page)
				
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(data.meta.is_end==true) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
			}
		})
	}
</script>
