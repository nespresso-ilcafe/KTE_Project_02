<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file = "/include/header.jsp"%>
<c:if test="${sessionScope.id eq null }">
	<script type="text/javascript">
		alert("로그인후 이용 가능합니다!");
		location.href = "/member/login";
	</script>
</c:if>
<center>
<br>
<table bgcolor="black" width="600">
	<tr>
		<td align="center" style="color:white">모든 문의사항은 비밀글로 작성되며</td>
	</tr>
	<tr>
		<td align="center" style="color:white">작성자와 관리자를 제외하고는 볼 수 없습니다!</td>
	</tr>
</table>
<form method="post">
<table width="600" style="border-bottom:2px solid black;border-top:2px solid black">
	<tr>
		<td width="225" align="center">제목</td>
		<td width="75" align="center">문의종류</td>
	</tr>
	<tr>
		<td align="center" width="500">
			<input name="qna_subject" placeholder="제목을 작성해주세요" style="width:500px;height:30px;font-size:16px;text-align:center;border:none" required>
		</td>
		<td align="center" width="100">
			<select name="type1" style="width:100px;height:20px;text-align:center;font-size:16px">
				<option value="1">재입고</option>
				<option value="2">사이즈</option>
				<option value="3">커스텀</option>
				<option value="4">배송/반품</option>
				<option value="5">기타</option>
			</select>
		</td>
	</tr>
	<tr><td colspan="2" style="border-bottom:1px solid black"></td></tr>
	<tr>
		<td align="center" colspan="2">
			<textarea name="comment" cols="70" rows="10"placeholder="문의 내용을 작성해주세요" style="text-align:center;" required></textarea>
		</td>
	</tr>
	<br>
	<tr>
		<td align="center" colspan="2">
			<button style="width:100px;height:40px;color:white;background-color:black;">작성완료</button>
		</td>
	</tr>
</table>
</form>
<br>
<table bgcolor="black" width="600">
	<tr>
		<td align="center" style="color:white">문의 답변은 평균적으로 7일 이내 이뤄집니다!</td>
	</tr>
	<tr>
		<td align="center" style="color:white">참고부탁드립니다!</td>
	</tr>
</table>
<br>
</center>

<%@include file = "/include/footer.jsp"%>
