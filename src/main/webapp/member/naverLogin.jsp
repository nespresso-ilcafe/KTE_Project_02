<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {

			var id = naverLogin.user.id;
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
			var name = naverLogin.user.name;
			var mobile = naverLogin.user.mobile;

			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}

			//회원가입 처리 및 세션 생성 페이지 이동 
			location.href="/member/naver?useremail="+email+"&username="+name+"&phone="+mobile;
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});
</script>

<%@ include file="/include/footer.jsp" %>