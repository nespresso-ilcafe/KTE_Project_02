<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>

<script>
function a() {
    var it_price = parseInt(document.getElementById("it_price").value); // 판매가격 입력값 가져오기
    var it_sale = parseInt(document.getElementById("it_sale").value); // 세일가격 입력값 가져오기
    var it_point;
    if(!isNaN(it_sale) && it_sale !=""){
       var it_point = Math.floor(parseInt(it_sale) / 100); // 포인트 계산
    }else{
       var it_point = Math.floor(parseInt(it_price) / 100); // 포인트 계산
    }
    
    document.getElementById("it_point").value = it_point; // 계산된 포인트를 입력란에 표시
}

function cate_2(cate){
   $.ajax({
      url: "category_ok", //전송받을 페이지 경로
      type: "post", //데이터 전송 방식
      dataType: "text",
      data: "ca_id="+cate,
      error:function(xhr, status, error){ //실패일 경우
         console.log(error);
         alert("실패");
      },
      success:function(text){ //성공일 경우
         $("#category2_result").html(text);
         if(cate == 10) {
             $("#option_row").show();
             $("input[name='it_type1']").prop("checked", true);
             $("input[name='it_type2']").prop("checked", true);
          } else {
             $("#option_row").hide();
             $("input[name='it_type1']").prop("checked", false);
             $("input[name='it_type2']").prop("checked", false);
          }
      }
   });
}
</script>
<center>
<table style="background-color: white">
	<tr>
		<td>
			<input type="button" value="뒤로가기" onclick="location.href = '/admin/item/list'">
		</td>
	</tr>
</table>
<form action="write" method="post" enctype="multipart/form-data">
<br>
<table width=1200>
   <tr>
      <td id="b" width=200>카테고리</td>
      <td id="b" style="text-align:left">
         <select id="category1" name="category1" onchange="cate_2(this.value)">
            <option value="">=대분류 선택=</option>
            <c:forEach var="c" items="${v }">
            <option value="${c.ca_id }">${c.ca_name }</option>
            </c:forEach>
         </select>
         <span id="category2_result">
            <select id="category2" name="category2">
               <option value="">=대분류를 먼저 선택하세요=</option>
            </select>
         </span>
      </td>
   </tr>
   <tr>
      <td id="b" align=center>상품명</td>
      <td id="b" style="text-align:left"><input name="it_name" required></td>
   </tr>
   <tr>
      <td id="b" align=center>아이디</td>
      <td id="b" style="text-align:left"><input name="mb_id" value="${sessionScope.id}" readonly></td>
   </tr>
   <tr>
      <td id="b" align=center>판매가격</td>
      <td id="b" style="text-align:left"><input name="it_price" id="it_price" oninput="a()" required></td>
   </tr>
   <tr>
      <td id="b" align=center>세일 가격</td>
      <c:choose>
         <c:when test="${it_sale == null || it_sale eq '' }">
            <td id="b" style="text-align:left"><input name="it_sale" id="it_sale" oninput="a()" value="0"></td>
         </c:when>
         <c:otherwise>
            <td><input name="it_sale" id="it_sale" oninput="a()"></td>
         </c:otherwise>
      </c:choose>
   </tr>
   <tr>
      <td id="b" align=center>상품포인트</td>
      <td id="b" style="text-align:left"><input name="it_point" id="it_point" value="${it_price/100 }"></td>
   </tr>
   <tr>
      <td id="b" align=center>상품수량</td>
      <td id="b" style="text-align:left"><input name="it_qty" required></td>
   </tr>
   <tr>
      <td id="b" align=center>판매가능</td>
      <td id="b" style="text-align:left">
         Y<input type="radio" value="Y" name="it_use" checked>
         N<input type="radio" value="N" name="it_use">
      </td>
   </tr>
   <tr id="option_row" style="display: none;">
		<td id="b" align=center>옵션선택</td>
		<td id="b" style="text-align:left">
			<input type="checkbox" name="it_type1" value="Y">우투/좌투 &nbsp;&nbsp;
			<input type="checkbox" name="it_type2" value="Y">길들이기 &nbsp;&nbsp;
			<input type="hidden" name="it_type3" value="Y"> &nbsp;&nbsp;
			<input type="hidden" name="it_type4" value="Y">&nbsp;&nbsp;
			<input type="hidden" name="it_type5" value="Y">&nbsp;&nbsp;
			<span style="color:red;">필수 옵션으로 선택 해제 불가합니다. </span>
		</td>
   </tr>	
   <tr>
      <td id="b" align=center>상품 이미지</td>
      <td style="background-color: white">
         <table style="background-color: white;color:black">
            <tr>
               <td>
                  <input type="file" name="file1">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="file" name="file2">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="file" name="file3">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="file" name="file4">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="file" name="file5">
               </td>
            </tr>
         </table>
      </td>
   </tr>
</table>
<table style="background-color: white">
   <tr>
      <td><button>등록</button></td>
   </tr>
</table>
</form>
</center>

<%@ include file="/admin/include/footer.jsp" %>