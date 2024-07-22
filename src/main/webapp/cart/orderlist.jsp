<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
    // 카트 생성
    Date today3 = new Date();
    SimpleDateFormat cal3 = new SimpleDateFormat("yyyyMMddHHmmss");
    String signdate3 = cal3.format(today3);

    String session_id = (String) session.getAttribute("id");
    String str3 = signdate3 + "_" + session_id;

    String session_cart = (String) session.getAttribute("cart");
    if (session_id != null && session_cart == null) {
        session.setAttribute("cart", str3);
    }
%>
<style>
	#name{
		width:75px;
		height:20px;
		border:none;
		border-bottom:1px solid black;
		text-align:center;
		font-size:16px;
	}
	#nameside{
		width:30px;
		height:20px;
		border:none;
		text-align:center;
		font-size:12px;
		color:red;
	}
	#pn1,#pn2,#pn3{
		width:40px;
		height:20px;
		border:none;
		border-bottom:1px solid black;
		text-align:center;
	}
	#sample4_postcode{
		width:50px;
		height:30px;
		border:none;
		border-bottom:1px solid black;
	}
	
	#sample4_roadAddress,
	#sample4_jibunAddress,
	#sample4_detailAddress,
	#sample4_extraAddress{
		width:250px;
		height:30px;
		border:none;
		border-bottom:1px solid black;
	}
	#or_opt{
		border:none;
	}
	#pay_total,
	#sendPay,
	#lastTotalPrice{
		color:white;
	}
	#pay{
		width:100px;
		height:50px;
		border:none;
		color:white;
		font-size:20px;
		background-color:black;
	}
	#pay:hover{
		color:red;
	}
</style>
<c:if test="${sessionScope.level eq null && sessionScope.id eq null }">
    <script type="text/javascript">
        alert("담을 넘지 마시오.");
        location.href = "/member/login";
    </script>
