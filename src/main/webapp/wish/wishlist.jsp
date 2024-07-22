<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
function confirmDelete(uid) {
    if (confirm("삭제하시겠습니까?")) {
        location.href = "wishdelete?uid="+uid;
    }
}
</script>
<style>
	#backbt{
		border:none;
		background-color:black;
		color:white;
	}
	#backbt:hover{
		color:red;
	}
</style>

<center>
	<br>
   <table width=1000 bgcolor="black">
   	<tr>
   		<td>
   			<input type="button" id="backbt" value="뒤로가기" onclick="window.location.href='/member/mypage'">
   		</td>
   	</tr>
      <tr height="40">
         <td align=center width="100" style="color:white">Total : ${count }</td>
         <td align=center style="color:white">WISH LIST</td>
      </tr>
	</table>
	<table width=1000>
      <tr>
      <c:if test="${count == 0 }">
         <td colspan=5 align=center height=300>wish list가 비어있습니다.</td>
      </c:if>
      <c:forEach var="w" items = "${w }">
      <form action="wishinsertcart" method="post">
         <input type="hidden" name="it_uid" id="it_uid" value="${w.it_uid }">
         <input type="hidden" name="it_point" id="it_point" value="${w.it_point }">
         <input type="hidden" name="it_sale" id="it_sale" value="${w.it_sale }">
         <input type="hidden" name="it_price" id="it_price" value="${w.it_price }">
         <input type="hidden" name="it_qty" id="it_qty" value="${w.qty }">
         <input type="hidden" name="it_opt1" id="it_opt1" value="${w.it_option }">
         <td width="50">
            <c:choose>
                    <c:when test="${w.it_qty1 == 0 }">
                     <div style="position: relative;">
                      <img src="/upload_item/${w.file1_thumb }" style="width: 50px;">
                      <img src="/img/pngwing.com.png" style="position: absolute; top: 20%; left: 0; width: 50%;">
                  </div>
                     </c:when>
                     <c:when test="${w.it_qty1 <= 3 }">
                     <div style="position: relative;">
                      <img src="/upload_item/${w.file1_thumb }" style="width: 50px;">
                      <img src="/img/1.png" style="position: absolute; top: -10%; left: 0; width: 50%;">
                  </div>
                     </c:when>
                     <c:otherwise>
                        <img src="/upload_item/${w.file1_thumb }" style="width:50px">
                     </c:otherwise>
               </c:choose>
            </td>
            <td align=center>${w.it_name }</td>
         <c:set var="opt1" value="${w.it_option }"/>
            <c:set var="opt2" value="${fn:split(opt1,'(')[1] }"/>
            <c:set var="opt3" value="${fn:split(opt2,',')[0] }000"/>
         <td align=center width="100"> <fmt:formatNumber value="${w.it_price + opt3 }"/> 원</td>
         <td align=center width="100">${w.qty }</td>
         <td align=center width="300">${w.it_option }</td>
         <td align=center width="100">
            <c:choose>
               <c:when test="${w.it_qty1 == 0 }">
                  <span style="color: red;">품절상품입니다.</span>
               </c:when>
               <c:otherwise>
                  <button style="border:1px solid white;width:100px;height:25px;background-color:black;color:white;">장바구니 넣기</button>
               </c:otherwise>
            </c:choose>
            <button style="border:1px solid white;width:100px;height:25px;background-color:black;color:white;" type="button" onclick="confirmDelete('${w.uid}')">삭제</button>
         </td>
      </tr>
      <tr><td colspan="6" style="border-bottom:1px solid black;"></td></tr>
      </form>
      </c:forEach>
   </table>
   <br>
</center>

<%@ include file="/include/footer.jsp" %>