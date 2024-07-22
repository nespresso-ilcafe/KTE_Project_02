<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

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

<c:if test="${sessionScope.level eq null && sessionScope.id eq null }">
    <script type="text/javascript">
        alert("담을 넘지 마시오.");
        location.href = "/member/login";
    </script>
</c:if>
<center>
    체크아웃
    <form method="post" action="/cart/directorderwrite" >
    	<c:set var="m" value="${m }"/>
    	<c:set var="c" value="${c }"/>
        <table border="1" width="800">
            <tr>
                <td width="60%">
                    <table border="1" width="100%">
                        <tr>
                            <td colspan="2">배송 정보</td>
                            <td><input value="${c.it_uid }"></td>
                       </tr>
                       <tr>
                           <td>수령인 : </td>
                           <td>
                               <input name="name" value="${m.name }"><span>입금자명으로 적어주세요</span>
                           </td>
                       </tr>
                       <tr>
                           <td> 배송지 : </td>
                           <td>
                               <table border="0">
                                   <tr>
                                       <td>
                                           <input type="text" value="${m.zc }" id="sample4_postcode" placeholder="우편번호" name="zc" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" required>
                                       </td>
                                       <td>
                                           <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           <input type="text" value="${m.zc1 }" id="sample4_roadAddress" placeholder="도로명주소" name="zc1">
                                       </td>
                                       <td>
                                           <input type="text" value="${m.zc2 }" id="sample4_jibunAddress" placeholder="지번주소" name="zc2">
                                           <span id="guide" style="color:#999;display:none"></span>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td>
                                           <input type="text" value="${m.zc3 }" id="sample4_extraAddress" placeholder="참고항목" name="zc3">
                                       </td>
                                       <td>
                                           <input type="text" value="${m.zc4 }" id="sample4_detailAddress" placeholder="상세주소" name="zc4">
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       <tr>
                           <td>연락처 : </td>
                           <td>
                               <input name="pn1" value="${fn:split(m.pn,'-')[0] }">
                               <input name="pn2" value="${fn:split(m.pn,'-')[1] }">
                               <input name="pn3" value="${fn:split(m.pn,'-')[2] }">
                           </td>
                       </tr>
                   <tr>
                       <td>배송 요청 사항</td>
                       <td>
                           <select name="or_opt">
                               <option value="집 앞에 두고 문자" selected>집 앞에 두고 문자 </option>
                               <option value="무인 택배함 이용">무인 택배함 이용 </option>
                               <option value="희망 수령장소 요청">희망 수령장소 요청 </option>
                               <option value="직접 받을게요">직접 받을게요 </option>
                           </select>
                       </td>
                   </tr>
                    </table>
                    <br>
                    <table border="1" width="100%">
                        <tr>
                            <td colspan="4">제품 정보</td>
                        </tr>
                        <tr class="row">
                            <td align="center">
                                <img src="/upload_item/${c.file1_thumb }" style="width:75px;">
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.it_qty == 0}">
                                        <input id="qty_status" name="qty_status" value="품절 상품입니다.">
                                    </c:when>
                                    <c:otherwise>
                                        <input id="qty" name="it_qty" value="${c.it_qty}" style="width:20px;height:20px;border:1px solid blue;text-align:center">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.it_sale ne 0}">
                                        <span style="color:#ddd">정상가 : <fmt:formatNumber value="${c.it_price}" type="number"/> 원</span><br>
                                        <span style="color:orange">할인가 : <fmt:formatNumber value="${c.it_sale}" type="number"/> 원</span><br>
                                    </c:when>
                                    <c:otherwise>
                                        <span>정상가 : <fmt:formatNumber value="${c.it_price}" type="number"/></span><br>
                                    </c:otherwise>
                                </c:choose>
                                <span>${c.it_opt1}</span>
                                <!-- 옵션별 추가금 추출 -->
                                <c:set var="opt1" value="${c.it_opt1}"/>
                                <c:set var="opt2" value="${fn:split(opt1,'(')[1]}"/>
                                <c:set var="opt3" value="${fn:split(opt2,',')[0]}000"/>
                                <input type="hidden" id="it_opt1" name="it_opt1[]" value="${c.it_opt1}">
                                <!-- 일반가격 -->
                                <c:set var="normalPrice" value="${c.it_price}"/>
                                <input type="hidden" value="${normalPrice}">
                                <!-- 세일가격 -->
                                <c:set var="salePrice" value="${c.it_sale}"/>
                                <input type="hidden" value="${salePrice}">
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.it_sale == 0}">합계 : 
                                        <!-- 정상가격 최종 -->
                                        <c:set var="nPrice" value="${c.it_price + opt3}"/>
                                        <c:set var="lastNPrice" value="${nPrice * c.it_qty}"/>
                                        <input type="hidden" class="lastNPrice" value="${lastNPrice}">
                           				<input type="hidden" name="it_price" value="${lastNPrice }">
                                        <fmt:formatNumber value="${lastNPrice}"/>
                                    </c:when>
                                    <c:when test="${c.it_sale >= 1}">합계 : 
                                        <!-- 세일가격 최종 -->
                                        <c:set var="sPrice" value="${c.it_sale + opt3}"/>
                                        <c:set var="lastSPrice" value="${sPrice * c.it_qty}"/>
                                        <input type="hidden" class="lastSPrice" value="${lastSPrice}">
                           				<input type="hidden" name="it_price" value="${lastSPrice }">
                                        <fmt:formatNumber value="${lastSPrice}"/>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <input type="hidden" name="mb_id" value="${c.mb_id}">
                        <input type="hidden" name="ct_uid" value="${c.ct_uid}">
                        <input type="hidden" name="it_uid" value="${c.it_uid}">
                        <input type="hidden" name="it_point" value="${c.it_point }">
                        <input type="hidden" name="ct_status" value="${c.ct_status}">
                        <input type="hidden" name="it_opt1" value="${c.it_opt1}">
                        <input type="hidden" name="file1_thumb" value="${c.file1_thumb}">
                        <tr>
                            <td colspan="6" align="center">
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
                    <br>
                </td>
            </tr>
        </table>
        <button>결제하기</button>
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
</script>