</c:if>
<center>
    <form method="post" id="formid" action="/cart/orderwrite">
    	<input type="hidden" name="od_id" value="${sessionScope.cart }">
        <table width="800">
            <tr>
                <td>
                <br>
                    <table width="100%" bgcolor="black">
                        <tr>
                            <td colspan="2" align="center" height="40" style="color:white;font-size:16px;">배송 정보</td>
                        </tr>
                    </table>
                    <table border="0" width="100%">
                        <c:forEach var="m" items="${cm }" end="0">
                            <tr>
                                <td width="100" style="border-right:1px solid black;">수령인 : </td>
                                <td>
                                    <input id="name" name="name" value="${m.name }">
                                    <span id="nameside">입금자명으로 적어주세요</span>
                                </td>
                            </tr>
                            <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
                            <tr>
                                <td style="border-right:1px solid black;"> 배송지 : </td>
                                <td>
                                    <table border="0" width="100%">
                                        <tr>
                                            <td width="50%">
                                                <input type="text" value="${m.zc }" id="sample4_postcode" placeholder="우편번호" name="zc" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" required>
                                                <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
                                            </td>
                                            <td width="50%" rowspan="5" style="text-align:center">
                                            	무통장 입금 예금주 : 변관우<br><br>
                                            	국민 : 00-0000-0000000<br>
                                            	기업 : 00-0000-0000000<br>
                                            	농협 : 00-0000-0000000<br>
                                            	신한 : 00-0000-0000000<br>
                                            	우리 : 00-0000-0000000<br>
                                            	하나 : 00-0000-0000000
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" value="${m.zc1 }" id="sample4_roadAddress" placeholder="도로명주소" name="zc1">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" value="${m.zc2 }" id="sample4_jibunAddress" placeholder="지번주소" name="zc2">
                                                <span id="guide" style="color:#999;display:none"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" value="${m.zc3 }" id="sample4_extraAddress" placeholder="참고항목" name="zc3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="text" value="${m.zc4 }" id="sample4_detailAddress" placeholder="상세주소" name="zc4">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
                            <tr>
                                <td style="border-right:1px solid black;">연락처 : </td>
                                <td>
                                    <input id="pn1" name="pn1" value="${fn:split(m.pn,'-')[0] }">-
                                    <input id="pn2" name="pn2" value="${fn:split(m.pn,'-')[1] }">-
                                    <input id="pn3" name="pn3" value="${fn:split(m.pn,'-')[2] }">
                                </td>
                            </tr>
                            <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
	                        <tr>
	                            <td style="border-right:1px solid black;">배송 요청 사항</td>
	                            <td>
	                                <select name="or_opt" id="or_opt">
	                                    <option value="집 앞에 두고 문자" selected>집 앞에 두고 문자 </option>
	                                    <option value="무인 택배함 이용">무인 택배함 이용 </option>
	                                    <option value="희망 수령장소 요청">희망 수령장소 요청 </option>
	                                    <option value="직접 받을게요">직접 받을게요 </option>
	                                </select>
	                            </td>
	                        </tr>
                            <tr><td colspan="2" style="border-bottom:2px solid black;"></td></tr>
	                    	<br>
	                    </c:forEach>
	                    </table>
	                    <table width="100%">
	                        <tr>
	                            <td colspan="2" align="center" height="40" style="font-size:16px;">정보 제공 동의</td>
	                        </tr>
                            <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
	                        <tr>
	                        	<td align="center">
	                        		전자상거래 이용약관 동의
	                        		<span onclick="location.href='/fairtrade/usingrule'">[전문보기]</span>
	                        		<input type="checkbox" id="using">
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td align="center">
	                        		개인정보 제공 이용 동의
	                        		<span onclick="location.href='/fairtrade/inforule'">[전문보기]</span>
	                        		<input type="checkbox" id="info">
	                        	</td>
	                        </tr>
                            <tr><td colspan="2" style="border-bottom:2px solid black;"></td></tr>
	                    </table>
	                    <br>
	                    <table width="100%" bgcolor="black">
	                        <tr>
	                            <td colspan="2" align="center" height="40" style="color:white;font-size:16px;">제품 정보</td>
	                        </tr>
	                    </table>
	                    <table width="100%">
	                        <c:set var="i" value="0"/>
	                        <c:forEach var="v" items="${cm }">
		                        <tr class="row">
		                            <td align="center">
		                                <img src="/upload_item/${v.file1_thumb }" style="width:75px;">
		                            </td>
		                            <td>
		                                <c:choose>
		                                    <c:when test="${v.it_qty == 0}">
		                                        <input id="qty_status" name="qty_status[]" value="품절 상품입니다.">
		                                    </c:when>
		                                    <c:otherwise>
		                                        <input id="qty" name="it_qty[${i }]" value="${v.it_qty}" style="width:20px;height:20px;border:none;font-size:18px;text-align:center">
		                                    </c:otherwise>
		                                </c:choose>
		                            </td>
		                            <td>
		                                <c:choose>
		                                    <c:when test="${v.it_sale ne 0}">
		                                        <span style="color:#ddd">정상가 : <fmt:formatNumber value="${v.it_price}" type="number"/> 원</span><br>
		                                        <span style="color:orange">할인가 : <fmt:formatNumber value="${v.it_sale}" type="number"/> 원</span><br>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <span>정상가 : <fmt:formatNumber value="${v.it_price}" type="number"/></span><br>
		                                    </c:otherwise>
		                                </c:choose>
		                                <span>${v.it_opt1}</span>
		                                <!-- 옵션별 추가금 추출 -->
		                                <c:set var="opt1" value="${v.it_opt1}"/>
		                                <c:set var="opt2" value="${fn:split(opt1,'(')[1]}"/>
		                                <c:set var="opt3" value="${fn:split(opt2,',')[0]}000"/>
		                                <input type="hidden" id="it_opt1" name="it_opt1[]" value="${v.it_opt1}">
		                                <!-- 일반가격 -->
		                                <c:set var="normalPrice" value="${v.it_price}"/>
		                                <input type="hidden" value="${normalPrice}">
		                                <!-- 세일가격 -->
		                                <c:set var="salePrice" value="${v.it_sale}"/>
		                                <input type="hidden" value="${salePrice}">
		                            </td>
		                            <td>
		                                <c:choose>
		                                    <c:when test="${v.it_sale == 0}">합계 : 
		                                        <!-- 정상가격 최종 -->
		                                        <c:set var="nPrice" value="${v.it_price + opt3}"/>
		                                        <c:set var="lastNPrice" value="${nPrice * v.it_qty}"/>
		                                        <input type="hidden" class="lastNPrice" value="${lastNPrice}">
	                            				<input type="hidden" name="it_price[${i }]" value="${lastNPrice }">
		                                        <fmt:formatNumber value="${lastNPrice}"/>
		                                    </c:when>
		                                    <c:when test="${v.it_sale >= 1}">합계 : 
		                                        <!-- 세일가격 최종 -->
		                                        <c:set var="sPrice" value="${v.it_sale + opt3}"/>
		                                        <c:set var="lastSPrice" value="${sPrice * v.it_qty}"/>
		                                        <input type="hidden" class="lastSPrice" value="${lastSPrice}">
	                            				<input type="hidden" name="it_price[${i }]" value="${lastSPrice }">
		                                        <fmt:formatNumber value="${lastSPrice}"/>
		                                    </c:when>
		                                </c:choose>
		                            </td>
		                        </tr>
		                        <input type="hidden" name="mb_id[${i }]" value="${v.mb_id}">
		                        <input type="hidden" name="ct_uid[${i }]" value="${v.ct_uid}">
		                        <input type="hidden" name="it_uid[${i }]" value="${v.it_uid}">
		                        <input type="hidden" name="it_point[${i }]" value="${v.it_point }">
		                        <input type="hidden" name="ct_status[${i }]" value="${v.ct_status}">
		                        <input type="hidden" name="it_opt1[${i }]" value="${v.it_opt1}">
		                        <input type="hidden" name="file1_thumb[${i }]" value="${v.file1_thumb}">
							<c:set var="i" value="${i+1 }"/>
	                        </c:forEach>
                            <tr><td colspan="6" style="border-bottom:2px solid black;">
                            <input type="hidden" name="count" value="${i }"></td></tr>
                            <tr>
                            	<td colspan="6" >
                            		<br>
                            		<table width="100%" bgcolor="black">
				                        <tr>
				                        	<td rowspan="3">
        										<button id="pay" type="button" onclick="buying()">결제하기</button>
				                        	</td>
				                            <td colspan="6" align="right" style="color:white;">
				                            상품 금액 : <span id="pay_total"></span></td>
				                        </tr>
				                        <tr>
				                            <td colspan="6" align="right" style="color:white;">
				                            배송비 : <span id="sendPay"></span></td>
				                        </tr>
				                        <tr>
				                            <td colspan="6" align="right" style="color:white;">
				                            총 결제 금액 : <span id="lastTotalPrice"></span></td>
				                        </tr>
                            		</table>
                            	</td>
                            </tr>
	                    </table>
	                    <br>
	                </td>
	            </tr>
	        </table>
    </form>
