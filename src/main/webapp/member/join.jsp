<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>

<script>
 function a(){
	 if(mb_pass.value != mb_passchk.value){
			alert("비밀번호 확인을 입력하세요");
			mb_passchk.focus();
			return false;
		}
 }
</script>

<!-- jQuery를 이용한 AJAX 통신 -->
<script>
$(document).ready(function(){
    // 아이디 입력란에서 키 입력 감지
    $("#mb_id").keyup(function(event){        
        // 영문, 숫자, 밑줄(_) 이외의 문자 제거
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^_a-z0-9]/gi,""));
        }

        // 아이디 중복 확인 AJAX 요청
        $.ajax({
            url: "id_ok",
            type: "post",
            dataType: "text",
            data: "id="+$("#mb_id").val(),
            error:function(){
                alert("실패");
            },
            success:function(num){
                // 결과에 따른 메시지 출력
                if(num == "5") {
                    msg = "<font color=red style='font-size:12px;'>아이디는 5자 이상으로 입력하세요.</font>";
                } else if(num == 1) {
                    msg = "<font color=red style='font-size:12px;'>이미 존재하는 아이디입니다.</font>";
                } else if(num == 0) {
                    msg = "<font color=blue style='font-size:12px;'>사용 가능한 아이디입니다.</font>";
                }
                $("#id_result").html(msg);
            }
        });
        
    });
});
</script>

