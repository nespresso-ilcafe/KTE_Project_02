<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header_popup.jsp" %>
<script>
	function close1(){
		window.close();
	}
</script>
<center>
<table>
	<tr>
		<td align=center border=1>회원정보</td>
	</tr>
</table>
<form method="post">
<table id="a">
	<tr>
		<td id="a">ID</td>
		<td id="a" width=300><input style="width:180px" type="text" value="${modify.id }" name="md_id" required></td>
	</tr>
	<tr>
		<td id="a">비밀번호</td>
		<td id="a"><input style="width:180px" type="pass" value="${modify.pass }" name="md_pass"></td>
	</tr>
	<tr>
		<td id="a">이름</td>
		<td id="a"><input style="width:180px" type="text" value="${modify.name }" name="md_name"></td>
	</tr>
	<tr>
		<td id="a">생일</td>
		<td id="a"><input style="width:180px" value="${modify.birth }" name="md_birth"></td>
	</tr>
	<tr>
		<td id="a">전화번호</td>
		<td id="a"><input style="width:180px" type="text" value="${modify.pn }" name="md_pn"></td>
	</tr>
	<tr>
		<td id="a">Email</td>
		<td id="a"><input style="width:180px" type="email" value="${modify.email }" name="md_email"></td>
	</tr>
	<tr>
		<td id="a">우편번호</td>
		<td id="a"><input style="height:23px" type="text" id="sample4_postcode" value="${modify.zc }" placeholder="우편번호" name="md_zc" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" required><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
	</tr>
	<tr>
		<td id="a">도로명주소</td>
		<td id="a"><input type="text" id="sample4_roadAddress" value="${modify.zc1 }" placeholder="도로명주소" name="md_zc1"></td>
	</tr>
	<tr>
		<td id="a">지번주소</td>
		<td id="a"><input type="text" id="sample4_jibunAddress" value="${modify.zc2 }" placeholder="지번주소" name="md_zc2"><span id="guide" style="color:#999;display:none"></span></td>
	</tr>
	<tr>
		<td id="a">상세주소</td>
		<td id="a"><input type="text" id="sample4_extraAddress" value="${modify.zc3 }" placeholder="참고항목" name="md_zc3"></td>
	</tr>
	<tr>
		<td id="a">참고항목</td>
		<td id="a"><input type="text" id="sample4_detailAddress" value="${modify.zc4 }" placeholder="상세주소" name="md_zc4"></td>
	</tr>

	<tr>
		<td id="a">가입일자</td>
		<td id="a"><input style="width:180px" value="${modify.signdate }" name="md_signdate" required></td>
	</tr>
	<tr>
		<td id="a">로그인 타입</td>
		<td id="a"><input style="width:180px" value="${modify.connecttype }" name="md_connecttype" required></td>
	</tr>
	<tr>
		<td id="a">레벨</td>
		<td id="a">
			<select style="width:185px" name="md_level">
				<option value="${modify.level }">=선택해주세요=</option>
				<option>1</option>
				<option>10</option>
			</select>
		</td>
	</tr>
	<tr>
		<td id="a">상태</td>
		<td id="a">
			<select style="width:185px" name="md_status">
				<option value="${modify.status }">=선택해주세요=</option>
				<option>정상</option>
				<option>정지</option>
				<option>탈퇴</option>
			</select>
		</td>
	</tr>
	<tr>
		<td id="a">성별</td>
		<td id="a">
			남성<input type="radio" value="M" name="md_gender" <c:if test="${modify.gender == 'M' }">checked</c:if>>
			여성<input type="radio" value="F" name="md_gender" <c:if test="${modify.gender == 'F' }">checked</c:if>>
		</td>
	</tr>
</table>
<br>
<table border=0>
	<tr>
		<td id="a"><button style="background-color: black;color:white;border: none;font-size:16px">저장</button></td>
		<td width=20></td>
		<td id="a" onclick="close1()" style="cursor:pointer">창닫기</td>
	</tr>
</table>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
<!-- 다음 우편번호 API 스크립트 -->
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
</center>