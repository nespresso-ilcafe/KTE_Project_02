<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<center>
	<table style="background-color: white">
		<tr>
			<td>
				<input type="button" value="뒤로가기" onclick="location.href = '/admin/banner/bannerlist'">
			</td>
		</tr>
	</table>
	<form action="bannerwrite" method="post" enctype="multipart/form-data">
	<br>
	<table width=1200 border=1>
		<tr>
			<td id="b">배너명</td>
			<td id="b" style="text-align:left">
				<input id="subject" name="subject">
			</td>
		</tr>
		<tr>
			<td id="b">배너 이미지</td>
			<td id="b" style="text-align:left">
				<input type="file" name="file1">
			</td>
		</tr>
	</table>
	<table style="background-color: white">
		<tr>
			<td>
				<button>배너등록</button>
			</td>
		</tr>
	</table>
	</form>
</center>

<%@ include file="/admin/include/footer.jsp" %>