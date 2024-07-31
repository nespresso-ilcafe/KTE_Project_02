<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	span{
		cursor:pointer;
	}
	table {
        font-family: Arial, sans-serif;
        background-color: #111;
        color: #fff;
        margin: 0;
        padding: 0;
    }
    #a {
        border: 1px solid #fff;
        border-collapse: collapse;
    }
    .a {
        background-color:white;
    	border:1px solid black;
    }
    #b{
    	background-color:white;
    	border:1px solid black;
    	color:black;
    }
    #c{
    	border:1px solid black;
    	color:black;
    	background-color:#CDCDCD;
    	font-weight:bold;
    }
    th, td {
        padding: 10px;
    }
    a {
        color: #fff;
        text-decoration: none;
    }
    a:hover {
        color: #ccc;
    }
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>야규</title>
<link rel="stylesheet" href="/css/basic.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
</head>
<c:if test="${sessionScope.level != '10' }">
   <script>
      alert("관리자 영역입니다.");
      location.href="/";
   </script>
</c:if>
<body>

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
<style>
	#logo{
		width:60px;
		height:60px;
		color:white;
		font-size:60px;
		text-align:center;
		font-family: 'Gungsuh', '궁서', serif;
	}
</style>
<table width="100%">
	<tr>
		<td align="center">
			<table width=1200 align=center id="a">
				<tr height="25">
					<td rowspan="5" width="175" id="a">
						<a href = "/" style="color:white">
						<table>
							<tr>
								<td id="logo">야</td>
								<td id="logo">입</td>
							</tr>
							<tr>
								<td id="logo">구</td>
								<td id="logo">문</td>
							</tr>
						</table>
						</a>
					</td>
					<td align="right" id="a">
						<c:choose>
						    <c:when test="${sessionScope.id eq null }">
						        <a href="/member/login" style="color:white;">[MY PAGE]</a>
						        <a href="/cart/cartlist" style="color:white;">[장바구니]</a>
						        <a href="/member/login" style="color:white;">[로그인]</a>
						    </c:when>
						    <c:when test="${sessionScope.level ne null }">
						        <a href="/member/mypage?it_uid=?" style="color:white;">[MY PAGE]</a>
						        <a href="/cart/cartlist" style="color:white;">[장바구니]</a>
						        <c:choose>
						            <c:when test="${sessionScope.connecttype == '로컬'}">
						                <a href="/member/logout" style="color:white;">[로그아웃]</a>
						            </c:when>
						            <c:when test="${sessionScope.connecttype == '카카오'}">
						                <a href="/member/logoutkakao" style="color:white;">[로그아웃]</a>
						            </c:when>
						            <c:when test="${sessionScope.connecttype == '네이버'}">
						                <span onclick="naverLogout()" style="cursor:pointer; color:white;">[로그아웃]</span>
						            </c:when>
						        </c:choose>
						    </c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td align="right" height="25" id="a">
						<a href="/notice/noticelist" style="color:white;">[자유게시판]</a>
					</td>
				</tr>
				<tr>
					<td align="right" height="25" id="a">
						<c:if test="${sessionScope.level eq 10 }">
							<a href="/admin" style="color:white;">[관리자]</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td align="right" height="25" id="a">
						<a href="/admin/orders/adminorderlist" style="color:white;">[주문관리]</a>
						<a href="/admin/banner/bannerlist" style="color:white;">[배너관리]</a>
						<a href="/admin/member/list" style="color:white;">[회원관리]</a>
						<a href="/admin/category/list" style="color:white;">[분류관리]</a>
						<a href="/admin/item/list" style="color:white;">[상품관리]</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<hr>
<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
// 로그인 페이지 활성
var naverLogin = new naver.LoginWithNaverId(
   {
      clientId: "ZIsQc1GqXe7kbaIfZ_LM", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
      callbackUrl: "http://localhost:8081/member/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
      isPopup: false,
      callbackHandle: true
   }
);   
naverLogin.init();

// 로그아웃
function openPopUp() {
   testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
   location.href="/member/logout";
   testPopUp.close();
}
function naverLogout() {
   openPopUp();
   setTimeout(function() {
      closePopUp();
   }, 1000);
}
</script>