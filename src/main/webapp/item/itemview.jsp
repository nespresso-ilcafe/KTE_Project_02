<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<center>
	<br>
    <form name="cart_insert" action="/cart/write" method="post">
        <!-- 장바구니에 상품을 추가하는 폼 -->
        <!-- 상품 정보 출력 -->
        <c:set var="it" value="${it }"/>
        <c:set var="ca" value="${ca }"/>
        <table width="800">
            <tr>
                <!-- 상품 이미지 표시 -->
                <td width="360">
                <input type="hidden" id="qty1" name="qty1" value="${it.it_qty }">
                	<c:choose>
                		<c:when test="${it.it_qty == 0 }">
	                		<div style="position: relative;">
							    <img src="/upload_item/${it.file1}" style="width: 360px;">
							    <img src="/img/pngwing.com.png" style="position: absolute; top: 20%; left: 0; width: 100%;">
							</div>
                    	</c:when>
                    	<c:when test="${it.it_qty <= 3 }">
	                		<div style="position: relative;">
							    <img src="/upload_item/${it.file1}" style="width: 360px;">
							    <img src="/img/1.png" style="position: absolute; top: -10%; left: 0; width: 50%;">
							</div>
                    	</c:when>
                    	<c:otherwise>
                    		<img src="/upload_item/${it.file1 }" style="width:360px">
                    	</c:otherwise>
                    </c:choose>
                </td>
                <td></td>
                <td width="440">
                    <table width="445">
                        <!-- 상품 카테고리 이름 출력 -->
                        <tr>
                            <td height="30">${it.cate2_name }</td>
                            <c:choose>
								<c:when test="${search != null && search != '' }">
									<td align="center" bgcolor="black" width="100">
									<a href="/mainsearch?pageNum=${pageNum }&search=${search}" style="color:white;font-size:14px">이전 페이지</a>
									</td>
								</c:when>
								<c:when test="${od_id != null }">
									<td align="center" bgcolor="black" width="100">
									<a href="/orders/userorderview?it_uid=${it.it_uid }&od_id=${od_id }" style="color:white;font-size:14px">이전 페이지</a>
									</td>
								</c:when>
								<c:when test="${category1 == null && category2 == null }">
									<td align="center" bgcolor="black" width="100">
									<a href="/" style="color:white;font-size:14px">이전 페이지</a>
									</td>
								</c:when>
								<c:when test="${category1 != null && category2 == null }">
									<td align="center" bgcolor="black" width="100">
									<a href="list?category1=${category1}" style="color:white;font-size:14px">이전 페이지</a>
									</td>
								</c:when>
								<c:when test="${category1 != null && category2 != null }">
									<td align="center" bgcolor="black" width="100">
									<a href="list2?category1=${category1}&category2=${category2}" style="color:white;font-size:14px">이전 페이지</a>
									</td>
								</c:when>
							</c:choose>
                        </tr>
                        <!-- 상품 이름 출력 -->
                        <tr>
                        	<input type="hidden" name="it_name" id="it_name" value="${it.it_name }">
                            <td colspan="2" height="60" name="it_name" style="font-weight:bold; font-size:20px;">${it.it_name }</td>
                        </tr>
                        <tr height="5"></tr>
                        <tr height="5"><td style="border-top:1px solid black;" colspan="2"></td></tr>
                        <tr height="5"></tr>
                        <!-- 가격 출력 -->
                        <tr>
                            <td colspan="2">
                                <c:choose>
                                    <c:when test="${it.it_sale ne 0}">
                                        <!-- 세일 가격이 존재하는 경우 -->
                                        <span  style="color: gray; font-size:14px;">
                                            정상가 : <fmt:formatNumber value="${it.it_price}" type="number"/> 원
                                            <input type="hidden" name="it_price" id="it_price" value="${it.it_price}"/>
                                        </span><br>
                                        <span style="color: #FE642E; font-size:20px; font-weight:bold;">
                                            할인가 : <fmt:formatNumber value="${it.it_sale}" type="number"/> 원
                                            <input type="hidden" name="it_sale" id="it_sale" value="${it.it_sale}"/>
                                        </span><br>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 세일 가격이 없는 경우 -->
                                        <span style="color: black; font-size:20px;">
                                        정상가 : <fmt:formatNumber value="${it.it_price}" type="number"/></span>
                                        <input type="hidden" name="it_price" id="it_price" value="${it.it_price}"/><br>
                                        <input type="hidden" name="it_sale" id="it_sale" value="${it.it_price}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <!-- 적립금 출력 -->
                        <tr>
                            <td colspan="2">적립금 : <span id="totalPoint">0</span>
	                            <input type="hidden" name="it_point" id="it_point" value="${it.it_point}" />
                            </td>
                        </tr>
                        <tr height="5"></tr>
                        <tr height="5"><td style="border-top:1px solid black;" colspan="2"></td></tr>
                        <tr height="5"></tr>
                        <!-- 옵션 선택 -->
                        <tr>
                            <td colspan="2" align="right">
                               <!-- 옵션1이 존재하는 경우 -->
                               <c:choose>
                                   <c:when test="${it.it_type1 eq 'Y' }">
                                       <!-- 옵션1 선택 폼 -->
                                       <span style="width:75px;font-size:14px;">우투/좌투 
                                           <select id="gloOpt1" name="gloOpt1" style="width:200px; font-size:14px;" required>
                                               <option value="">선택하세요</option>
                                               <option value="우투">우투</option>
                                               <option value="좌투">좌투</option>
                                           </select>
                                       </span>
                                   </c:when>
                                   <c:when test="${it.it_type1 eq 'N' }">
                                       <input type="hidden" id="gloOpt1" name="gloOpt1" value="기타">
                                   </c:when>
                               </c:choose>
                               <br>
                               <c:choose>
                                   <c:when test="${it.it_type2 eq 'Y' }">
                                       <!-- 옵션2 선택 폼 -->
                                       <span style="width:75px;font-size:14px;">길들이기
                                           <select id="gloOpt2" name="gloOpt2" style="width:200px; font-size:14px;" required onchange="calculatePrice()">
                                               <option value="">선택하세요</option>
                                               <option value="볼집+각잡기 (15,000원 추가)">볼집+각잡기 (15,000원 추가)</option>
                                               <option value="프리미엄 길들이기 (30,000원 추가)">프리미엄 길들이기 (30,000원 추가)</option>
                                               <option value="물형부 길들이기 (50,000원 추가)">물형부 길들이기 (50,000원 추가)</option>
                                               <option value="선택안함">선택안함</option>
                                           </select><br>
                                       </span>
                                       <div style="color:red; font-size:12px;">길들이기 선택시 교환,환불 불가합니다.</div>
                                   </c:when>
                                   <c:when test="${it.it_type2 eq 'N' }">
                                   		<div style="display: none;">
										    <select id="gloOpt2" name="gloOpt2" required onchange="calculatePrice()">
										        <option value="선택안함">선택안함</option>
										    </select>
										</div>
                                   </c:when>
                               </c:choose>
                            </td>
                        </tr><tr height="5"></tr>
                        <tr height="5"><td style="border-top:1px solid black" colspan="2"></td></tr>
                        <!-- 상품 수량 선택 -->
                        <tr>
                            <td bgcolor="fefefe" align="right" colspan="2">
                                <input type="button" value="-" onclick="qty_num('-')" style="width:30px;height:30px;border:0px;background-color:#fefefe;">
                                <input id="qty" name="qty" value="0" onchange="totalPrice()" style="font-size:16px;width:30px;height:30px;border:1px solid #fefefe;text-align:center">
                                <input type="button" value="+" onclick="qty_num('+')" style="width:30px;height:30px;border:0px;background-color:#fefefe;">
                            </td>
                        </tr>
                        <tr height="5"><td style="border-top:1px solid black;" colspan="2"></td></tr>
                        <tr height="5"></tr>
                        <!-- 총 결제금액 표시 -->
                        <tr>
                            <td width="100">
                               총 결제금액 : <span id="pay_total">0</span>
	                           <input type="hidden" value="pay_total" name="lastPay">
	                           <c:set var="lastPay" value="${lastPay }"/>
                            </td>
                            <td align="right">
                        	<!-- 바로구매 및 장바구니 버튼 -->
                              <c:choose>
                                 <c:when test="${sessionScope.id != null}">
                                    <c:choose>
                                       <c:when test="${it.it_qty != 0}">
                                           <button id="buyButton" style="width:105px;height:35px;background-color:black; color:white;">장바구니</button>
                                           <input id="wishButton" style="width:105px;height:35px;background-color:black; color:white;" type="button" onclick="abc()" value="찜하기">
                                        </c:when>
                                        <c:otherwise>품절입니다.</c:otherwise>
                                     </c:choose>
                                 </c:when>
                                 <c:otherwise>
                                    <c:choose>
                                       <c:when test="${it.it_qty != 0}">
                                           장바구니,찜하기는 <br> 로그인 후 사용 가능합니다
                                        </c:when>
                                        <c:otherwise>품절입니다.</c:otherwise>
                                     </c:choose>
                                 </c:otherwise>
                              </c:choose>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 상품 고유 식별자(hidden) -->
            <input type="hidden" name="it_uid" id="it_uid" value="${it.it_uid }">
        </table>
    </form>
    <!-- 상품 이미지들 표시 -->
    <table width="800">
        <!-- 추가 상품 이미지들 표시 -->
        <c:choose>
            <c:when test="${it.file2 ne '' && it.file2 ne null }"><tr><td><img src="/upload_item/${it.file2 }" style="width:800px"></td></tr></c:when>
            <c:otherwise><tr><td></td></tr></c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${it.file3 ne '' && it.file3 ne null }"><tr><td><img src="/upload_item/${it.file3 }" style="width:800px"></td></tr></c:when>
            <c:otherwise><tr><td></td></tr></c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${it.file4 ne '' && it.file4 ne null }"><tr><td><img src="/upload_item/${it.file4 }" style="width:800px"></td></tr></c:when>
            <c:otherwise><tr><td></td></tr></c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${it.file5 ne '' && it.file5 ne null }"><tr><td><img src="/upload_item/${it.file5 }" style="width:800px"></td></tr></c:when>
            <c:otherwise><tr><td></td></tr></c:otherwise>
        </c:choose>
    </table>
    <!-- 상품 페이지 리뷰 -->
    <br>
    <table width="800" bgcolor="black">
    	<tr>
    		<td align="center" style="color:white">구매 후기</td>
    	</tr>
    </table>
    <table width="800" style="border-top:2px solid black">
    	<tr>
			<c:set var="av" value="${average }"/>
    		<td colspan="2" align="center"></td>
    		<td align="center">제목</td>
			<td><!-- <img src="/img/rating.png" style="width:12px">&nbsp;&nbsp;<fmt:formatNumber value="${av }" pattern="0.0"/> --></td>
			<td width="120" align="center">작성자</td>
    	</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:forEach var="rv" items="${rv }">
		<c:set var="number" value="${number }"/>
			<tr>
				<td align="center" rowspan="2">${number }</td>
				<c:choose>
            		<c:when test="${rv.file1_thumb == null || rv.file1_thumb == '' }">
			            <td width="50" height="50" align="center" rowspan="2" style="border-right:1px solid black;">
			            	<img src="/img/no_image.png" style="width:30px;height:30px;">
			            </td>
            		</c:when>
            		<c:when test="${rv.file1_thumb != null || rv.file1_thumb != '' }">
            			<td width="50" height="50" align="center" rowspan="2">
			            	<img src="/upload_item/${rv.file1_thumb }" style="width:30px;height:30px;">
			            </td>
            		</c:when>
            	</c:choose>
				<td align="center">${rv.rv_sub }</td>
				<td width="50" rowspan="2"><img src="/img/rating.png" style="width:12px">&nbsp;&nbsp;<fmt:formatNumber value="${rv.rating }" pattern="0.0" /></td>
				<td align="center">${fn:substring(rv.mb_id,0,3) }********</td>
			</tr>
			<tr>
				<c:set var="textShow" value="${fn:substring(rv.rv_text,0,10) }"/>
				<td align="center">
					<c:choose>
						<c:when test="${fn:length(textShow) >= 10 }">
						<a href="/item/reviewsview?it_uid=${it.it_uid }&category2=${it.category2 }&rv_uid=${rv.rv_uid }">${textShow }...</a>
						</c:when>
						<c:otherwise>
						<a href="/item/reviewsview?it_uid=${it.it_uid }&category2=${it.category2 }&rv_uid=${rv.rv_uid }">${textShow }</a>
						</c:otherwise>
					</c:choose>
				</td>
				<input type="hidden" id="rating" value="${rv.rating }">
				<td align="center">${rv.rv_date }</td>
			</tr>
			<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:set var="number" value="${number-1 }"/>
		</c:forEach>
		<tr>
			<td colspan="3" align="right" height="30"></td>
			<td align="center"></td>
			<td align="center" bgcolor="black"><a href="/item/reviews?it_uid=${it.it_uid }" style="color:white">모든 후기</a></td>
		</tr>
    </table>
    <!-- 상품 페이지 문의글 -->
    <br>
    <table width="800" bgcolor="black">
    	<tr>
    		<td align="center" style="color:white">상품 문의</td>
    	</tr>
    </table>
    <table width="800" style="border-top:2px solid black">
		<tr style="border-bottom:1px solid black;">
			<td align="center" width="40">no</td>
			<td colspan="2">제목</td>
			<td width="100" align="center">작성자</td>
			<td width="100" align="center">작성일</td>
		</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:forEach var="q" items="${q }">
		<c:set var="qnumber" value="${qnumber }"/>
			<tr height="25">
				<td align="center" style="border-right:1px solid black">${qnumber }</td>
				<td colspan="2">
					<c:set var="subCut" value="${q.qna_subject }"/>
					<c:set var="thread" value="${q.thread }"/>
					<c:choose>
						<c:when test="${fn:length(thread) == 1}">
							<c:choose>
								<c:when test="${fn:length(subCut) >= 10 }">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }...</a>
								</c:when>
								<c:otherwise>
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${fn:length(thread) > 1}">
							<c:choose>
								<c:when test="${fn:length(subCut) >= 10 }">
									<img alt="" src="/img/thread.png">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }...</a>
								</c:when>
								<c:otherwise>
									<img alt="" src="/img/thread.png" style="width:15px;height:15px;">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }</a>
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
				</td>
				<td align="center">${q.mb_id }</td>
				<td align="center">${q.signdate }</td>
			</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:set var="qnumber" value="${qnumber - 1 }"/>
		</c:forEach>
		<tr>
			<td colspan="3" height="30"></td>
			<td align="center" bgcolor="black"><a href="/item/iqQuestion?it_uid=${it.it_uid }&category2=${it.category2 }&mb_id=${it.mb_id}" style="color:white">문의하기</a></td>
			<td align="center" bgcolor="black"><a href="/item/iqAll?it_uid=${it.it_uid }" style="color:white">모든 문의</a></td>
		</tr>
    </table style="border-top:2px solid black">
    <br>
