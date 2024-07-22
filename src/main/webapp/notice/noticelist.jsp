<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<center>
	<br>
    <span style="font-weight: bold;font-size:17px" class="poetsen-one-regular">Total : ${count }</span>
    <br><br>
    <table width=1000 border=0 style="font-size:13px;text-align:center">
    	<tr><td colspan=4 align=left style="font-size:18px;font-weight: bold">NOTICE</td></tr>
        <tr><td colspan=10 height=1 bgcolor="black"></td></tr>
        <tr>
            <td width=100 height=30>NO</td>
            <td width=650>제목</td>
            <td width=100>글쓴이</td>
            <td width=150>날짜</td>
        </tr>
        <tr><td colspan=10 height=1 bgcolor="#EAEAEA"></td></tr>
        <c:set var="number" value="${number}"/>
        <c:forEach var="list" items="${m }">
            <tr>
                <td align=center height=30>${number }</td>
                <td align=left><a href="noticeview?uid=${list.uid }">${list.subject }</a></td>
                <td align=center>${list.name }</td>
                <td align=center>${list.signdate }</td>
            </tr>
            <tr><td colspan=10 height=1 bgcolor="#EAEAEA"></td></tr>
            <c:set var="number" value="${number-1 }" />
        </c:forEach>
    </table>
    <!--페이징-->
    <table width=1000 border=0 style="text-align: center">
        <tr>
            <td>
                <c:if test="${count>0 }">
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
                        <a href="list?pageNum=${startPage-pageBlock }&field=${field}&search=${search}">[이전]</a>
                    </c:if>
                    <c:forEach var="i" begin="${startPage }" end="${endPage }">
                        <c:choose>
                            <c:when test="${pageNum == i }">
                                <a href="list?pageNum=${i }&field=${field}&search=${search}"><font color=red>${i }</font></a>
                            </c:when>
                            <c:otherwise>
                                <a href="list?pageNum=${i }&field=${field}&search=${search}">${i }</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${endPage < pageCount}">
                        <a href="list?pageNum=${startPage+pageBlock }&field=${field}&search=${search}">[다음]</a>
                    </c:if>
                </c:if>
            </td>
            <c:choose>
                <c:when test="${sessionScope.id == null }"></c:when>
                <c:otherwise><td width=100 align=right><a href="write">[게시물등록]</a></td></c:otherwise>
            </c:choose>
        </tr>
    </table>
</center>

<%@ include file="/include/footer.jsp" %>