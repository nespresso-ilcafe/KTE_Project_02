<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<style>
input{
	border-top:none;
	border-bottom:1px solid black;
	border-left:none;
	border-right:none;
	font-size:16px;
	text-align:center;
	background-color:white;
}
input:hover{
	border-bottom:red;
}
select{
	border:none;
	width:75px;
	height:30px;
	text-align:center;
	font-size:16px;
}
#save{
	 border:none;
	 width:100px;
	 height:40px;
	 background-color:black;
	 color:white;
	 font-size:18px;
	 cursor:pointer;
}
#save:hover{
    color: red;
}
#close{
	border:none;
	background-color:black;
	width:100px;
	height:40px;
	color:white;
	font-size:18px;
	cursor:pointer
}
#close:hover{
    color: red;
}
</style>
<center>
<br>
<c:choose>
   <c:when test="${modify.name eq '카카오로그인' || modify.name eq '네이버로그인'}">
      <table bgcolor="black" width="600" height="60">
         <tr>
            <td style="color:white">회원수정</td>
            <div style="color:white">간편로그인시 회원정보를 수정하셔야 이용 가능합니다!</div>
         </tr>
      </table>
   </c:when>
   <c:otherwise>
      <table bgcolor="black" width="600" height="60">
         <tr>
            <td align="center" style="color:white;font-size:18px">회원수정</td>
         </tr>
      </table>
   </c:otherwise>
