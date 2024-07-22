<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
	function a(){
		location.href = "/orderbbs/delete";
	}
</script>

<center>
	<form action="orderbbsmodify?uid=${n.uid }" method="post">
		<br>
		<table width=1000>
			<tr>
				<td>작성자</td>
				<td align=center>${n.name }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input name="subject" style="width:95%" value=${n.subject }></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="comment" style="width:95%" rows="15">${n.comment }</textarea></td>
			</tr>
		</table>
		<c:choose>
			<c:when test="${sessionScope.id == n.id }">
				<table width=1000>
					<tr>
						<td align="center"><button>수정</button></td>
					</tr>
				</table>
			</c:when>
		</c:choose>
		<br>
	</form>
</center>

<%@ include file="/include/footer.jsp" %>