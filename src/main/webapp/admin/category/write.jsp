<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>
<center>
<table style="background-color: white">
		<tr>
			<td>
				<input type="button" value="뒤로가기" onclick="location.href = '/admin/category/list'">
			</td>
		</tr>
	</table>
<form method="post">
<br>
<table width=500>
	<tr>
		<td id="b">분류코드</td>
		<td id="b"><input name="ca_id"></td>
	</tr>
	<tr>
		<td id="b">분류명</td>
		<td id="b"><input name="ca_name"></td>
	</tr>
	<tr>
		<td id="b">판매가능</td>
		<td id="b">
			Y<input type="radio" name="ca_use" value="Y" checked>
			N<input type="radio" name="ca_use" value="N">
		</td>
	</tr>
</table>
<table style="background-color: white">
	<tr>
		<td><button style="cursor:pointer">분류추가</button></td>
	</tr>
</table>
</form>
</center>
<%@ include file="/admin/include/footer.jsp" %>