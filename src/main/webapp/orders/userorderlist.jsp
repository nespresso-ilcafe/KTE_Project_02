<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<c:if test="${sessionScope.id ne iq.mb_id && sessionScope.id eq null}">
   <script type="text/javascript">
      alert("담을 넘지 마시오.");
      location.href = "/member/login";
   </script>
</c:if>
<style>
   input{
      border:none;
      text-align:center;
   }
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
   <table width="1000" bgcolor="black">
      <tr>
         <td height=30>
            <input type="button" id="backbt" value="뒤로가기" onclick="window.location.href='/member/mypage'">
      </tr>
      <tr>
         <td align="left" style="color:white;">total : ${count }</td>
      </tr>
   </table>
   <table>
      <tr>
         <td colspan="8">
         <table width="800">
            <c:forEach var="a" items="${a }">
               <tr><td colspan="4" style="border-bottom:1px solid black;"></td></tr>
               <tr>
                  <td align="center" rowspan="5" width="75"><img src="/upload_item/${a.file1_thumb }" style="width:75px;height:75px;" onclick="location.href = '/orders/userorderview?mb_id=${a.mb_id }&od_id=${a.od_id }'"></td>
               </tr>
               <tr>
                  <td align="center" width="300"> 주문번호 : <a href="/orders/userorderview?mb_id=${a.mb_id }&od_id=${a.od_id }">${a.od_id}</a></td>
                  <td align="center" width="100">
                     <c:choose>
                          <c:when test="${a.ct_status eq '주문' }">
                              <input value="주문접수" readonly>
                          </c:when>
                          <c:when test="${a.ct_status eq '배송' }">
                              <input value="배송시작" readonly>
                          </c:when>
                          <c:when test="${a.ct_status eq '완료' }">
                              <input value="배송완료" readonly>
                          </c:when>
                          <c:when test="${a.ct_status eq '구매확정' }">
                              <input value="구매확정" readonly>
                          </c:when>
                          <c:when test="${a.ct_status eq '리뷰작성' }">
                              <input value="리뷰작성" readonly>
                          </c:when>
                      </c:choose>
                  </td>
                  <td align="center" >${a.or_date }</td>
               </tr>
               <tr><td colspan="4" style="border-bottom:1px solid black;"></td></tr>
               <tr>
                  <td align="center" >${a.mb_id }</td>
                  <td align="center" >${a.name }</td>
                  <td align="center" >
                      
                      <fmt:formatNumber value="${a.total_price }"/> 원
                  </td>
               </tr>
               <tr><td colspan="4" style="border-bottom:1px solid black;"></td></tr>
            </c:forEach>
         </table>
         </td>
      </tr>
    </table>
    <!-- 페이징 -->
   <table width=1200 style="border:0px;background-color: white">
      <tr>
         <td align=center style="background-color: white">
            <c:if test="${count > 0 }">
               <fmt:parseNumber var="pageCount" value="${count/pageSize+(count%pageSize==0?0:1)}" integerOnly="true"/>
               <c:set var="startPage" value="${1 }"/>
               <c:set var="pageBlock" value="${10 }"/>
               <c:if test="${pageNum>pageBlock }">
                  <fmt:parseNumber var="startPage" value="${(pageNum/pageBlock-(pageNum%pageBlock==0?1:0))*pageBlock+1 }" integerOnly="true"/>
               </c:if>
               <fmt:parseNumber var="endPage" value="${startPage+pageBlock-1 }" integerOnly="true"/>
               <c:if test="${endPage>pageCount }">
                  <c:set var="endPage" value="${pageCount }"/>
               </c:if>
               <c:if test="${startPage>pageBlock }">
                  <a href="userorderlist?mb_id=${sessionScope.id }&pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
               </c:if>
               <c:forEach var="i" begin="${startPage }" end="${endPage }">
                  <c:choose>
                     <c:when test="${pageNum == i }">
                        <a href="userorderlist?mb_id=${sessionScope.id }&pageNum=${i }&field=${field}&search=${search}"><font color=red>${i }</font></a>
                     </c:when>
                     <c:otherwise>
                        <a href="userorderlist?mb_id=${sessionScope.id }&pageNum=${i }&field=${field}&search=${search}"><font color=black>${i }</font></a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
               <c:if test="${endPage < pageCount}">
                  <a href="userorderlist?mb_id=${sessionScope.id }&pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
               </c:if>
            </c:if>
         </td>
      </tr>
   </table>
<br>
</center>

<%@ include file="/include/footer.jsp" %>