<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<center>
    <!-- 상품 페이지 리뷰 -->
    <br>
    <table width="800" bgcolor="black">
    	<tr>
    		<td align="center" style="color:white">구매 후기</td>
    	</tr>
    </table>
    <table width="800" style="border-top:2px solid black">
    	<tr>
			<c:set var="av" value="${average }"/>
    		<td colspan="2" align="center"></td>
    		<td align="center">제목</td>
			<td><!-- <img src="/img/rating.png" style="width:12px">&nbsp;&nbsp;<fmt:formatNumber value="${av }" pattern="0.0"/> --></td>
			<td width="100" align="center">작성자</td>
    	</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:forEach var="rv" items="${rv }">
		<c:set var="number" value="${number }"/>
			<tr>
				<td align="center" rowspan="2">${number }</td>
				<c:choose>
            		<c:when test="${rv.file1_thumb == null || rv.file1_thumb == '' }">
			            <td width="50" height="50" align="center" rowspan="2" style="border-right:1px solid black;">
			            	<img src="/img/no_image.png" style="width:30px;height:30px;">
			            </td>
            		</c:when>
            		<c:when test="${rv.file1_thumb != null || rv.file1_thumb != '' }">
            			<td width="50" height="50" align="center" rowspan="2">
			            	<img src="/upload_item/${rv.file1_thumb }" style="width:30px;height:30px;">
			            </td>
            		</c:when>
            	</c:choose>
				<td align="center">${rv.rv_sub }</td>
				<td width="50" rowspan="2"><img src="/img/rating.png" style="width:12px">&nbsp;&nbsp;<fmt:formatNumber value="${rv.rating }" pattern="0.0" /></td>
				<td align="center">${fn:substring(rv.mb_id,0,3) }********</td>
			</tr>
			<tr>
				<c:set var="textShow" value="${fn:substring(rv.rv_text,0,10) }"/>
				<td align="center">
					<c:choose>
						<c:when test="${fn:length(textShow) >= 10 }">
						<a href="/item/reviewsview?it_uid=${it.it_uid }&category2=${it.category2 }&rv_uid=${rv.rv_uid }">${textShow }...</a>
						</c:when>
						<c:otherwise>
						<a href="/item/reviewsview?it_uid=${it.it_uid }&category2=${it.category2 }&rv_uid=${rv.rv_uid }">${textShow }</a>
						</c:otherwise>
					</c:choose>
				</td>
				<input type="hidden" id="rating" value="${rv.rating }">
				<td align="center">${rv.rv_date }</td>
			</tr>
			<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:set var="number" value="${number-1 }"/>
		</c:forEach>
    </table>
    <!--페이징-->
   <table>
      <tr>
         <td>
            <c:if test="${rcount>0 }">
               <fmt:parseNumber var="pageCount" value="${rcount/pageSize+(rcount%pageSize==0?0:1)}" integerOnly="true"/>
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
                  <a href="reviews?it_uid=${it.it_uid }&pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
               </c:if>
               <c:forEach var="i" begin="${startPage }" end="${endPage }">
                  <c:choose>
                     <c:when test="${pageNum == i }">
                        <a href="reviews?it_uid=${it.it_uid }&pageNum=${i }&field=${field}&search=${search}"><font style="font-weight:bold; color:black;">${i }</font></a>
                     </c:when>
                     <c:otherwise>
                        <a href="reviews?it_uid=${it.it_uid }&pageNum=${i }&field=${field}&search=${search}">${i }</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
               <c:if test="${endPage < pageCount}">
                  <a href="reviews?it_uid=${it.it_uid }&pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
               </c:if>
            </c:if>
         </td>
      </tr>
   </table>
</center>

<%@include file="/include/footer.jsp" %>