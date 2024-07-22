<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<script>
  var index = 0;
  var slides;
  var timer; // 타이머 변수 추가

  window.onload = function(){
    slides = document.querySelectorAll(".slide1");
    slideShow();
  }

  function slideShow() {
    for (var i = 0; i < slides.length; i++) {
      slides[i].classList.remove("active");
    }

    index++;
    if (index > slides.length) {
      index = 1;
    }
    slides[index - 1].classList.add("active");

    // 이전 버튼을 클릭한 후에도 다음 이미지로 전환될 수 있도록 타이머 재설정
    clearTimeout(timer);
    timer = setTimeout(slideShow, 4000);
  }

  function showNextSlide() {
    index++;
    if (index > slides.length) {
      index = 1;
    }
    updateSlide();
  }

  function showPrevSlide() {
    index--;
    if (index < 1) {
      index = slides.length;
    }
    updateSlide();

    // 이전 버튼을 클릭한 후에도 다음 이미지로 전환될 수 있도록 타이머 재설정
    clearTimeout(timer);
    timer = setTimeout(slideShow, 4000);
  }

  function updateSlide() {
    for (var i = 0; i < slides.length; i++) {
      slides[i].classList.remove("active");
    }
    slides[index - 1].classList.add("active");
  }
</script>
<style>
  .slide-container {
    overflow: hidden;
    width: 1200px;
    height: 600px;
    position: relative;
  }

  .slide1 {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    transition: opacity 1s ease-in-out;
    opacity: 0;
  }

  .active {
    opacity: 1;
  }
</style>
<center>
	<table width="1200">
		<tr>
			<td>
				<button onclick="showPrevSlide()" style="background-color: transparent; border: 0;">
				<img src="/img/3.png" style="width: 25px; height: 25px;">
				</button>
			</td>
			<td align="center">
				<div class="slide-container">
				<c:forEach var="b" items = "${b }">
					<img class="slide1 active" src="/upload_item/${b.file1 }">
				</c:forEach>
				</div>
			</td>
			<td>
		      	<button onclick="showNextSlide()" style="background-color: transparent; border: 0;">
		      		<img src="/img/3_1.png" style="width: 25px; height: 25px;">
				</button>
			</td>
		</tr>
	</table>
    <table width="1200">
        <tr>
        	<td height=300 align=center>
        		<img src="/img/4_4.png" onclick="location.href = '/item/list?category1=10'" style="width: 200px; height: 200px;">
        		<br><span>글러브</span>
        	</td>
        	<td align=center>
        		<img src="/img/4_5.png" onclick="location.href = '/item/list?category1=20'" style="width: 200px; height: 200px;">
        		<br><span>배트</span>
        	</td>
        	<td align=center>
        		<img src="/img/4_3.png" onclick="location.href = '/item/list?category1=30'" style="width: 200px; height: 200px;">
        		<br><span>용품</span>
        	</td>
        	<td align=center>
        		<img src="/img/4_2.png" onclick="location.href = '/orderbbs/orderbbslist'" style="width: 200px; height: 200px;">
        		<br><span>오더글러브</span>
        	</td>
        </tr>
    </table>
    <c:if test="${count != 0 }">
        <table width="1200" height="35" bgcolor="black">
            <tr>
            	<td width="10"></td>
                <td style="color:white;font-size:18px;">최신 상품</td>
                <td style="color:white;font-size:18px;" align="right">total : ${count }</td>
            	<td width="10"></td>
            </tr>
        </table>
        <br>
    </c:if>
    <!-- 등록된 상품이 없을 때 -->
    <table width="1200">
        <c:if test="${count == 0 }">
            <tr>
                <td align="center" height="300"><font>현재 등록된 상품이 없습니다.</font></td>
            </tr>
        </c:if>
        <!-- 물품 목록 반복문 시작 -->
        <c:set var="i" value="0" />
        <c:set var="j" value="5" />
        <c:forEach var="it" items="${v }">
            <c:if test="${i % j == 0 }">
                <tr>
            </c:if>
            <td valign="top" align="center" height="305">
            	<a href="/item/view?it_uid=${it.it_uid }">
                <table>
                    <tr>
                        <td width=200>
                            <c:choose>
		                		<c:when test="${it.it_qty == 0 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/soldout.png" style="position: absolute; top: -10%; left: -25%; width: 100%;">
									</div>
		                    	</c:when>
		                    	<c:when test="${it.it_qty <= 10 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/almostsoldout.png" style="position: absolute; top: -8%; left: -14%; width: 60%;">
									</div>
		                    	</c:when>
		                    	<c:when test="${it.it_sale != 0 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/sale.png" style="position: absolute; top: -5%; left: -5%; width: 35%;">
									</div>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
		                    	</c:otherwise>
		                    </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">${it.it_name }</td>
                    </tr>
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${it.it_sale ne 0 }">
                                    <font style="color: gray; font-size:14px;"><fmt:formatNumber value="${it.it_price }" />원</font>
                                    <br>
                                    <font style="color: #FE642E; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_sale }" />원</font>
                                </c:when>
                                <c:otherwise>
                                    <font style="color: black; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_price }" />원</font>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
                </a>
            </td>
            <c:if test="${i % j == j - 1}">
                </tr>
            </c:if>
            <c:set var="i" value="${i + 1 }" />
        </c:forEach>
        <!-- 물품 목록 반복문 끝 -->
    </table>
</center>

<%@include file="/include/footer.jsp" %>

<script>
    
</script>
