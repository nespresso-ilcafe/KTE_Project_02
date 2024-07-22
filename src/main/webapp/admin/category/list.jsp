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
						<td id="b" style="border:0px">
							<select name="field" style="height:23px;">
								<option value="ca_id" <c:if test="${field == 'ca_id' }">selected</c:if>>대분류</option>
								<option value="ca_name" <c:if test="${field == 'ca_name' }">selected</c:if>>분류명</option>
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
		<td id="c" style="border-radius: 10px 0 0 0" align=center>NO</td>
		<td id="c" align=center>분류코드</td>
		<td id="c" align=center>분류명</td>
		<td id="c" align=center>판매가능</td>
		<td id="c" style="border-radius: 0 10px 0 0" align=center>관리</td>
	</tr>
	<c:set var="number" value="${number }"/>
	<c:forEach var="list" items="${v }">
	<tr>
		<form action="modify" method="post">
			<td id="b" align=center>${number }</td>
			<td id="b" align="center">
				<!-- 들여쓰기 설명 - fn:length() - 컬렉션의 항목 수 또는 문자열의 문자 수를 반환합니다. -->
	            <c:forEach var="id_num" begin="1" end="${fn:length(list.ca_id)-2}">
	                &nbsp;
	            </c:forEach>   
	        	<input name="ca_id" value="${list.ca_id }" class="ca_id" readonly>
	        </td>
			<td id="b" align=center><input name="ca_name" value="${list.ca_name }"></td>
			<td id="b" align=center>
				Y<input type="radio" name="ca_use" value="Y" <c:if test="${list.ca_use eq 'Y' }">checked</c:if>>
				N<input type="radio" name="ca_use" value="N" <c:if test="${list.ca_use eq 'N' }">checked</c:if>>
			</td>
			<td id="b" align=center>
				<button>수정사항 저장</button>
				<input type="button" value="삭제" onclick="location.href='delete?ca_id=${list.ca_id}'">
			</td>
		</form>
	</tr>
	<c:set var="number" value="${number-1 }"/>
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
							<a href="list?pageNum=${i }&field=${field}&search=${search}"><font color=black>${i }</font></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					<a href="list?pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
				</c:if>
			</c:if>
		</td>
		<td width=100 align=right id="b" style="border:0px"><a href="write" style="color:black">[분류등록]</a></td>
	</tr>
</table>
</center>

<%@ include file="/admin/include/footer.jsp" %>