<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<center style="background-color:white;color:black;font-weight: bold;font-size:20px">
<br>Total : ${count}
<table style="border:0px;background-color: white">
	<tr>
		<td id="b" style="border:0px">
			<form action="list">
				<table>
					<tr>
						<td style="border:0px;background-color: white">
							<select name="field" style="height:23px;">
								<option value="it_uid" <c:if test="${field == 'it_uid' }">selected</c:if>>상품코드</option>
								<option value="it_name" <c:if test="${field == 'it_name' }">selected</c:if>>상품명</option>
							</select>
							<input name="search" value="${search }" style="height:23px;">
							<button>검색</button>
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
</table>
<table width=1200 id="b" style="border:1px solid black;border-radius: 10px 10px 0 0;border-spacing: 0px;">
	<tr>
		<td id="c" style="border-radius: 10px 0 0 0" align=center width=50>NO</td>
		<td id="c" align=center width=50>상품코드</td>
		<td id="c" align=center width=100>이미지</td>
		<td id="c" align=center width=500>상품명</td>
		<td id="c" align=center width=200>가격(할인 전 가격)</td>
		<td id="c" align=center width=50>판매가능</td>
		<td id="c" align=center width=100>재고</td>
		<td id="c" style="border-radius: 0 10px 0 0" align=center width=150>관리</td>
	</tr>
	<tr>
	<c:set var="number" value="${number}"/>
	<c:forEach var="v" items = "${v }">
		<td id="b" align=center>${number }</td>
		<td id="b" align=center>${v.it_uid }</td>
		<td id="b" align=center>
			<img src="/upload_item/${v.file1_thumb }" style="width:50px;height:50px;">
		</td>
		<td id="b" align=center>${v.it_name }</td>
		<td id="b" align=center>
			<c:choose>
				<c:when test="${v.it_sale == 0 }">정상가 : <fmt:formatNumber value="${v.it_price }"/></c:when>
				<c:otherwise>할인가 : <fmt:formatNumber value="${v.it_sale }"/></c:otherwise>
			</c:choose>
		</td>
		<td id="b" align=center>${v.it_use }</td>
		<td id="b" align=center>${v.it_qty }</td>
		<td id="b" align=center>
			<a href="view?it_uid=${v.it_uid }" style="color:black">[관리]</a>
			<a href="delete?it_uid=${v.it_uid }" style="color:black">[삭제]</a>
		</td>
	</tr>
	<c:set var="number" value="${number - 1 }"/>
	</c:forEach>
</table>
<!-- 페이징 -->
<table width=1200 style="border:0px;background-color: white">
	<tr>
		<td align=center id="b" style="border:0px">
			<c:if test="${count > 0 }">
				<fmt:parseNumber var="pageCount" value="${count/pageSize+(count%pageSize==0?0:1)}" integerOnly="true"/>
				<c:set var="startPage" value="${1 }"/>
				<c:set var="pageBlock" value="${10 }"/>
				<c:if test="${pageNum>pageBlock }">
					<fmt:parseNumber var="startPage" value="${(pageNum/pageBlock-(pageNum%pageBlock==0?1:0))*pageBlock+1 }" integerOnly="true"/>
				</c:if>
				<fmt:parseNumber var="endPage" value="${startPage+pageBlock-1 }" integerOnly="true"/>
				<c:if test="${endPage>pageCount }">
					<c:set var="endPage" value="${pageCount }"/>
				</c:if>
				<c:if test="${startPage>pageBlock }">
					<a href="list?pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:choose>
						<c:when test="${pageNum == i }">
							<a href="list?pageNum=${i }&field=${field}&search=${search}"><font color=red>${i }</font></a>
						</c:when>
						<c:otherwise>
							<a href="list?pageNum=${i }&field=${field}&search=${search}"><font color="gray">${i }</font></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					<a href="list?pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
				</c:if>
			</c:if>
		</td>
		<td id="b" style="border:0px" width=100 align=right><a href="write" style="color:black">[상품등록]</a></td>
	</tr>
</table>
</center>
<%@ include file="/admin/include/footer.jsp" %>