<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
	.row {text-align:center;}
	.none {text-align:center; color:red;}
#condition form{}
#condition a{}
#tbl{margin-left:2%; margin-right: 2%}

</style>    
<h1>강좌목록</h1>
<div id="condition">
   <form name="frm" id="frm">
      <select name="key" id="key">
         <option value="lcode">강좌번호</option>
         <option value="lname">강좌이름</option>
         <option value="pname">담당교수</option>
      </select>
      
      <select name="per" id="per">
         <option value="5">5행</option>
         <option value="7" >7행</option>
         <option value="10"selected>10행</option>
         <option value="15">15행</option>
      </select>
      <select name="order" id="order">
         <option value="lcode">강좌번호</option>
         <option value=lname>강좌이름</option>
         <option value="pname">담당교수</option>
      </select>
      <select name="desc" id="desc">
         <option value="asc">오름차순</option>
         <option value="desc">내림차순</option>
      </select>
      <input type="text" name="word" placeholder="검색어">
      <button>검색</button>
      검색수:<span id="total"></span>
      
   </form>
<a href="/cou/insert"><button>강좌등록</button></a>
</div>

    
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
   <tr class="title">
      <td width=200>강좌번호</td>
      <td width=300>강좌이름</td>
      <td width=200>담당교수</td>
      <td width=150>강의실</td>
      <td width=350>수강인원</td>
	 <td width=200>강의시수</td>
   </tr>
   {{#each array}}
   <tr class="row" onclick="location.href='/cou/read?lcode={{lcode}}'">
      <td class="lcode">{{lcode}}</td>
      <td class="lcode">{{lname}}</td>
      <td class="lcode">{{pname}}/{{dept}}</td>
      <td class="lcode">{{room}}</td>
      <td class="lcode">{{persons}}/{{capacity}}</td>
	  <td class="lcode">{{hours}}</td>
   </tr>
   {{/each}}
</script>

<div class="buttons">
   <button id="prev">이전</button>
   <span id="page">1/10</span>
   <button id="next">다음</button>
</div>

<script>
   var page=1;
   getList();
   
   $(frm).on("submit", function(e){
      e.preventDefault();
      page=1;
      getList();
   });
   
   $("#key, #per, #order, #desc").on("change", function(){
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
      var key=$(frm.key).val();
      var word=$(frm.word).val();
      var per=$(frm.per).val();
      var order=$(frm.order).val();
      var desc=$(frm.desc).val();
      $.ajax({
         type:"get",
         url:"/cou/list.json",
         dataType:"json",
         data:{key:key,word:word,per:per,order:order,desc:desc,page:page},
         success:function(data){
            //console.log(JSON.stringify(data));
            var temp=Handlebars.compile($("#temp").html());
            $("#tbl").html(temp(data));
            $("#total").html(data.total);
            
            if(data.total==0){
               $("#tbl").append("<tr><td colspan=6 class='none'>검색된 강좌가 없습니다!</td></tr>");
               $(".buttons").hide();
            }else{
               $("#page").html(page + "/" + data.last);
               
               if(page==1) $("#prev").attr("disabled", true);
               else $("#prev").attr("disabled", false);
               
               if(page==data.last) $("#next").attr("disabled", true);
               else $("#next").attr("disabled", false);
               $(".buttons").show();
            }
         }
      });
   }
</script>