</center>
<%@include file = "/include/footer.jsp"%>



<script>
	window.onload = function() {
	    updateButtonState(); // 버튼 초기 상태 설정
	};
	// 수량 변경 함수
	function qty_num(str) {
	    // 현재 수량 가져오기
	    var num = parseInt(document.getElementById("qty").value);
	 	// 남은 수량 가져오기
	 	var qty1 = parseInt(document.getElementById("qty1").value);
	 	var sessionId = "${sessionScope.id}";
	 	$.ajax({
	        url: "/cart/cartqty1", // 전송받을 페이지 경로
	        type: "get", // 데이터 전송 방식
	        dataType: "text", // 서버 응답의 형식
	        data: {
	            it_uid : ${it.it_uid },
	            mb_id : sessionId
	        },
	        error: function () { // 실패일 경우
	        	alert("실패");
	        },
	        success: function (cart_num) { // 성공일 경우
	        	if (str == "-") { // 차감
	    	        if (num == 1) {
	    	            alert("주문 최소 수량은 1개입니다.");
	    	        } else {
	    	            document.getElementById("qty").value = num - 1;
	    	            totalPrice(); // 수량 변경 시 총 가격 업데이트
	    	        }
	    	    } else { // 증가
	    	    	if (qty1 > num + parseInt(cart_num)) { // 현재 수량과 남은 수량의 합이 남은 수량보다 작거나 같은 경우에만 증가
	    	    		document.getElementById("qty").value = num + 1;
	    	            totalPrice(); // 수량 변경 시 총 가격 업데이트
	    	        } else{
	    	        	alert("장바구니 수량과 추가 수량의 총 합이 남은 수량을 초과하여 주문할 수 없습니다.");
	    	        }
	    	    }
	        	updateButtonState(); // 버튼 상태 업데이트
	        }
	    });
	    
	}
	function updateButtonState() {
	    var qtyValue = parseInt(document.getElementById("qty").value);
	    var buyButton = document.getElementById("buyButton");
	    var wishButton = document.getElementById("wishButton");

	    if (qtyValue == 0) {
	        buyButton.disabled = true; // 장바구니 버튼 비활성화
	        wishButton.disabled = true; // 찜하기 버튼 비활성화
	    } else {
	        buyButton.disabled = false; // 장바구니 버튼 활성화
	        wishButton.disabled = false; // 찜하기 버튼 활성화
	    }
	}
	
	// 옵션 선택 시 가격 계산 및 표시 함수
	function calculatePrice() {
	    // 옵션 선택 상자 요소 가져오기
	    var selectBox = document.getElementById("gloOpt2");
	    // 선택한 옵션 값 가져오기
	    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
	    // 가격을 표시할 요소 가져오기
	    var priceElement = document.getElementById("price");
	    
	    // 상품 기본 가격 가져오기
	    var nprice = parseInt(document.getElementsByName("it_price")[0].value);
	    var sprice = parseInt(document.getElementsByName("it_sale")[0].value);
		var price = 0;
		
	    if(sprice != null){
	    	price = sprice;
	    }else {
	    	price = nprice;
	    }
	    
	    // 선택한 옵션에 따른 추가 가격 설정
	    var optPrice = 0;
	    if(selectBox != null) {
		    if (selectedValue.includes("15,000원 추가")) {
		        optPrice = 15000;
		    } else if (selectedValue.includes("30,000원 추가")) {
		        optPrice = 30000;
		    } else if (selectedValue.includes("50,000원 추가")) {
		        optPrice = 50000;
		    } else {
		    	optPrice = 0;
		    }
	    }else {
	    	optPrice = 0;
	    }
	
	    // 총 가격 계산 및 표시
	    price += optPrice;
	    totalPrice(); // 옵션 변경 시 총 가격 업데이트
	}
	
	// 상품의 적립금 계산
	var point = parseInt(document.getElementById("it_point").value); // 적립금
	var totalPoint = point * qty; // 총 적립금 = 적립금 * 수량
	// 총 결제금액 계산 함수
	function totalPrice() {
	    // 총 결제금액을 저장할 변수 초기화
	    var totalPrice = 0;
	    // 상품 가격 가져오기
	    var nprice = parseInt(document.getElementsByName("it_price")[0].value); // 상품 가격
	    var sprice = parseInt(document.getElementsByName("it_sale")[0].value); // 상품 가격
	    // 수량 가져오기
	    var qty = parseInt(document.getElementById("qty").value); // 수량
	    // 옵션에 따른 추가 가격 초기화
	    var optPrice = 0;
	    var price = 0;

	    if(sprice != null){
	        price = sprice;
	    }else {
	        price = nprice;
	    }

	    // 선택한 옵션 값 가져오기
	    var selectBox = document.getElementById("gloOpt2");
	    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
	    
	    // 선택한 옵션에 따른 추가 가격 설정
	    var optPrice = 0;
	    if (selectedValue && selectedValue !== "") {
	        if (selectedValue.includes("15,000원 추가")) {
	            optPrice = 15000;
	        } else if (selectedValue.includes("30,000원 추가")) {
	            optPrice = 30000;
	        } else if (selectedValue.includes("50,000원 추가")) {
	            optPrice = 50000;
	        }
	    } else {
	        optPrice = 0;
	    }
	    
	    // 총 가격 계산
	    totalPrice = ((price + optPrice) * qty );
	    // 총 결제금액을 표시하는 요소 업데이트
	    document.getElementById("pay_total").textContent = totalPrice.toLocaleString() + "원";

	    // 상품의 적립금 계산
	    var point = parseInt(document.getElementById("it_point").value); // 적립금
	    var totalPoint = point * qty; // 총 적립금 = 적립금 * 수량
	    // 총 적립금을 표시하는 요소 업데이트
	    document.getElementById("totalPoint").textContent = totalPoint.toLocaleString();
	}

	//찜하기
	function abc(){
	    var it_uid = document.getElementById("it_uid").value;
	    var it_name = document.getElementById("it_name").value;
	    var it_price = document.getElementById("it_price").value;
	    var it_price = document.getElementById("it_sale").value;
	    var it_sale = document.getElementById("it_sale").value;
	    var qty = document.getElementById("qty").value;
	    var it_point = document.getElementById("it_point").value;
	    var it_op1 = document.getElementById("gloOpt1").value;
	    var it_op2 = document.getElementById("gloOpt2").value;
	    
	    if (it_op1 == "" || it_op2 == "") {
	        alert("옵션을 선택해주세요.");
	        return; // 함수 종료
	    }
	    
	    // AJAX 호출 전에 상태 변수 변경
	    isRequestSent = true;
		
	    $.ajax({
	        url: "/wish/wishinsert", // 전송받을 페이지 경로
	        type: "POST", // 데이터 전송 방식
	        dataType: "text", // 서버 응답의 형식
	        data: {
	            it_uid : it_uid,
	            it_name : it_name,
	            it_price : it_price,
	            it_sale : it_sale,
	            qty : qty,
	            it_point : it_point,
	            it_op1 : it_op1,
	            it_op2 : it_op2
	        },
	        error: function () { // 실패일 경우
	            console.log("실패");
	        	alert("실패");
	        },
	        success: function (response) { // 성공일 경우
	            console.log("성공");
	        	alert("찜하기를 하였습니다.");
	        },
	        complete: function () { // 요청 완료 후
	            // 요청 완료 후 상태 변수 다시 false로 설정
	            isRequestSent = false;
	        }
	    });
	    //var comment = document.getElementById("comment1").value;
		//location.href = "comment1?uid=${n.uid}&tb_table=notice&comment1="+comment;
	}
</script>