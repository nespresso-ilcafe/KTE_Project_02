<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<center>
<table width=100% height=50 border=0>
	<tr>
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[메일 보내기]</td>
	</tr>
</table>

<form action="/member/mailSend" method="post">
<table width="500" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width=100>받는 사람 메일</td>
		<td style="padding:2px 0px">
			<input name="receiver" style="height:18px;width:96%;border:1px solid #e9e9e9;background:#f7f7f7;">
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td style="padding:2px 0px">
			<input name="subject" style="height:18px;width:96%;border:1px solid #e9e9e9;background:#f7f7f7;">
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td style="padding:2px 0px">
			<textarea name="content" style="height:40px;width:96%;border:1px solid #e9e9e9;background:#f7f7f7;">
			</textarea>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><button>메일 보내기</button></td>
	</tr>
</table>
</form>
</center>
<br>

<%@ include file="/include/footer.jsp" %>