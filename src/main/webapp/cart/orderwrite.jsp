<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/include/header.jsp" %>
<script>
window.onload = function(){
    <% session.removeAttribute("cart"); %>
}
</script>
<Style>
#gohome:hover{
	color:red;
}
</Style>

<c:if test="${sessionScope.level eq null && sessionScope.id eq null }">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>
<center>
<br>
<table width="1000" height="100">
	<tr>
		<td align="center" style="font-size:25px;">
			주문이 완료되었습니다!<br>
			감사합니다!<br><br><br><br><br>
			<div id="gohome" onclick="location.href = '/'">메인페이지</div>
		</td>
	</tr>
</table>
<br>
</center>
<%@ include file = "/include/footer.jsp" %>