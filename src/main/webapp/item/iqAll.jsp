<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<c:if test="${sessionScope.id eq null }">
   <script type="text/javascript">
      alert("로그인후 이용 가능합니다!");
      location.href = "/member/login";
   </script>
</c:if>

<center>
	<br>
    <!-- 상품 페이지 문의글 -->
    <table width="800" bgcolor="black">
    	<tr>
    		<td align="center" style="color:white">상품 문의</td>
    	</tr>
    </table>
    <table width="800" style="border-top:2px solid black;border-top:2px solid black">
		<tr style="border-bottom:1px solid black;">
			<td align="center" width="40">no</td>
			<td colspan="2">제목</td>
			<td width="100" align="center">작성자</td>
			<td width="100" align="center">작성일</td>
		</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:forEach var="q" items="${q }">
		<c:set var="qnumber" value="${qnumber }"/>
			<tr height="25">
				<td align="center" style="border-right:1px solid black">${qnumber }</td>
				<td colspan="2">
					<c:set var="subCut" value="${q.qna_subject }"/>
					<c:set var="thread" value="${q.thread }"/>
					<c:choose>
						<c:when test="${fn:length(thread) == 1}">
							<c:choose>
								<c:when test="${fn:length(subCut) >= 10 }">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }...</a>
								</c:when>
								<c:otherwise>
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${fn:length(thread) > 1}">
							<c:choose>
								<c:when test="${fn:length(subCut) >= 10 }">
									<img alt="" src="/img/thread.png">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }...</a>
								</c:when>
								<c:otherwise>
									<img alt="" src="/img/thread.png" style="width:15px;height:15px;">
									<a href="/item/iqviews?it_uid=${it.it_uid }&category2=${it.category2 }&qna_uid=${q.qna_uid }">${fn:substring(subCut,0,10) }</a>
								</c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
				</td>
				<td align="center">${q.mb_id }</td>
				<td align="center">${q.signdate }</td>
			</tr>
		<tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
		<c:set var="qnumber" value="${qnumber - 1 }"/>
		</c:forEach>
    </table>
    <!--페이징-->
   <table width="800">
      <tr>
      	<td width="100" height="30"></td>
         <td align="center">
            <c:if test="${qcount>0 }">
               <fmt:parseNumber var="pageCount" value="${qcount/qpageSize+(qcount%qpageSize==0?0:1)}" integerOnly="true"/>
               <c:set var="startPage" value="${1 }"/>
               <c:set var="pageBlock" value="${10 }"/>
               <c:if test="${qpageNum>pageBlock }">
                  <fmt:parseNumber var="startPage" value="${(qpageNum/pageBlock-(qpageNum%pageBlock==0?1:0))*pageBlock+1 }" integerOnly="true"/>
               </c:if>
               <fmt:parseNumber var="endPage" value="${startPage+pageBlock-1 }" integerOnly="true"/>
               <c:if test="${endPage>pageCount }">
                  <c:set var="endPage" value="${pageCount }"/>
               </c:if>
               <c:if test="${startPage>pageBlock }">
                  <a href="iqAll?it_uid=${it.it_uid }&pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
               </c:if>
               <c:forEach var="i" begin="${startPage }" end="${endPage }">
                  <c:choose>
                     <c:when test="${qpageNum == i }">
                        <a href="iqAll?it_uid=${it.it_uid }&pageNum=${i }&field=${field}&search=${search}"><font style="font-weight:bold; color:black;">${i }</font></a>
                     </c:when>
                     <c:otherwise>
                        <a href="iqAll?it_uid=${it.it_uid }&pageNum=${i }&field=${field}&search=${search}">${i }</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
               <c:if test="${endPage < pageCount}">
                  <a href="iqAll?it_uid=${it.it_uid }&pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
               </c:if>
            </c:if>
         </td>
         <td width="100" align="center" bgcolor="black" height=""><a href="/item/iqQuestion?it_uid=${it.it_uid }&category2=${it.category2 }&mb_id=${it.mb_id}" style="color:white">문의하기</a></td>
      </tr>
   </table>
</center>

<%@include file="/include/footer.jsp" %>