<!-- 비밀번호 입력란에서 키 입력 감지 -->
<script>
$(document).ready(function(){
    $("#mb_pass").keyup(function(event){        
        // 영문, 숫자 이외의 문자 제거
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            $(this).val($(this).val().replace(/[^a-zA-Z0-9!@#%^&*]/gi,""));
        }

        // 비밀번호 유효성 확인 AJAX 요청
        $.ajax({
            url: "pass_ok",
            type: "post",
            dataType: "text",
            data: "pass="+$("#mb_pass").val(),
            error:function(){
                alert("실패");
            },
            success:function(num){
                // 결과에 따른 메시지 출력
                if(num == 1) {
                    msg = "<font color=red style='font-size:12px;'>비밀번호는 6자리 이상 입력하세요.</font>";
                } else if(num == 2) {
                    msg = "<font color=red style='font-size:12px;'>비밀번호는 20자리 이하로 입력하세요.</font>";
                } else if(num == 0){
                    msg = "<font color=blue style='font-size:12px;'>사용 가능한 비밀번호 입니다.</font>";
                } else if(num == 3){
                	msg = "<font color=red style='font-size:12px;'>사용 불가능한 비밀번호 양식 입니다.</font>";
                }
                $("#pass_result").html(msg);
            }
        });
        
    });
});
</script>

<!-- 비밀번호 확인 -->
<script>
var msg = "";
function passchk_ok(){
    if(mb_pass.value == mb_passchk.value){
        msg = "<font color=blue style='font-size:12px;'>비밀번호가 같습니다.</font>";
    } else {
        msg = "<font color=red style='font-size:12px;'>비밀번호가 다릅니다.</font>";
    }
    $("#passchk_result").html(msg);
}
</script>

<!-- 이메일 인증 -->
<script>
function mailSend(s1,s2,s3){
    // 이메일 입력 확인
    if(s1 === "" || s2 === ""){
        alert("메일주소를 입력하세요");
        mb_email1.focus();
        return;
    }
    alert("잠시 후 메일이 발송됩니다. 잠시만 기다려 주세요");
    // 이메일 발송 AJAX 요청
    $.ajax({
        url : "mailSend",
        type : "post",
        dataType : "text",
        data : "mail1="+s1+"&mail2="+s2+"&result="+s3,
        error:function(){
            alert("메일 보내기를 실패했습니다.");
        },
        success:function(){
            alert("메일 전송이 완료되었습니다. 메일인증을 완료해주세요.");
            mailchk1.focus();
        }
    });
}

var isEmailVerified = false;

// 이메일 인증 완료
function emailVerificationComplete() {
   
   isEmailVerified = true;
    disableEmailField(); 
    if (!isEmailVerified) {
        document.getElementById("signupButton").disabled = true;
    }
}

// 이메일 필드 비활성화
function disableEmailField() {
    if(mailchk1.value != randomString){
        alert("다시 입력하세요");
        mailchk1.focus();
    } else {
        alert("인증되었습니다");
        if (isEmailVerified) {
            document.getElementById("mailsend").disabled = true;
            document.getElementById("mailchk1").disabled = true;
            document.getElementById("mailchk2").disabled = true;
            document.getElementById("signupButton").disabled = false;
        }
    }
}
</script>

<!-- 랜덤 문자열 생성 -->
<script>
function generateRandomString(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

var randomString ="";
window.onload = function() {
    randomString = generateRandomString(8);
    document.getElementById("randomStringDisplay").innerText = randomString;
};
</script>

<!-- 회원가입 폼 -->
<center>
	<br><span style="font-weight: bold;font-size:30px" class="poetsen-one-regular">JOIN</span>
    <form action="join" method="post" onsubmit="return a()">
    <br>
        <table width=800 style="border-spacing: 0px;border:2px solid #AFB5B9">
            <!-- 아이디 입력 -->
            <tr>
            	<td width=150 height=40 style="padding-left:20px">ID</td>
                <td width=650>
                    <input type="text" id="mb_id" name="mb_id" placeholder="아이디를 입력하세요" pattern="^(?=.*[a-z])(?!.*[A-Z]).{5,20}$" title="영문 소문자와 숫자를 포함한 5~20자리 입니다." required>
               <span id="id_result"></span>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 비밀번호 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">비밀번호</td>
                <td>
                    <input id="mb_pass" name="mb_pass" type="password" placeholder="영문 대,소문자와 특수문자" title="영문 대,소문자와 숫자,특수문자[!@#%^&*]를 포함한 6~20자리 입니다." pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#%^&*]).{6,20}$" required>
               <span id="pass_result"></span>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 비밀번호 확인 -->
            <tr>
            	<td height=40 style="padding-left:20px">비밀번호 확인</td>
                <td>
                    <input id="mb_passchk" name="mb_passchk" type="password" placeholder="비밀번호를 다시 입력하세요" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#%^&*]).{6,20}$" onfocusout="passchk_ok()" required>
               <span id="passchk_result"></span>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 이름 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">이름</td>
                <td>
                    <input id="mb_name" name="mb_name" placeholder="이름을 입력하세요" onkeyup="characterCheck1(this)" onkeydown="characterCheck1(this)" required>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 생년월일 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">생일</td>
                <td>
                    <select id="mb_bir1" name="mb_bir1" required>
                       <option value="">연도</option>
                        <%for(int i=2024; i>=1900; i--){ %>
                        <option value="<%=i %>"><%=i %></option>
                        <%} %>
                    </select>
                    <select id="mb_bir2" name="mb_bir2" required>
                       <option value="">월</option>
                        <%for(int i=1; i<=12; i++){ %>
                        <option value="<%=i %>"><%=i %></option>
                        <%} %>
                    </select>
                    <select id="mb_bir3" name="mb_bir3" required>
                       <option value="">일</option>
                        <%for(int i=1; i<=31; i++){ %>
                        <option value="<%=i %>"><%=i %></option>
                        <%} %>
                    </select>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 휴대폰 번호 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">휴대번호</td>
                <td>
                    <select id="mb_pn1" name="mb_pn1" required>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                    </select>
                    - <input id="mb_pn2" name="mb_pn2" pattern="^[0-9]{3,4}" title="3,4자리 숫자만 가능합니다" required>
               - <input id="mb_pn3" name="mb_pn3" pattern="^[0-9]{4,4}" title="4자리 숫자만 가능합니다" required>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 이메일 주소 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">이메일 주소</td>
                <td>
                    <input id="mb_email1" name="mb_email1" placeholder="이메일을 입력하세요" pattern="^[a-zA-Z0-9]{4,40}" title="4~40자 영문과 숫자조합만 가능합니다" required>
                    @<input id="mb_email2" name="mb_email2" required>
                    <select id="mb_email3" name="mb_email3" onChange="mb_email2.value=this.value" title="메일주소를 입력해 주세요">
                        <option value="">직접입력</option> 
                        <option value="nate.com">nate.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="naver.com">daum.net</option>
                        <option value="naver.com">hanmail.net</option>
                    </select>
                  <input id="mailsend" name="mailsend" type="button" value="인증메일보내기" onclick="mailSend(mb_email1.value,mb_email2.value,randomString)">
                </td>
            </tr>
            <!-- 이메일 인증 번호 입력 -->
            <tr>
               <td style="padding-left:20px"></td>
               <td>
                  <input id="mailchk1" name="mailchk1" placeholder="메일 인증번호를 입력하세요" required>
                  <input id="mailchk2" name="mailchk2"  type="button" value="인증확인" onclick="emailVerificationComplete()">
               </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 주소 입력 -->
            <tr>
            	<td height=40 style="padding-left:20px">주소</td>
                <td>
                    <table border="0">
                        <tr>
                            <td>
                                <input type="text" id="sample4_postcode" placeholder="우편번호" name="mb_zc" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" required>
                            </td>
                            <td>
                                <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="mb_zc1">
                            </td>
                            <td>
                                <input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="mb_zc2">
                                <span id="guide" style="color:#999;display:none"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" id="sample4_extraAddress" placeholder="참고항목" name="mb_zc3">
                            </td>
                            <td>
                                <input type="text" id="sample4_detailAddress" placeholder="상세주소" name="mb_zc4">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 성별 선택 -->
            <tr>
            	<td height=40 style="padding-left:20px">성별</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <label><input style="width: 100px; font-size: 16px;" type="radio" name="mb_gender" value="M" checked>남성</label>
                            </td>
                            <td align="center">
                                <label><input style="width: 100px; font-size: 16px;" type="radio" name="mb_gender" value="F">여성</label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr><td colspan=2 height=1 bgcolor="#E5E5E3"></td></tr>
            <!-- 회원가입 버튼 -->
            <tr>
                <td colspan=2 align=center height=40>
                    <button type="submit" id="signupButton" disabled>회원가입</button>
                </td>
            </tr>
        </table>
        <br>
    </form>
</center>
<%@include file="/include/footer.jsp"%>

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