<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<script>
	function a() {
		alert("로그인 후 이용해주세요.");
		location.href = "/member/login";
	}
	function validateForm() {
		var subject = document.getElementById("subject").value;
		var comment = document.getElementById("comment").value;
		if (subject == "") {
			alert("제목을 입력하세요.");
			return false;
		} else if (comment == "") {
			alert("내용을 입력하세요.");
			return false;
		}
		return true;
	}
</script>

<center>
	<form action="write" method="post" onsubmit="return validateForm()">
		<input type="hidden" name="id" value="${sessionScope.id }">
		<input type="hidden" name="name" value="${sessionScope.name }">
		<br>
	    <span style="font-weight: bold;font-size:17px" class="poetsen-one-regular">Create a post</span>
	    <br><br>
		<table width=1000>
			<tr>
				<td align=center height=30>작성자</td>
				<td>${sessionScope.name }</td>
			</tr>
			<tr><td colspan=10 height=1 bgcolor="#EAEAEA"></td></tr>
			<tr>
				<td align=center height=30>제목</td>
				<td>
					<input style="width:99%" type="text" id="subject" name="subject">
				</td>
			</tr>
			<tr><td colspan=10 height=1 bgcolor="#EAEAEA"></td></tr>
			<tr>
				<td align=center height=150>내용</td>
				<td>
					<textarea id="comment" name="comment" style="height:130px;width:99%;"></textarea>
				</td>
			</tr>
			<tr><td colspan=10 height=1 bgcolor="#EAEAEA"></td></tr>
		</table>
		<table>
			<tr>
				<c:choose>
					<c:when test="${sessionScope.id == null}">
						<td><button type="button" onclick="a()">작성완료</button></td>
					</c:when>
					<c:otherwise>
						<td><button type="submit">작성완료</button></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
	</form>
</center>

<%@ include file="/include/footer.jsp" %>