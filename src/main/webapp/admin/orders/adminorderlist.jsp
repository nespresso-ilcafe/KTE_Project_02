<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<script>
function check1(od_id){
    if(confirm("배송상태로 전환하시겠습니까?")) {
        location.href = "/admin/orders/ordersend?od_id="+od_id;
        alert("완료되었습니다.");
    } else {
        alert("취소되었습니다.");
    }
}
	
function check2(od_id){
    if(confirm("완료상태로 전환하시겠습니까?")) {
        location.href = "/admin/orders/orderclear?od_id="+od_id;
        alert("완료되었습니다.");
    } else {
        alert("취소되었습니다.");
    }
}
</script>

<center id="b">
    <table style="border:0px;background-color: white" width=1200>
		<tr>
			<br><td align="left" style="background-color: white;color:black;font-size:20px;font-weight: bold">Total : ${count }</td>
		</tr>
    	<tr><td style="background-color: white;color:black" height="1" ></td></tr>
		<tr>
			<td colspan="8" style="background-color: white;color:black">
			<table width="1200" align=center style="background-color:white;border:1px solid black;border-radius: 10px 10px 0 0;border-spacing: 0px;">
				<tr>
					<td id="c" style="border-radius: 10px 0 0 0"> 주문번호 </td>
					<td id="c"> 아이디 </td>
					<td id="c"> 이름 </td>
					<td id="c"> 구매 총액 </td>
					<td id="c"> 현재 상태 </td>
					<td id="c" style="border-radius: 0 10px 0 0"> 상태 변경 </td>
				</tr>
				<c:forEach var="a" items="${a }">
					<tr>
						<td id="b" width="200"><a href="/admin/orders/adminorderview?od_id=${a.od_id }" style="color:black">${a.od_id}</a></td>
						<td id="b">${a.mb_id }</td>
						<td id="b">${a.name }</td>
						<td id="b">
							<fmt:formatNumber value="${a.total_price }"/> 원
						</td>
						<td id="b">${a.ct_status }</td>
						<td id="b">
						    <c:choose>
						        <c:when test="${a.ct_status eq '주문' }">
						            <input type="button" value="배송" onclick="check1('${a.od_id }')">
						        </c:when>
						        <c:when test="${a.ct_status eq '배송' }">
						            <input type="button" value="완료" onclick="check2('${a.od_id }')">
						        </c:when>
						        <c:when test="${a.ct_status eq '완료' }">
						            <input value="배송완료" readonly>
						        </c:when>
						        <c:when test="${a.ct_status eq '리뷰작성' }">
						            <input value="리뷰작성" readonly>
						        </c:when>
						    </c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
			</td>
		</tr>
    </table>
    <!--페이징-->
	<table style="border:0px;background-color: white">
		<tr>
			<td id="b" style="border:0px">
				<c:if test="${count>0 }">
					<fmt:parseNumber var="pageCount" value="${count/pageSize+(count%pageSize==0?0:1)}" integerOnly="true"/>
					<c:set var="startPage" value="${1 }"/>
					<c:set var="pageBlock" value="${10 }"/>
					<c:if test="${pageNum>pageBlock }">
						<fmt:parseNumber var="startPage" value="${(pageNum/pageBlock-(pageNum%pageBlock==0?1:0))*pageBlock+1 }" integerOnly="true"/>
					</c:if>
					<fmt:parseNumber var="endPage" value="${startPage+pageBlock-1 }" integerOnly="true"/>
					<c:if test="${endPage>pageCount }">
						<c:set var="endPage" value="${pageCount }"/>
					</c:if>
					<c:if test="${startPage>pageBlock }">
						<a href="adminorderlist?pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
					</c:if>
					<c:forEach var="i" begin="${startPage }" end="${endPage }">
						<c:choose>
							<c:when test="${pageNum == i }">
								<a href="adminorderlist?pageNum=${i }&field=${field}&search=${search}"><font color=red>${i }</font></a>
							</c:when>
							<c:otherwise>
								<a href="adminorderlist?pageNum=${i }&field=${field}&search=${search}"><font color=black>${i }</font></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${endPage < pageCount}">
						<a href="adminorderlist?pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
					</c:if>
				</c:if>
			</td>
		</tr>
	</table>
</center>
<%@ include file = "/admin/include/footer.jsp" %>