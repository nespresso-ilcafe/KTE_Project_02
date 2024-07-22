<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/include/header.jsp" %>
<c:if test="${sessionScope.level eq 10 && sessionScope.id eq null }">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>
<style>
	input[type=button]{
		color:white;
		background-color:black;
		border:none;
		height:40px;
		font-size:18px;
	}
</style>
<center>
<br>
<table width="1000" bgcolor="black">
	<tr>
		<td width="5"></td>
		<td align="left">
			<input type="button" value="뒤로가기" onclick="location.href = '/orders/userorderlist?mb_id=${mb_id }'">
		<td>
	</tr>
</table>
<br>
	<c:forEach var="a" items="${orArr }">
	<input type="hidden" value="${a.or_uid }">
	<input type="hidden" value="${a.mb_id }">
    <table width="1000" style="border-top:2px solid black;border-bottom:2px solid black;">
    	<tr>
    		<td align="center" rowspan="15" width="200">
    		<a href="/item/view?it_uid=${a.it_uid }&od_id=${a.od_id }">
    			<img src="/upload_item/${a.file1_thumb }"></a>
    		</td>
    	</tr>
		<tr>
			<td colspan="7">[${a.od_id }]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<c:choose>
					<c:when test="${a.ct_status eq '완료' }">
						<input type="button" value="구매확정" onclick="location.href = '/orders/buyclear?it_uid=${a.it_uid }&od_id=${a.od_id }&or_uid=${a.or_uid }'">
					</c:when>
					<c:when test="${a.ct_status eq '구매확정' }">
						<input type="button" value="리뷰쓰기" onclick="location.href = '/item/reviewsWrite?it_uid=${a.it_uid }&od_id=${a.od_id }&mb_id=${a.mb_id }&or_uid=${a.or_uid }'">
					</c:when>
					<c:when test="${a.ct_status eq '리뷰작성' }">
						<span>리뷰 작성 완료!</span>
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr><td colspan="7" style="border-bottom:1px solid black;"></td></tr>
		<tr>
			<td align="center" colspan="7" height="20">구매자 정보</td>
		</tr>
		<tr>
			<td align="center" width="125">아이디<br>[${a.mb_id }]</td>
			<td align="center" width="125">이름<br>[${a.name }]</td>
			<td align="center" width="125">주문일자<br>[${a.or_date }]</td>
			<td align="center" width="125">연락처<br>[${a.pn }]</td>
			<td align="center">구매수량<br>[${a.it_qty }]</td>
		</tr>
		<tr>
			<td align="center" colspan="7"  width="250">${a.zc }${a.zc1 }${a.zc2 }${a.zc3 }${a.zc4 }</td>
		</tr>
		<tr><td align="center" colspan="7" style="border-bottom:1px solid black;"></td></tr>
		<tr>
			<td align="center" colspan="7" height="20">제품정보</td>
		</tr>
		<tr>
			<td align="center">제품ID<br><a href="/item/view?it_uid=${a.it_uid }&category2=${a.category2 }">[${a.it_uid }]</a></td>
			<td align="center" colspan="2">제품명<br><a href="/item/view?it_uid=${a.it_uid }&category2=${a.category2 }">[${a.it_name }]</a></td>
			<td align="center">가격<br>[<fmt:formatNumber value="${a.it_price }"/>원]</td>
			<td align="center">적립금<br>[${a.it_point }]</td>
		</tr>
		<tr>
			<td align="center" colspan="7">[${a.it_opt1 }]</td>
		</tr>
		<tr><td colspan="7" style="border-bottom:1px solid black;"></td></tr>
    </table>
    <br>
	</c:forEach>
</center>
<br>
<%@ include file = "/include/footer.jsp" %>


