<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<center>
<br>
<c:if test="${sessionScope.id eq null }">
	<script type="text/javascript">
		alert("로그인후 이용 가능합니다!");
		location.href = "/member/login";
	</script>
</c:if>

<c:if test="${sessionScope.level ne 10 && sessionScope.id ne iq.mb_id }">
	<script type="text/javascript">
		alert("작성자와 관리자만 볼 수 있습니다!");
		history.back();
	</script>
</c:if>

<FORM action="/item/iqModify">
<input type="hidden" name="qna_uid" value="${iq.qna_uid }">
<input type="hidden" name="it_uid" value="${iq.it_uid }">
<table width="600" bgcolor="black">
	<tr height="40">
		<td align="center" style="color:white;font-size:18px;font-weight:bold;">${iq.qna_subject }</td>
		<td align="center" width="100" style="color:white;font-size:14px;">
			<c:choose>
				<c:when test="${iq.type1 eq 1}">재입고 문의</c:when>
				<c:when test="${iq.type1 eq 2}">사이즈 문의</c:when>
				<c:when test="${iq.type1 eq 3}">커스텀 문의</c:when>
				<c:when test="${iq.type1 eq 4}">배송/반품 문의</c:when>
				<c:when test="${iq.type1 eq 5}">기타 문의</c:when>
			</c:choose>
		</td>
	</tr>
</table>
<table width="600" style="border:1px solid black">
	<tr><td colspan="2" height="10"></td></tr>
	<tr>
		<td colspan="2" align="center">
			<textarea cols="60" rows="10" style="border:none;text-align:center;font-size:16px;" readonly>${iq.comment }</textarea>
		</td>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>
</table>
<table width="600" height="40" bgcolor="black" border="1">
	<tr>
		<td></td>
		<c:choose>
			<c:when test="${sessionScope.level eq 10 }">
				<td align="center" width="75">
					<input type="button" value="답변" style="border:none;color:white;font-size:16px;font-weight:bold;background-color:black;"
					 onclick="location.href = '/item/iqAnswer?it_uid=${iq.it_uid}&qna_uid=${iq.qna_uid}'">
				</td>
				<td align="center" width="75">
					<span onclick="location.href = '/item/iqDelete?it_uid=${iq.it_uid}&category2=?&qna_uid=${iq.qna_uid}&thread=${iq.thread }&fid=${iq.fid }'"
					style="text-align:center;width:75px;color:white;font-size:16px;background-color:black;">삭제</span>
				</td>
				<td align="center" width="75">
					<button style="border:none;color:white;font-size:16px;font-weight:bold;background-color:black;">수정</button>
				</td>
			</c:when>
			<c:when test="${sessionScope.id eq iq.mb_id}">
				<td align="center" width="75">
					<span onclick="location.href = '/item/iqDelete?it_uid=${iq.it_uid}&category2=?&qna_uid=${iq.qna_uid}&thread=${iq.thread }&fid=${iq.fid }'"
					style="text-align:center;width:75px;color:white;font-size:16px;background-color:black;">삭제</span>
				</td>
				<td align="center" width="75">
					<button style="border:none;color:white;font-size:16px;font-weight:bold;background-color:black;">수정</button>
				</td>
			</c:when>
		</c:choose>
	</tr>
</table>
<br>
</FORM>
</center>
<%@include file = "/include/footer.jsp"%>