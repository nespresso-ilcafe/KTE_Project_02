<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
	function a() {
		location.href = "orderbbsmodify?uid=${n.uid}";
	}
</script>

<center>
	<form action="delete?uid=${n.uid }" method="post">
	<br>
		<table width=800 bgcolor="black">
			<tr>
				<td align=center style="color:white;font-size:20px;">${n.subject }</td>
			</tr>
			<tr>
				<td align=center style="color:white;">${n.name }</td>
			</tr>
		</table>
		<table width=800 height="100" style="border-bottom:2px solid black;">
			<tr>
				<td align=center>${n.comment }</td>
			</tr>
		</table>
		<c:if test="${sessionScope.id == n.id || sessionScope.level == 10}">
			<table width=800>
				<tr>
					<td style="text-align: center">
						<button type="button" onclick="a()">수정</button>
						<button>삭제</button>
					</td>
				</tr>
			</table>
		</c:if>
		<br>
	</form>
</center>

<%@ include file="/include/footer.jsp" %>