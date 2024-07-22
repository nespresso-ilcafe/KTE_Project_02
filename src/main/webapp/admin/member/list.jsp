<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<script>
var popupX = (window.screen.width / 2) - (560 / 2);
var popupY= (window.screen.height /2) - (660 / 2);

	function popup(a){
		window.open("view?id="+a,"view","width=560,height=660,left="+popupX+",top="+popupY);
	}
</script>
<center style="background-color:white;color:black;font-weight: bold;font-size:20px">
<br>Total : ${count}
<table style="border:0px;background-color: white">
	<tr>
		<td>
			<form action="list">
				<table>
					<tr>
						<td style="background-color:white;border:0px solid black">
							<select name="field" style="height:23px;">
								<option value="id" <c:if test="${field == 'id' }">selected</c:if>>아이디</option>
								<option value="name" <c:if test="${field == 'name' }">selected</c:if>>이름</option>
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
<table width=1200 border=0 style="background-color:white;border:1px solid black;border-radius: 10px 10px 0 0;border-spacing: 0px;">
	<tr>
		<td id="c" style="border-radius: 10px 0 0 0">NO</td>
		<td id="c">ID</td>
		<td id="c">이름</td>
		<td id="c">Email</td>
		<td id="c">로그인 타입</td>
		<td id="c">레벨</td>
		<td id="c">상태</td>
		<td id="c" style="border-radius: 0 10px 0 0">MODE</td>
	</tr>
	<c:set var="number" value="${number}"/>
	<c:forEach var="list" items="${v }">
	<tr>
		<td id="b">${number }</td>
		<td id="b">${list.id }</td>
		<td id="b">${list.name }</td>
		<td id="b">${list.email }</td>
		<td id="b">${list.connecttype }</td>
		<td id="b">${list.level }</td>
		<td id="b">
			<c:choose>				
				<c:when test="${list.status eq '정지' }"><font color=red>${list.status }</font></c:when>
				<c:when test="${list.status eq '탈퇴' }"><font color=red>${list.status }</font></c:when>				
				<c:otherwise>${list.status }</c:otherwise>
			</c:choose>
		</td>
		<td align=center id="b">	
			<span onclick="popup('${list.id}')" style="cursor:pointer;">[상세]</span>
		</td>
	</tr>
	<c:set var="number" value="${number-1 }" />
	</c:forEach>
</table>
<!--페이징-->
<table style="border:0px;background-color: white">
	<tr>
		<td id="b" style="border:0px">
			<c:if test="${count>0 }">
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
	</tr>
</table>
</center>
<%@ include file="/admin/include/footer.jsp" %>