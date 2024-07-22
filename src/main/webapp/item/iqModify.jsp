<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<center>
<c:if test="${sessionScope.id ne iq.mb_id && sessionScope.id eq null}">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>
상품 문의글 보기
<FORM method="post">
<input type="hidden" name="qna_uid" value="${iq.qna_uid }">
<input type="hidden" name="it_uid" value="${iq.it_uid }">
<table width="600" style="border-bottom:2px solid black;border-top:2px solid black">
	<tr>
		<td width="225" align="center">제목</td>
		<td width="75" align="center">문의종류</td>
	</tr>
	<tr>
		<td align="center" width="500">
			<input name="qna_subject" value="${iq.qna_subject }" style="width:500px;height:30px;font-size:16px;text-align:center;border:none" required>
		</td>
		<td align="center" width="100">
			<select name="type1" style="width:100px;height:20px;text-align:center;font-size:16px">
			<c:choose>
				<c:when test="${iq.type1 eq 1}">
					<option value="1" selected>재입고</option>
					<option value="2">사이즈</option>
					<option value="3">커스텀</option>
					<option value="4">배송/반품</option>
					<option value="5">기타</option>
				</c:when>
				<c:when test="${iq.type1 eq 2}">
					<option value="1">재입고</option>
					<option value="2" selected>사이즈 문의</option>
					<option value="3">커스텀</option>
					<option value="4">배송/반품</option>
					<option value="5">기타</option>
				</c:when>
				<c:when test="${iq.type1 eq 3}">
					<option value="1">재입고</option>
					<option value="2">사이즈</option>
					<option value="3" selected>커스텀 문의</option>
					<option value="4">배송/반품</option>
					<option value="5">기타</option>
				</c:when>
				<c:when test="${iq.type1 eq 4}">
					<option value="1">재입고</option>
					<option value="2">사이즈</option>
					<option value="3">커스텀</option>
					<option value="4" selected>배송/반품 문의</option>
					<option value="5">기타</option>
				</c:when>
				<c:when test="${iq.type1 eq 5}">
					<option value="1">재입고</option>
					<option value="2">사이즈</option>
					<option value="3">커스텀</option>
					<option value="4">배송/반품</option>
					<option value="5" selected>기타 문의</option>
				</c:when>
			</c:choose>
			</select>
		</td>
	</tr>
	<tr><td colspan="2" style="border-bottom:1px solid black"></td></tr>
	<tr>
		<td align="center" colspan="2">
			<textarea name="comment" cols="70" rows="10"placeholder="문의 내용을 작성해주세요" style="text-align:center;" required>
			${iq.comment }</textarea>
		</td>
	</tr>
	<br>
	<tr>
		<td align="center" colspan="2">
			<button style="width:100px;height:40px;color:white;background-color:black;">수정완료</button>
		</td>
	</tr>
</table>
</form>
<br>
</center>
<%@include file = "/include/footer.jsp"%>