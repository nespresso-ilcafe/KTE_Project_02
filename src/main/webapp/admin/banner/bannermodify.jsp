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
	<form action="bannermodify" method="post" enctype="multipart/form-data">
	<input type="hidden" name="uid" value="${b.uid }">
	<br>
	<table width=1200 border=1>
		<tr>
			<td id="b">배너명</td>
			<td id="b">
				<input id="subject" name="subject" value="${b.subject }">
			</td>
		</tr>
		<tr>
			<td id="b">배너 이미지</td>
			<td id="b">
				<input type="file" name="file1">
			</td>
		</tr>
		<tr>
			<td id="b" width=100>기존 이미지</td>
			<td id="b">
				<img src="/upload_item/${b.file1 }" width=890>
			</td>
		</tr>
	</table>
	<table style="background-color: white">
		<tr>
			<td>
				<button>수정</button>
			</td>
		</tr>
	</table>
	</form>
</center>

<%@ include file="/admin/include/footer.jsp" %>