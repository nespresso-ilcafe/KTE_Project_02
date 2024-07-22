<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/include/header.jsp" %>
<c:if test="${sessionScope.level eq null && sessionScope.id eq null }">
	<script type="text/javascript">
		alert("담을 넘지 마시오.");
		location.href = "/member/login";
	</script>
</c:if>

<%
//카트 생성
Date today3 = new Date();
SimpleDateFormat cal3 = new SimpleDateFormat("yyyyMMddHHmmss");
String signdate3 = cal3.format(today3);

String session_id = (String)session.getAttribute("id");
String str3 = signdate3 + "_" + (String)session.getAttribute("id");

String session_cart = (String)session.getAttribute("cart");
if(session_id != null && session_cart == null){
   session.setAttribute("cart", str3);
}
%>

<center>
    장바구니
    <!-- 장바구니가 비었을 때  -->
    <c:if test="${number == 0 }">
        <table height="300">
            <tr>
                <td>장바구니가 비어있습니다.</td>
            </tr>
        </table>
    </c:if>
    <form method="post" action="/cart/orderlist">
    <c:if test="${count != 0 }">
        <table width=1000 border=1>
            <tr>
                <td colspan="2" align="left">total : ${count }</td>
                <input type="hidden" id="tcount" value="${count }">
                <td colspan="5" align="left">주문번호</td>
            </tr>
            <tr>
                <td><input type="checkbox" id="checkAll" checked></td>
                <td>상품</td>
                <td>수량</td>
                <td colspan="2">가격</td>
            </tr>
            <c:set var="total_price" value="0"/>
            <c:forEach var="v" items="${v }">
            <tr class="row">
                <td align=center>
                	<c:choose>
                		<c:when test="${v.item.it_qty eq 0}">
                			<span style="color:red">품절된 항목이니<br>삭제해주세요.<br></span>
                			<input type="button" onclick="a(${v.ct_uid})" value="삭제">
                		</c:when>
                		<c:otherwise>
                			<input type="checkbox" value="${v.ct_uid }" id="ct_uid" name="ct_uids[]" class="check" checked>
                		</c:otherwise>
                	</c:choose>
                </td>
                <td align="center">
                    <img src="/upload_item/${v.item.file1_thumb }" style="width:75px;">
                </td>
                <td>
                    <c:choose>
                        <c:when test="${v.item.it_qty == 0}">
                            <input id="qty_status" name="qty_status" value="품절 상품입니다.">
                        </c:when>
                        <c:otherwise>
                            <input id="qty" name="it_qty" value="${v.it_qty }" style="width:20px;height:20px;border:1px solid blue;text-align:center">
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${v.it_sale ne 0}">
                            <span style="color:#ddd">정상가 : <fmt:formatNumber value="${v.it_price }" type="number"/> 원</span><br>
                            <span style="color:orange">할인가 : <fmt:formatNumber value="${v.it_sale }" type="number"/> 원</span><br>
                        </c:when>
                        <c:otherwise>
                            <span>정상가 : <fmt:formatNumber value="${v.it_price }" type="number"/></span><br>
                        </c:otherwise>
                    </c:choose>
                    <span>${v.it_opt1 }</span>
                    <!-- 옵션별 추가금 추출 -->
                    <c:set var="opt1" value="${v.it_opt1 }"/>
                    <c:set var="opt2" value="${fn:split(opt1,'(')[1] }"/>
                    <c:set var="opt3" value="${fn:split(opt2,',')[0] }000"/>
                    <input type="hidden" id="it_opt1" value="${v.it_opt1 }">
                    <!-- 일반가격 -->
                    <c:set var="normalPrice" value="${v.it_price }"/>
                    <input type="hidden" value="${normalPrice}">
                    <!-- 세일가격 -->
                    <c:set var="salePrice" value="${v.it_sale }"/>
                    <input type="hidden" value="${salePrice}">
                </td>
                <td>
                    <c:choose>
                        <c:when test="${v.it_sale == 0 }">합계 : 
	                    	<!-- 정상가격 최종 -->
	                        <c:set var="nPrice" value="${v.it_price + opt3}"/>
	                        <c:set var="lastNPrice" value="${nPrice * v.it_qty}"/>
	                        <input type="hidden" class="lastNPrice" value="${lastNPrice}">
                            <fmt:formatNumber value="${lastNPrice}"/>
                            <input type="hidden" name="it_price" value="${v.it_price}">
                        </c:when>
                        <c:when test="${v.it_sale >= 1 }">합계 : 
	                   	 	<!-- 세일가격 최종 -->
	                        <c:set var="sPrice" value="${v.it_sale + opt3}"/>
	                        <c:set var="lastSPrice" value="${sPrice * v.it_qty}"/>
                        	<input type="hidden" class="lastSPrice" value="${lastSPrice}">
                            <fmt:formatNumber value="${lastSPrice}"/>
                            <input type="hidden" name="it_sale" value="${v.it_sale}">
                        </c:when>
                    </c:choose>
                </td>
            </tr>
            <input type="hidden" id="mb_id" name="mb_id" value="${v.mb_id }">
            <input type="hidden" name="ct_uid" value="${v.ct_uid }">
            <input type="hidden" id="it_uid" name="it_uid" value="${v.it_uid }">
            <input type="hidden" name="it_point" value="${v.it_point }">
            <input type="hidden" name="it_price" value="${v.it_price }">
            <input type="hidden" name="ct_status" value="${v.ct_status }">
            <input type="hidden" name="it_opt1" value="${v.it_opt1 }">
            <input type="hidden" name="file1_thumb" value="${v.file1_thumb }">
            </c:forEach>
            <tr>
                <td colspan="6" align="center">
                    <button onclick="a()">주문하기</button>
                </td>
            </tr>
            <tr>
            	<td colspan="6" align="right">상품 금액 : <span id="pay_total"></span></td>
            </tr>
            <tr>
            	<td colspan="6" align="right">배송비 : <span id="sendPay"></span></td>
            </tr>
            <tr>
            	<td colspan="6" align="right">총 결제 금액 : <span id="lastTotalPrice"></span></td>
            </tr>
        </table>
    </c:if>
    </form>
    <table width="1000">
        <tr>
            <td align="left" width="25%" onclick="onedelete()">선택상품 삭제</td>
            <td align="right" width="50%">10만원 이상 무료배송<br>최대 10개의 상품을 담을 수 있습니다</td>
        </tr>
    </table>
