<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div id="divCart">
<h1>장바구니</h1>
	<table id="tbl">
		<tr class="title">
			<td><input type="checkbox" id="all"></td>
			<td width="100">상품코드</td>
			<td width=400>상품이름</td>
			<td width="200">단가</td>
			<td width="200">수량</td>
			<td width="200">합계</td>
			<td width="100">삭제</td>
		</tr>
		<c:forEach items="${carts}" var="vo">
			<tr class="row" pid="${vo.prod_id}" pname="${vo.prod_name}" price="${vo.price2}" qnt="${vo.qnt}">
				<td><input type="checkbox" class="chk"></td>
				<td class="id">${vo.prod_id}</td>
				<td class="name">${vo.prod_name}</td>
				<td class="price"><fmt:formatNumber value="${vo.price2}" pattern="#,###원"/></td>
				<td><input class="qnt" type="text" value="${vo.qnt}" size="2"> <button class="update" style="padding: 8px">수정</button></td>
				
				<td>
				<fmt:formatNumber value="${vo.sum}" pattern="#,###"/>원
				<span class="sum" style="display: none;">${vo.sum}</span>
				</td>
				<td><button class="delete" id="${vo.prod_id}" style="padding: 8px" >삭제</button></td>
			</tr>	
		</c:forEach>
		<c:if test="${carts.size()>0}">
		<tr>
			<td class="title" colspan="7">합계:<span id="total"></span></td>
		</tr>
		</c:if>
		<c:if test="${carts.size()==0 || carts==null}">
			<tr><td colspan=7 style="text-align: center; font-size: 30px;">장바구니가 비어있습니다.</td></tr>
		</c:if>
	</table>
	
	<div class="buttons" id="dd">
	   <button id="btnAll" >전체상품주문</button>
	   <button id="btnChk">선택상품주문</button>
	</div>	
