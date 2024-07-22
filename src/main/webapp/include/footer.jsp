<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<hr>


<center>
<table width="100%" bgcolor="black">
	<tr>
		<td align="center">
			<table width="1200" height="125">
				<tr>
					<td width="100" align="center">
						<a href = "/" style="color:white">
						<table>
							<tr>
								<td id="logos">야</td>
								<td id="logos">입</td>
							</tr>
							<tr>
								<td id="logos">구</td>
								<td id="logos">문</td>
							</tr>
						</table>
						</a>
					</td>
					<td width="200" valign="top">
						<table>
							<tr>
								<td style="color:white;font-weight:bold;">회사소개</td>
							</tr>
							<tr>
								<td style="color:#fdfdfd;font-size:12px;">&nbsp;야입구문</td>
							</tr>
							<tr>
								<td style="color:white;font-weight:bold;">주소</td>
							</tr>
							<tr>
								<td style="color:#fdfdfd;font-size:12px;">&nbsp;부산광역시 동래구 충렬대로 84</td>
							</tr>
						</table>
					</td>
					<td width="200" valign="top">
						<table>
							<tr>
								<td style="color:white;font-weight:bold;">연락처</td>
							</tr>
							<tr>
								<td style="color:#fdfdfd;font-size:12px;">전화: 010-8274-6337</td>
							</tr>
							<tr>
								<td style="color:#fdfdfd;font-size:12px;">팩스: 010-8274-6337</td>
							</tr>
						</table>
					</td>
					<td width="200" valign="top">
						<table>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/'">Main</td>
							</tr>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/notice/noticelist'">자유게시판</td>
							</tr>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/orderbbs/orderbbslist'">오더글러브</td>
							</tr>
						</table>
					</td>
					<td width="200" valign="top">
						<table>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/fairtrade/usingrule'">이용약관</td>
							</tr>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/fairtrade/inforule'">개인정보수집</td>
							</tr>
							<tr>
								<td style="color:white;font-size:14px;cursor:pointer;" onclick="location.href='/fairtrade/anotherinfo'">개인정보3자제공</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</center>
</body>
</html>

<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('7afa8658e50498214fde085bae53d5cf'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단

//카카오로그인
function kakaoLogin() {
	Kakao.Auth.login({
		success: function (response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function (response) {
					console.log(response); //회원정보 객체
					console.log("식별 아이디:"+response.id);
					console.log("이메일:"+response.kakao_account.email);
					//회원가입 처리 및 세션 처리
					$.ajax({
						url: "/member/kakao",
						type: "get",
						dataType: "text",
						data: "useremail="+response.kakao_account.email,
						success:function(num) {
							if(num == 2){
								location.href="/member/modify";
							}else {
								location.href="/";
							}
						}
					});
				},
				fail: function (error) {
					console.log(error)
				},
			})
		},
		fail: function (error) {
			console.log(error)
		},
	});
}

//카카오 로그아웃  
function kakaoLogout() {
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function (response) {
				console.log(response);

				//로그아웃 세션 삭제후 첫 페이지 이동
				$.ajax({
					url: "/member/kakaoLogout",
					type: "get",
					dataType: "text",
					success:function(num){
						console.log(num);
							location.href="/";
					}
				});
			},
			fail: function (error) {
				console.log(error);
			},			
		})
		Kakao.Auth.setAccessToken(undefined);		
	}
}
</script>

<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
// 로그인 페이지 활성
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "81CX7QC342xiOIZ2D83m", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl: "http://localhost:8080/member/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
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