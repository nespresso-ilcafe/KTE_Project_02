<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header_popup.jsp" %>
<script>
	function close1(){
		window.close();
	}
	function popupm(a){
		location.href="modify?id="+a;
	}
</script>
<center>
<table>
	<tr>
		<td align=center border=1>회원정보</td>
	</tr>
</table>
<table id="a">
	<tr>
		<td id="a">ID</td>
		<td id="a" width=300>${m.id }</td>
	</tr>
	<tr>
		<td id="a">비밀번호</td>
		<td id="a">${m.pass }</td>
	</tr>
	<tr>
		<td id="a">이름</td>
		<td id="a">${m.name }</td>
	</tr>
	<tr>
		<td id="a">생일</td>
		<td id="a">${m.birth }</td>
	</tr>
	<tr>
		<td id="a">전화번호</td>
		<td id="a">${m.pn }</td>
	</tr>
	<tr>
		<td id="a">Email</td>
		<td id="a">${m.email }</td>
	</tr>
	<tr>
		<td id="a">우편번호</td>
		<td id="a">${m.zc }</td>
	</tr>
	<tr>
		<td id="a">도로명주소</td>
		<td id="a">${m.zc1 }</td>
	</tr>
	<tr>
		<td id="a">지번주소</td>
		<td id="a">${m.zc2 }</td>
	</tr>
	<tr>
		<td id="a">상세주소</td>
		<td id="a">${m.zc3 }</td>
	</tr>
	<tr>
		<td id="a">참고항목</td>
		<td id="a">${m.zc4 }</td>
	</tr>
	<tr>
		<td id="a">가입일자</td>
		<td id="a">${m.signdate }</td>
	</tr>
	<tr>
		<td id="a">로그인 타입</td>
		<td id="a">${m.connecttype }</td>
	</tr>
	<tr>
		<td id="a">레벨</td>
		<td id="a">${m.level }</td>
	</tr>
	<tr>
		<td id="a">상태</td>
		<td id="a">${m.status }</td>
	</tr>
	<tr>
		<td id="a">성별</td>
		<td id="a">${m.gender }</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td id="a" onclick="popupm('${m.id}')" style="cursor:pointer">수정</td>
		<td width=20></td>
		<td id="a" onclick="close1()" style="cursor:pointer">창닫기</td>
	</tr>
</table>
</center>