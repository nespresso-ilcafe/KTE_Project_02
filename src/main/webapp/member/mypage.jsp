<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<c:if test="${sessionScope.id ne iq.mb_id && sessionScope.id eq null}">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>

<center>
	<table width=1000 border=0>
		<br><br>
		<tr>
			<c:set var="m" value="${m }"/>
			<td align=center class="poor-story-regular" style="font-size: 20px" colspan=3>
				<span style="font-weight: bold;color:blue">${sessionScope.name }</span>님의 Page / 현재 포인트 : ${m.point }
			</td>
		</tr>
		<tr height=10px></tr>
		<tr>
			<td width=200></td>
			<td width=600><a href="/member/modify">
				<table class="hover-gray-border" width=600 style="border-spacing: 0px;border:1px solid gray;font-size:14px">
					<tr>
						<td><span class="hover-gray" style="font-weight: bold;font-size:16px">profile 회원 수정</span><br>
						<span class="hover-gray">회원이신 고객님의 개인정보를 관리하는 공간입니다.<br>
						개인정보를 최신 정보로 유지하시면 보다 간편한 쇼핑을 즐기실 수 있습니다.</span></td>
					</tr>
				</table>
			</a></td>
			<td width=200></td>
		</tr>
		<tr height=10></tr>
		<tr>
			<td></td>
			<td><a href="/wish/wishlist">
				<table class="hover-gray-border" width=600 style="border-spacing: 0px;border:1px solid gray;font-size:14px">
					<tr>
						<td><span class="hover-gray" style="font-weight: bold;font-size:16px">wishlist 관심 상품</span><br>
						<span class="hover-gray">관심상품으로 등록하신 상품의 목록을 보여드립니다.</span></td>
					</tr>
				</table>
			</a></td>
			<td></td>
		</tr>
		<tr height=10></tr>
		<tr>
			<td></td>
			<td><a href="/orders/userorderlist?mb_id=${m.id }">
				<table class="hover-gray-border" width=600 style="border-spacing: 0px;border:1px solid gray;font-size:14px">
					<tr>
						<td><span class="hover-gray" style="font-weight: bold;font-size:16px">order 주문내역 조회</span><br>
						<span class="hover-gray">고객님께서 주문하신 상품의 주문내역을 확일하실 수 있습니다.</span><br></td>
					</tr>
				</table>
			</a></td>
			<td></td>
		</tr>
	</table>
	<br>
	<br>
</center>

<%@ include file="/include/footer.jsp" %>