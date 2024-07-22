<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/admin/include/header.jsp" %>
<c:if test="${sessionScope.level eq 10 && sessionScope.id eq null }">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>

<center>
    오더 리스트
	<c:forEach var="a" items="${a }">
    <table border="1" width="1200">
		<tr>
			<td colspan="7">[${a.od_id }] 주문상태 : [${a.ct_status }]</td>
		</tr>
		<tr>
			<td colspan="7">구매자 정보</td>
		</tr>
		<tr>
			<td>아이디 : [${a.mb_id }]</td>
			<td>이름 : [${a.name }]</td>
			<td>주문일자 : [${a.or_date }]</td>
			<td>연락처 : [${a.pn }]</td>
			<td>구매수량 : [${a.it_qty }]</td>
		</tr>
		<tr>
			<td colspan="7">제품정보</td>
		</tr>
		<tr>
			<td>제품ID : <a href="/item/view?it_uid=${a.it_uid }&category2=${a.cate2 }">[${a.it_uid }]</a></td>
			<td>제품명 : <a href="/item/view?it_uid=${a.it_uid }&category2=${a.cate2 }">[${a.it_name }]</a></td>
			<td>가격 : [<fmt:formatNumber value="${a.it_price }"/>원]</td>
			<td>적립금 : [${a.it_point }]</td>
			<td>[${a.it_opt1 }]</td>
		</tr>
		<tr>
			<td colspan="7">구매자 정보</td>
		</tr>
		<tr>
			<td>${a.zc }</td>
			<td colspan="2">${a.zc1 }</td>
			<td>${a.zc2 }</td>
			<td>${a.zc3 }${a.zc4 }</td>
		</tr>
    </table>
    <br>
	</c:forEach>
	<input type="button" value="목록" onclick="location.href = '/admin/orders/adminorderlist'">
</center>
<%@ include file = "/include/footer.jsp" %>