</div>
<div id="divOrder">
	<h1>주문정보</h1>
	<table id="tbl1"></table>
	<script id="temp1" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>상품코드</td>		
			<td width=400>상품이름</td>
			<td width=200>상품가격</td>
			<td width=100>상품수량</td>
			<td width=200>상품금액</td>
		</tr>
	{{#each .}}
		<tr class="row" pid="{{pid}}" price="{{price}}" qnt="{{qnt}}" sum="{{sum}}">
			<td>{{pid}}</td>		
			<td>{{pname}}</td>	
			<td>{{price}}</td>	
			<td>{{qnt}}</td>	
			<td>{{sum}}</td>	
		</tr>
	{{/each}}
	<tr class="title">
		<td colspan=5 id="total"></td>
	</tr>
	</script>
	<br>
	<h2>주문자정보</h2>
	<form name="frm" method="post">
		<table id="tbl1" style="border: 1px solid black;">
			<tr>
				<td width=100 class="title">주문자 성명</td>
				<td width=800><input type="text" name="name" value="홍킬"></td>
			</tr>
			<tr>
				<td width=100 class="title">배송지 주소</td>
				<td width=800 >
					<input type="text" class="address" name="address" size=80 readonly>
					<br>
					<input type="text" name="address2" size=80 placeholder="나머지주소">
				</td>
			</tr>
			<tr>
				<td width=100 class="title">이메일</td>
				<td width=800><input type="text" name="email"size=20 value="inin@ikea.com"></td>
			</tr>
			<tr>
				<td width=100 class="title">전화번호</td>
				<td width=800><input type="text" name="tel" value="010-2222-0001"></td>
			</tr>
			<tr>
				<td width=100 class="title">결재방법</td>
				<td width=800>
					<input type="radio" name="payType" value="0">무통장
					<input type="radio" name="payType" value="1" checked>카드
				</td>
			</tr>
		</table>
		<div class="buttons">
	   <button>주문하기</button>
	</div>	
	</form>
</div>
<script>

var total=0;
var array=[];

$("#divCart").show();
$("#divOrder").hide();


//주문하기 버튼을 눌렀을때
$(frm).on("submit", function(e) {
	e.preventDefault();
	var name=$(frm.name).val();
	var tel=$(frm.tel).val();
	var address=$(frm.address).val()+$(frm.address2).val();
	var email=$(frm.email).val();
	var payType=$(frm.payType).val();
	
	
	if(!confirm("위 상품들을 주문하실래요?"))return;
	
	$.ajax({
		type:"get",
		url:"/pur/insert",
		data:{name:name, tel:tel , address:address, email:email, payType:payType },
		dataType:"json",
		success:function(data){
			alert(data.code);
			var oid=data.code;
			$("#tbl1 .row").each(function(){
				var pid=$(this).attr("pid");
				var price=$(this).attr("price");
				var qnt=$(this).attr("qnt");
				/* alert(oid+pid+price+"..."+qnt); */
				$.ajax({
					type:"get",
					url:"/order/insert",
					data:{pid:pid,oid:oid,price:price,qnt:qnt},
					success:function(){
						$.ajax({
							type:"get",
							url:"/cart/delete",
							data:{id:pid},
							success:function(){}
						})
					}
				})
			})
			alert(oid+"주문이 완료되었습니다.")
			location.href="/";
		}
	})
})

//주소입력
		$(frm.address).on("click", function(){
		      new daum.Postcode({
		         oncomplete: function(data) {
		            //console.log(data)
		            $(frm.address).val(data.address); //data.roadAddress, data.jibunAddress, data.zonecode
		         }
		      }).open();   
		   });
	
	
	$("#btnChk").on("click",function(){
		   var chk=$("#tbl .row .chk:checked").length;
		   
		   if(chk==0){
			   alert("선택된 상품이 없습니다.")
		   }else{	   
			   $("#divOrder").show();
				$("#btnAll").hide();
				var total=0; 
				//선택상품주문
			 	$("#tbl .row .chk:checked").each(function() {
						var row=$(this).parent().parent();
						var pid=row.attr("pid");
						var pname=row.attr("pname");
						var price=row.attr("price");
						var qnt=row.attr("qnt");
						var sum=parseInt(price)*parseInt(qnt);
						total+=sum;
						/* alert(pid+pname+price+"......"+qnt+"........"+sum); */
						var data={pid:pid,pname:pname,price:price,qnt:qnt,sum:sum};
							array.push(data);
						});
					var temp=Handlebars.compile($("#temp1").html());
					$("#tbl1").html(temp(array));
					$("#tbl1 #total").html("합계:"+total);
		   }
	})
	
	
	
	//전체상품주문
$("#btnAll").on("click", function() {
	$("#divOrder").show();
	$("#dd").hide();
	$(this).onclick = null;
	var total=0; 
	$("#tbl .row").each(function () {
		var pid=$(this).attr("pid");
		var pname=$(this).attr("pname");
		var price=$(this).attr("price");
		var qnt=$(this).attr("qnt");
		var sum=parseInt(price)*parseInt(qnt);
		total+=sum;
		/* alert(pid+pname+price+"......"+qnt+"........"+sum); */
		var data={pid:pid,pname:pname,price:price,qnt:qnt,sum:sum};
		array.push(data);
		
	});
	var temp=Handlebars.compile($("#temp1").html());
	$("#tbl1").html(temp(array));
	$("#tbl1 #total").html("합계:"+total);
})



	
	$("#tbl .row .sum").each(function(){
		total += parseInt($(this).html());
		
	})


	$("#total").html(total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	
	
	$("#tbl").on("click", "#all", function () {
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",true);
			})
		}else{
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked",false);
			})
		}
	})
	
	$("#tbl").on("click", ".row .chk", function () {
		 var all=$("#tbl .row .chk").length;
	      var chk=$("#tbl .row .chk:checked").length;
		if(alll=chk){
			$("#tbl #all").prop("checked", true);
		}else{
			$("#tbl #all").prop("checked", false);	
		}
	})
	
	
	
	
	//수정버튼을 클릭한 경우
	$("#tbl").on("click", ".row .update",function(){
		var row=$(this).parent().parent();
		var id=row.find(".id").html();
		var qnt=row.find(".qnt").val();
		if(qnt.replace(/[0-9]/g,'') || qnt==""){
			alert("수량을 정확히 입력하주세요");
			row.find(".qnt").val("");
			row.find(".qnt").focus();
			return;
		}
		if(!confirm(id+"상품"+qnt+"개로 수정하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"/cart/update",
			data:{id:id,qnt:qnt},
			success:function(){
				location.href="/cart/list";
			}	
		})
	})
	
	
	//삭제버튼을 눌렀을떄 
	$("#tbl").on("click", ".row .delete", function () {
		var id= $(this).attr("id");
		if(!confirm(id+"상품을 장바구니에서 삭제하시겠습니까?")) return;
		
		$.ajax({
			type:"get",
			url:"/cart/delete",
			data:{id:id},
			success:function(){
				location.href='/cart/list';
			}
		})

	})

</script>