</c:choose>
<form method="post">
<center>
<br>
   <table width="600">
      <tr><td colspan="2" style="border-top:2px solid black;"></td></tr>
      <tr>
         <td width="150" height="40" align="center" style="border-right:1px solid black;">ID</td>
         <td align="center"><input style="width:150px;height:30px;" type="text" value="${modify.id }" name="md_id" required></td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <c:choose>
         <c:when test="${modify.connecttype == '카카오' || modify.connecttype == '네이버'}"></c:when>
         <c:otherwise>
            <tr>
               <td height="40" align="center" style="border-right:1px solid black;">비밀번호</td>
               <td align="center"><input style="width:150px;height:30px;" type="password" value="${modify.pass }" name="md_pass"></td>
            </tr>
         </c:otherwise>
      </c:choose>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="40" align="center" style="border-right:1px solid black;">이름</td>
         <td align="center"`><input style="width:150px;height:30px;" type="text" name="md_name" title="이름을 입력해주세요" value="${modify.name }" required></td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="40" align="center" style="border-right:1px solid black;">생일</td>
         <td align="center">
            <c:set var="nowYear" value="2024"></c:set>
            <select name="mb_bir1">
               <c:forEach var="i" begin="1900" end="${nowYear}" step="1">
                  <option value="${nowYear - i + 1900}">${nowYear - i + 1900}</option>
               </c:forEach>
            </select>
            
            <select name="mb_bir2">
               <c:forEach var="i" begin="1" end="12" step="1">
                  <option value="${i }">${i }</option>
                  <c:if test="${fn:split(modify.birth,'-')[1] eq i}">
                  	<option value="${i }" selected>${i }</option>
                  </c:if>
               </c:forEach>
            </select>
            
            <select name="mb_bir3">
               <c:forEach var="i" begin="1" end="31" step="1">
                  <option value="${i }">${i }</option>
                  <c:if test="${fn:split(modify.birth,'-')[2] eq i}">
                  <option value="${i }" selected>${i }</option>
                  </c:if>
               </c:forEach>
            </select>
         </td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="40" align="center" style="border-right:1px solid black;">전화번호</td>
         <td align="center">
         <table>
	         <tr>
		         <td>
			         <select name="mb_pn1" required>
		               <c:if test="${modify.pn eq null }">
		                  <option value="">핸드폰 번호를 입력하세요</option>
		               </c:if>
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
		            </select>
		            <c:if test="${modify.pn eq null }">
		            	<input style="width:100px;height:30px;" name="mb_pn2" pattern="^[0-9]{3,4}"
		            	 title="3,4자리 숫자만 입력해주세요" required>
		            	<input style="width:100px;height:30px;" name="mb_pn3" pattern="^[0-9]{3,4}"
		            	 title="4자리 숫자만 입력해주세요" required>
		            </c:if>
		            <c:if test="${modify.pn ne null }">
		                <input style="width:100px;height:30px;" name="mb_pn2" pattern="^[0-9]{3,4}"
		                 title="3,4자리 숫자만 입력해주세요" value="${fn:split(modify.pn,'-')[1] }">
		            	<input style="width:100px;height:30px;" name="mb_pn3" pattern="^[0-9]{3,4}"
		            	 title="4자리 숫자만 입력해주세요" value="${fn:split(modify.pn,'-')[2] }">
		            </c:if>
		         </td>
	         </tr>
         </table>
         </td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="40" align="center" style="border-right:1px solid black;">Email</td>
         <td align="center">
          	<input name="mb_email1" style="width:150px;height:30px;" value="${fn:split(modify.email,'@')[0] }" pattern="^[a-zA-Z0-9]{4,40}" title="4~40자 영문과 숫자조합만 가능합니다" required>
            @<input name="mb_email2" style="width:100px;height:30px;" value="${fn:split(modify.email,'@')[1] }" required>
            <select name="mb_email3" style="width:100px;height:30px;" onChange="mb_email2.value=this.value" title="메일주소를 입력해 주세요" required>
                <option value="${fn:split(modify.email,'@')[1] }">${fn:split(modify.email,'@')[1] }</option> 
                <option value="nate.com">nate.com</option>
                <option value="naver.com">naver.com</option>
                <option value="naver.com">daum.net</option>
                <option value="naver.com">hanmail.net</option>
            </select>
         </td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="80" align="center" style="border-right:1px solid black;">우편번호</td>
         <td align="center">
            <table border="0">
               <tr>
                   <td>
                       <input type="text" style="width:150px;height:30px;" id="sample4_postcode" value="${modify.zc }" name="md_zc" pattern="^[0-9]{3,20}" title="우편번호는 필수입력사항입니다!" required>
                   </td>
                   <td>
                       <input type="button" style="width:150px;height:30px;" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
                   </td>
               </tr>
               <tr>
                   <td>
                       <input type="text" style="width:150px;height:30px;" id="sample4_roadAddress" value="${modify.zc1 }" name="md_zc1">
                   </td>
                   <td>
                       <input type="text" style="width:150px;height:30px;" id="sample4_jibunAddress" value="${modify.zc2 }" name="md_zc2">
                       <span id="guide" style="color:#999;display:none"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="text" style="width:150px;height:30px;" id="sample4_extraAddress" value="${modify.zc3 }" name="md_zc3">
                    </td>
                    <td>
                    	<input type="text" style="width:150px;height:30px;" id="sample4_detailAddress" value="${modify.zc4 }" name="md_zc4" placeholder="(상세주소)">
                    </td>
                </tr>
            </table>
         </td>
      </tr>
      <tr><td colspan="2" style="border-bottom:1px solid black;"></td></tr>
      <tr>
         <td height="40" align="center" style="border-right:1px solid black;">성별</td>
         <td align="center">
         	<table>
         		<tr>
         			<c:choose>
			         	<c:when test="${modify.gender == null }">
			         		<td align="center">남성<input type="radio" value="M" name="md_gender" checked></td>
			         		<td width="50"></td>
				            <td align="center">여성<input type="radio" value="F" name="md_gender"></td>
			         	</c:when>
			         	<c:otherwise>
				         	<td align="center">남성<input type="radio" value="M" name="md_gender" <c:if test="${modify.gender == 'M' }">checked</c:if>></td>
			         		<td width="50"></td>
				            <td align="center">여성<input type="radio" value="F" name="md_gender" <c:if test="${modify.gender == 'F' }">checked</c:if>></td>
			         	</c:otherwise>
			         </c:choose>
         		</tr>
         	</table>
         </td>
      </tr>
      <tr><td colspan="2" style="border-bottom:2px solid black;"></td></tr>
   </table>
<br>
<table bgcolor="black" width="600" height="60">
   <tr>
      <td align="right" width="48%">
      	<button id="save">저장</button>
      </td>
      <td align="left" width="48%">
      	<input id="close" type="button" value="창닫기" onclick="close1()" width="48%">
      </td>
   </tr>
</table>
<br>
</form>
</center>

<%@ include file="/include/footer.jsp" %>
<script>
function close1(){
	window.location.href='/member/mypage';
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