<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	td {border:1px solid black;}
</style>    
<h1>교수정보</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100 class="title">교수번호</td>
			<td width=100><input type="text" value="${vo.pcode}" name="pcode" size=5></td>
			<td width=100 class="title">교수학과</td>
			<td width=200>
				<select name="dept">
					<option value="전산" <c:out value="${vo.dept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
					<option value="전자" <c:out value="${vo.dept=='전자'?'selected':''}"/>>전자공학과</option>
					<option value="건축" <c:out value="${vo.dept=='건축'?'selected':''}"/>>건축공학과</option>
				</select>
			</td>
			<td width=100 class="title">임용일자</td>
			<td width=300><input type="date" value="${vo.hiredate}" name="hiredate"></td>
		</tr>
		<tr>
			<td class="title">교수이름</td>
			<td><input type="text" value="${vo.pname}" name="pname" size="8"></td>
			<td class="title">교수급여</td>
			<td><input type="text" value="${vo.salary}" name="salary"></td>
			<td class="title">교수직급</td>
			<td>
				<input type="radio" name="title" value="정교수" <c:out value="${vo.title=='정교수'?'checked':''}"/>> 정교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="부교수" <c:out value="${vo.title=='부교수'?'checked':''}"/>> 부교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="조교수" <c:out value="${vo.title=='조교수'?'checked':''}"/>> 조교수
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button>정보수정</button>
		<button type="reset">수정취소</button>
	</div>
</form>