<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<center>
<c:if test="${sessionScope.level eq null && sessionScope.id eq null }">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>
<br>
<FORM method="post">
<input type="hidden" name="thread" value="${iq.thread }">
<input type="hidden" name="fid" value="${iq.fid }">
<input type="hidden" name="type1" value="${iq.type1 }">
<input type="hidden" name="qna_uid" value="${iq.qna_uid }"><table width="600" style="border-bottom:2px solid black;border-top:2px solid black">
	<tr>
		<td width="225" align="center">제목</td>
	</tr>
	<tr>
		<td align="center" width="500">
			<input name="qna_subject" placeholder="제목을 작성해주세요" style="width:500px;height:30px;font-size:16px;text-align:center;border:none" required>
		</td>
	</tr>
	<tr><td style="border-bottom:1px solid black"></td></tr>
	<tr>
		<td align="center">
			<textarea name="comment" cols="70" rows="10"placeholder="문의 내용을 작성해주세요" style="text-align:center;" required></textarea>
		</td>
	</tr>
	<br>
	<tr>
		<td align="center">
			<button style="width:100px;height:40px;color:white;background-color:black;">답변완료</button>
		</td>
	</tr>
</table>
</form>
<br>
</FORM>
</center>
<%@include file = "/include/footer.jsp"%>