<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<center style="background-color:white;color:black;font-weight: bold;font-size:20px">
	<br>Total : ${count}<br><br>
	<table width=1200 border=1 style="background-color:white;border:1px solid black;border-radius: 10px 10px 0 0;border-spacing: 0px;">
		<tr>
			<td id="c" align=center width=100 style="border-radius: 10px 0 0 0">NO</td>
			<td id="c">배너 코드</td>
			<td id="c">배너 이미지</td>
			<td id="c">배너 이름</td>
			<td id="c" align=center style="border-radius: 0 10px 0 0">관리</td>
		</tr>
		<tr>
		<c:set var="number" value="${number}"/>
		<c:forEach var="v" items = "${v }">
			<td id="b" align=center>${number }</td>
			<td id="b" align=center>${v.uid }</td>
			<td id="b" align=center>
				<img src="/upload_item/${v.file1_thumb }" style="width:350px;height:150px;">
			</td>
			<td id="b" align=center>${v.subject }</td>
			<td id="b" align=center>
				<a href="bannermodify?uid=${v.uid }" style="color:black">[수정]</a>
				<a href="bannerdelete?uid=${v.uid }" style="color:black">[삭제]</a>
			</td>
		</tr>
		<c:set var="number" value="${number - 1 }"/>
		</c:forEach>
	</table>
	<!-- 페이징 -->
	<table width=1200 style="border:0px;background-color: white">
		<tr>
			<td align=center style="background-color: white">
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
			<td width=100 align=right style="background-color: white"><a href="bannerwrite" style="color:black">[배너등록]</a></td>
		</tr>
	</table>
</center>

<%@ include file="/admin/include/footer.jsp" %>