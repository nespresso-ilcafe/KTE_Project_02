<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file = "/include/header.jsp"%>
<style>
	button{
		width:80px;
		height:40px;
		background-color:white;
		border:none;
	}
</style>
<center>
<form method="post">
<br>
<table width=400 style="border-spacing: 0px;border:2px solid #AFB5B9">
	<tr height=30></tr>
	<tr>
		<td style="font-weight: bold;font-size:25px" align=center colspan=3 class="poetsen-one-regular">Member Login</td>
	</tr>
	<tr>
		<td align=center colspan=3 style="font-size:12px">가입시 입력하신 아이디와 비밀번호로 로그인이 가능합니다.</td>
	</tr>
	<tr height=30></tr>
	<tr>
		<td align="center" width="100" style="padding-left:20px">아이디</td>
		<td align="center"><input id="mb_id" name="mb_id" class="input-underlined" tabindex="1"></td>
		<td align="center" width="100" rowspan="2" tabindex="3"><button>로그인</button></td>
	</tr>
	<tr>
		<td align="center" style="padding-left:20px">비밀번호</td>
		<td align="center"><input type="password" id="mb_pass" name="mb_pass" class="input-underlined" tabindex="2"></td>
	</tr>
	<tr height=10></tr>
	<tr>
		<td style="padding-left:20px" colspan="3" align="center"><a href="/member/join">회원가입</a></td>
	</tr>
	<tr height=10></tr>
</table>

<table width="400" height="40" bgcolor="black">
	<tr>
		<td colspan="2" align="center">
			<span onclick="kakaoLogin()" style="cursor:pointer;color:white;">[카카오 로그인]</span>
			<span id="naverIdLogin_loginButton" style="cursor:pointer;color:white;">[네이버 로그인]</span>
		</td>
	</tr>
</table>
<br>
</form>
</center>

<%@include file = "/include/footer.jsp"%>


