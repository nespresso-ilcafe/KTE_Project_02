<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
	function a(){
		location.href = "/notice/delete";
	}
</script>

<center>
	<form action="noticemodify?uid=${n.uid }" method="post">
		<table width=1000>
			<tr>
				<td>작성자</td>
				<td align=center>${n.name }</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input style="width:95%" name="subject" value=${n.subject }></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea style="width:95%" name="comment" value=${n.comment }></textarea></td>
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
			<c:otherwise></c:otherwise>
		</c:choose>
	</form>
</center>

<%@ include file="/include/footer.jsp" %>