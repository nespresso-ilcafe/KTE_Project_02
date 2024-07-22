<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	a{
		color:black;
	}
	span{
		cursor:pointer;
		text-align:center;
	}
	
	#search_area{
		width: 800px;
		height: 50px;
		border-radius: 25px;
		border: 2px solid white;
		background-color: white;
	}
	#search{
		margin-left: 60px;
		width: 700px;
		height: 25px;
	    border: none;
	    outline: none;
	    font-size: 20px;
	    vertical-align: middle;
	}
	#search_button{
		width: 50px;
		height: 50px;
		background-color: white;
	    border: none;
	    outline: none;
	}
	#logo{
		width:60px;
		height:60px;
		color:white;
		font-size:60px;
		text-align:center;
		font-family: 'Gungsuh', '궁서', serif;
		font-weight:bold;
	}
	#logos{
		width:40px;
		height:40px;
		color:white;
		font-size:40px;
		text-align:center;
		font-family: 'Gungsuh', '궁서', serif;
	}
	.hover-gray:hover {
        color: red;
    }
    .hover-gray-border:hover {
        border:1px solid #EAEAEA !important;
    }
	span{
		cursor:pointer;
		text-align:center;
	}
	
	#search_area{
		width: 800px;
		height: 50px;
		border-radius: 25px;
		border: 2px solid white;
		background-color: white;
	}
	#search{
		margin-left: 60px;
		width: 700px;
		height: 25px;
	    border: none;
	    outline: none;
	    font-size: 20px;
	    vertical-align: middle;
	}
	#search_button{
		width: 50px;
		height: 50px;
		background-color: white;
	    border: none;
	    outline: none;
	}
	.poetsen-one-regular {
	  font-family: "Poetsen One", sans-serif !important;
	  font-weight: 400 !important;
	  font-style: normal !important;
	}
	.poor-story-regular {
	  font-family: "Poor Story", system-ui;
	  font-weight: 400;
	  font-style: normal;
	}
	/* 입력 필드 스타일링 */
	.input-underlined {
	    border: none;
	    border-bottom: 1px solid #ccc; /* 밑줄 스타일 지정 */
	    outline: none;
	    padding: 5px;
	}
	
	/* 입력 필드에 마우스 호버 효과 */
	.input-underlined:hover {
	    border-bottom-color: #555; /* 호버 시 밑줄 색 변경 */
	}
	
	/* 입력 필드에 포커스 효과 */
	.input-underlined:focus {
	    border-bottom-color: #007bff; /* 포커스 시 밑줄 색 변경 */
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
<body>
<table width="100%" bgcolor="black">
	<tr>
		<td align="center">
			<table width=1200 height="175" >
				<tr height="25">
					<td rowspan="4" width="175">
						<a href = "/" style="color:white;">
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
					<td align="right">
						<c:choose>
						    <c:when test="${sessionScope.id eq null }">
						    	<span onclick="location.href='/member/login'" style="color:white;">[MY PAGE]</span>
						    	<span onclick="location.href='/cart/cartlist'" style="color:white;">[장바구니]</span>
						    	<span onclick="location.href='/member/login'" style="color:white;">[로그인]</span>
						    </c:when>
						    <c:when test="${sessionScope.level ne null }">
						    	<span onclick="location.href='/member/mypage'" style="color:white;">[MY PAGE]</span>
						    	<span onclick="location.href='/cart/cartlist'" style="color:white;">[장바구니]</span>
				 		        <c:choose>
						            <c:when test="${sessionScope.connecttype == '로컬'}">
						    			<span onclick="location.href='/member/logout'" style="color:white;">[로그아웃]</span>
						            </c:when>
						            <c:when test="${sessionScope.connecttype == '카카오'}">
						    			<span onclick="location.href='/member/logoutkakao'" style="color:white;">[로그아웃]</span>
						            </c:when>
						            <c:when test="${sessionScope.connecttype == '네이버'}">
						                <span onclick="naverLogout()" style="cursor:pointer;color:white;">[로그아웃]</span>
						            </c:when>
						        </c:choose>
						    </c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td align="right" height="25">
						<span onclick="location.href='/notice/noticelist'" style="color:white;">[자유게시판]</span>
					</td>
				</tr>
				<tr>
					<td align="right" height="25">
						<c:if test="${sessionScope.level eq 10 }">
							<span onclick="location.href='/admin'" style="color:white;">[관리자]</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
					<form action="/mainsearch">
						<table width="850">
							<tr>
								<td id="search_area">
									<input id="search" name="search">
									<button id="search_button">
										<img alt="" src="/img/search_icon.png" style="width:25px;height:25px;margin-left:15px;">
									</button>
								</td>
							</tr>
						</table>
					</form>
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