</center>
<%@ include file = "/include/footer.jsp" %>

<script>
	
	//체크박스 상호작용 (전체체크/전체체크해제)
	$('#checkAll').click(function(){ // "전체 선택" 체크박스 클릭 이벤트 핸들러
	    var checked = $('#checkAll').is(':checked'); // "전체 선택" 체크박스가 체크되었는지 확인하여 checked 변수에 할당 (true 또는 false 반환)
	    if(checked){ // 만약 "전체 선택" 체크박스가 체크되었다면
	        $(".check").prop('checked',true); // 모든 .chk 클래스를 가진 체크박스들의 속성을 true로 설정하여 체크함
	    }else{ // 그렇지 않다면 (체크가 해제된 경우)
	        $(".check").prop('checked',false); // 모든 .chk 클래스를 가진 체크박스들의 속성을 false로 설정하여 체크 해제함
	    }
	});
	
	// 각 체크박스의 상태 변화 감지 함수
	$('.check').change(function() {
	    checkCheckAll(); // 체크박스 상태 변화에 따라 checkAll 체크박스 상태 업데이트
	});

	// checkAll 체크박스 상태 업데이트 함수
	function checkCheckAll() {
	    var allChecked = true; // 전체 선택 체크박스의 체크 상태를 기본으로 true로 설정

	    // 각 체크박스가 모두 체크되어 있는지 확인
	    $('.check').each(function() {
	        if (!$(this).is(':checked')) { // 하나라도 체크되지 않은 경우
	            allChecked = false; // 전체 선택 체크박스의 체크 상태를 false로 변경
	            return false; // 반복문 탈출
	        }
	    });

	    // 전체 선택 체크박스의 상태 업데이트
	    $('#checkAll').prop('checked', allChecked);
	}
	
	//체크박스삭제 
	function onedelete(){
	    var ct_uids = []; // ct_uid 값을 저장할 배열 선언
	    $(".check:checked").each(function() {
	        ct_uids.push($(this).val()); // 체크된 체크박스의 ct_uid 값을 배열에 추가
	    });

	    $.ajax({
	        url: "/cart/onedelete",
	        type: "post",
	        dataType: "text", // 서버 응답이 텍스트 형식임을 지정
	        data: { ct_uids: ct_uids }, // 배열 형태로 데이터 전달
	        error:function(){
	            alert("실패");
	        },
	        success:function(response){
	            alert("삭제되었습니다!");
	            location.href = "/cart/cartlist";
	        }
	    });
	}
	
	
	//결제금액 계산부분
	//체크박스 상호작용 (전체체크/전체체크해제)
	$('#checkAll').click(function(){ // "전체 선택" 체크박스 클릭 이벤트 핸들러
	    var checked = $(this).is(':checked'); // "전체 선택" 체크박스의 상태를 확인

	    $(".check").prop('checked', checked); // 모든 체크박스의 상태를 전체 선택 상태에 맞게 설정

	    // 체크박스 상태 변경 후 총 결제 금액 다시 계산 및 업데이트
	    calculateTotalPrice();
	});
	// 페이지 로드시 초기화 함수 실행
    $(document).ready(function() {
        calculateTotalPrice(); // 초기 총 결제금액 계산
    });

    // 각 체크박스의 상태 변화 감지 함수
    $('.check').change(function() {
        calculateTotalPrice(); // 체크박스 상태 변화에 따라 총 결제금액 업데이트
    });

 // 총 결제금액 계산 함수
    function calculateTotalPrice() {
        var totalPrice = 0; // 총 결제금액을 저장할 변수 초기화
        var sendPay = 0; // 배송비 변수 초기화
        var lastTotalPrice = 0; // 최종 결제금액 변수 초기화

        // 각 체크박스에 대해 반복하면서 체크된 경우에만 가격을 계산하여 총 결제금액에 추가
        $('.check:checked').each(function() {
            var row = $(this).closest('tr'); // 체크된 체크박스의 부모 행(tr) 요소를 가져옴
            var lastNPrice = parseFloat(row.find('.lastNPrice').val());
            var lastSPrice = parseFloat(row.find('.lastSPrice').val());

            if (!isNaN(lastNPrice)) { // 정상 가격이 존재하는 경우
                totalPrice += lastNPrice; // 정상 가격을 총 결제금액에 추가
            } else if (!isNaN(lastSPrice)) { // 세일 가격이 존재하는 경우
                totalPrice += lastSPrice; // 세일 가격을 총 결제금액에 추가
            }
        });

        // 총 결제금액이 10만원 이상인 경우 배송비는 0원, 그렇지 않으면 1만원 추가
        	// 체크된 체크박스의 개수를 가져옴
			var checkedCount = $('.check:checked').length;
			
			// 체크된 체크박스가 없는 경우 또는 체크된 상품의 총 가격이 10만원 이상인 경우
			if (checkedCount === 0 || totalPrice >= 100000) {
			    sendPay = 0; // 배송비를 0으로 설정
			} else {
			    sendPay = 10000; // 배송비를 1만원으로 설정
			}

        // 최종 결제금액 계산 (총 결제금액 + 배송비)
        lastTotalPrice = totalPrice + sendPay;

        // 배송비가 0원인 경우 "무료배송"으로 표시
        var sendPayText = (lastTotalPrice >= 100000) ? "무료배송" : sendPay.toLocaleString() + "원";

        // 총 결제금액 및 배송비를 표시하는 요소 업데이트
        $('#pay_total').text(totalPrice.toLocaleString() + "원");
        $('#sendPay').text(sendPayText);
        $('#lastTotalPrice').text(lastTotalPrice.toLocaleString() + "원"); // 최종 결제금액 업데이트
    }
 
 	
	function a(ct_uid){
		location.href="/cart/cartdelete?ct_uid="+ct_uid;
	}
</script>