</center>
<%@ include file="/include/footer.jsp" %>

<script>
    // 페이지 로드시 초기화 함수 실행
    $(document).ready(function() {
        calculateTotalPrice(); // 초기 총 결제금액 계산
    });

    // 총 결제금액 계산 함수
    function calculateTotalPrice() {
        var totalPrice = 0; // 총 결제금액을 저장할 변수 초기화
        var sendPay = 0; // 배송비 변수 초기화
        var Point = 0;

        // 제품 정보를 반복하여 총 결제금액 계산
        $("tr.row").each(function() {
            var price = parseInt($(this).find(".lastNPrice").val() || $(this).find(".lastSPrice").val());
            totalPrice += price;
        });

        // 배송비 계산
        sendPay = (totalPrice >= 100000) ? 0 : 10000;

        // 최종 결제금액 계산 (총 결제금액 + 배송비)
        var lastTotalPrice = totalPrice + sendPay;

        // 배송비가 0원인 경우 "무료배송"으로 표시
        var sendPayText = (sendPay === 0) ? "무료배송" : sendPay.toLocaleString() + "원";

        // 총 결제금액 및 배송비를 표시하는 요소 업데이트
        $('#pay_total').text(totalPrice.toLocaleString() + "원");
        $('#sendPay').text(sendPayText);
        $('#lastTotalPrice').text(lastTotalPrice.toLocaleString() + "원"); // 최종 결제금액 업데이트
    }
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 우편번호 API 스크립트 -->
<script>
// 다음 우편번호 API 실행 함수
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            var roadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");

            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

function buying() {
    if (!document.getElementById('using').checked) {
        alert('전자상거래 이용약관에 동의해야 합니다.');
        return;
    }

    if (!document.getElementById('info').checked) {
        alert('개인정보 제공 이용에 동의해야 합니다.');
        return;
    }

    if (confirm('결제를 진행하시겠습니까?')) {
        document.getElementById('formid').submit();
    } else {
        location.href = "/cart/cartlist";
    }
}
</script>
