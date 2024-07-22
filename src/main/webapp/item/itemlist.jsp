<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>
<style>
	#itemall{
		width:100px;
		height:40px;
		background-color:black;
	}
</style>
<center>
    <table width="900">
    	<tr>
    		<c:choose>
    			<c:when test="${cate1 != null && cate1 != '' }">
    				<td align=center colspan=5 id="itemall"><a href="list?category1=${cate1}" style="color:white;font-size:20px;">전체상품보기</a></td>
    			</c:when>
    			<c:otherwise>
    				<td align=center colspan=5 id="itemall"><a href="mainsearch?search=${search }" style="color:white;font-size:20px;">전체상품보기</a></td>
    			</c:otherwise>
    		</c:choose>
    	</tr>
    	<tr height="5"></tr>
        <tr>
        	<c:forEach var="ca" items="${ca }" varStatus="loop">
        	<c:set var="i" value="${fn:substring(ca.ca_id,0,2) }"/>
        		<c:choose>
		            <c:when test="${loop.count % 5 == 1 && loop.count != 1}">
		            	<c:choose>
			                <c:when test="${fn:length(ca.ca_id) == 4 && i == cate1}">
		            			<td align=center width=175 style="border-right: 1px solid black; border-left: 1px solid black;">
		            				<a href="list2?category1=${i}&category2=${ca.ca_id}">${ca.ca_name }</a>
		            			</td>
		            		</c:when>
	            		</c:choose>
		            </c:when>
		            <c:otherwise>
		            	<c:choose>
			            	<c:when test="${fn:length(ca.ca_id) == 4 && i == cate1}">
		            			<td align=center width=175 style="border-right: 1px solid black; border-left: 1px solid black;">
		            				<a href="list2?category1=${i}&category2=${ca.ca_id}">${ca.ca_name }</a>
		            			</td>
		            		</c:when>
	            		</c:choose>
		            </c:otherwise>
		        </c:choose>
            </c:forEach>
        </tr>
    </table>
</center>
<br>
<center>
    <c:if test="${count != 0 }">
        <table width="900" height="35" bgcolor="black">
            <tr>
                <td width="900" style="color:white;">구매 가능 상품 : ${count }</td>
            </tr>
        </table>
    </c:if>
    <!-- 등록된 상품이 없을 때 -->
        <c:if test="${count == 0 }">
    		<table width="900">
	            <tr>
	                <td align="center" height="300"><font>현재 등록된 상품이 없습니다.</font></td>
	            </tr>
            </table>
        </c:if>
        <!-- 물품 목록 반복문 시작 -->
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />
        <table style="border-bottom:1px solid black;">
            <c:forEach var="it" items="${v}">
            	<input type="hidden" value="${it.category2 }">
                <c:if test="${it.category1 eq cate1}">
                    <c:if test="${i % j == 0}">
                        <tr>
                    </c:if>
                    <td valign="top" align="center" height="300">
                        <table width=200>
                            <tr>
                                <td>
                                <c:choose>
                                	<c:when test="${cate2 != null && cate2 != '' }">
                                		<a href="/item/view?it_uid=${it.it_uid }&category1=${it.category1 }&category2=${it.category2 }">
                            		</c:when>
                            		<c:otherwise>
                            			<a href="/item/view?it_uid=${it.it_uid }&category1=${it.category1 }">
                            		</c:otherwise>
                            	</c:choose>
	                            <c:choose>
		                		<c:when test="${it.it_qty == 0 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/soldout.png" style="position: absolute; top: -10%; left: -25%; width: 90%;">
									</div>
		                    	</c:when>
		                    	<c:when test="${it.it_qty <= 10 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/almostsoldout.png" style="position: absolute; top: -8%; left: -14%; width: 50%;">
									</div>
		                    	</c:when>
		                    	<c:when test="${it.it_sale != 0 }">
			                		<div style="position: relative;">
									    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
									    <img src="/img/sale.png" style="position: absolute; top: -5%; left: -5%; width: 25%;">
									</div>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
		                    	</c:otherwise>
		                    </c:choose>
                            	</a>
                        		</td>
                            </tr>
                            <tr>
		                        <td style="font-weight: bold;">
		                            <a href="/item/view?it_uid=${it.it_uid }&category2=${it.category2 }">${it.it_name }</a>
		                        </td>
                            </tr>
                            <tr>
                                <td>
		                            <c:choose>
		                                <c:when test="${it.it_sale ne 0 }">
		                                    <font style="color: gray; font-size:14px;"><fmt:formatNumber value="${it.it_price }" />원</font>
		                                    <br>
		                                    <font style="color: #FE642E; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_sale }" />원</font>
		                                </c:when>
		                                <c:otherwise>
		                                    <font style="color: black; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_price }" />원</font>
		                                </c:otherwise>
		                            </c:choose>
                                </td>
                            </tr>
                            <tr>
                            	<c:choose>
                            		<c:when test="${it.avg_rating > 0.0}">
                            			<td align="left">
                            				<img src="/img/rating.png" style="width:12px; margin-right:2px;">
                            				<fmt:formatNumber value="${it.avg_rating }" pattern="#.0"/>
                           				</td>
                            		</c:when>
                            		<c:otherwise>
                            			<td align="left">
                           					<img src="/img/rating.png" style="width:12px; margin-right:2px;">0.0
                            			</td>
                            		</c:otherwise>
                            	</c:choose>
                            </tr>
                        </table>
                    </td>
                    <c:if test="${i % j == j - 1}">
                        </tr>
                    </c:if>
                    <c:set var="i" value="${i + 1}" />
                </c:if>
            </c:forEach>
        </table>
        <!-- 물품 목록 반복문 끝 -->
        
        <!-- 검색 목록 반복문 시작 -->
        <c:set var="i" value="0" />
        <c:set var="j" value="4" />
        <table style="border-bottom:1px solid black;">
            <c:forEach var="it" items="${v1}">
                <c:if test="${i % j == 0}">
                    <tr>
                    </c:if>
                    <td valign="top" align="center" height="300">
                        <table>
                            <tr>
                                <td>
                            	<a href="/item/view?it_uid=${it.it_uid }&pageNum=${pageNum }&search=${search }">
                            	<c:choose>
			                		<c:when test="${it.it_qty == 0 }">
				                		<div style="position: relative;">
										    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
										    <img src="/img/pngwing.com.png" style="position: absolute; top: 20%; left: 0; width: 100%;">
										</div>
			                    	</c:when>
			                    	<c:when test="${it.it_qty <= 3 }">
				                		<div style="position: relative;">
										    <img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
										    <img src="/img/1.png" style="position: absolute; top: -10%; left: 0; width: 50%;">
										</div>
			                    	</c:when>
			                    	<c:otherwise>
			                    		<img src="/upload_item/${it.file1_thumb }" style="vertical-align:top; width:220px; height:220px;">
			                    	</c:otherwise>
			                    </c:choose>
                            </a>
                        </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;width:220px;">
                                    <a href="/item/view?category1=${it.category1}&category2=${it.category2}&it_uid=${it.it_uid}">${it.it_name}</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                	<c:choose>
		                                <c:when test="${it.it_sale ne 0 }">
		                                    <font style="color: gray; font-size:14px;"><fmt:formatNumber value="${it.it_price }" />원</font>
		                                    <br>
		                                    <font style="color: #FE642E; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_sale }" />원</font>
		                                </c:when>
		                                <c:otherwise>
		                                    <font style="color: black; font-size:14px; font-weight:bold;"><fmt:formatNumber value="${it.it_price }" />원</font>
		                                </c:otherwise>
		                            </c:choose>
                                </td>
                            </tr>
                            <tr>
                            	<c:choose>
                            		<c:when test="${it.avg_rating > 0.0}">
                            			<td align="right"><fmt:formatNumber value="${it.avg_rating }" pattern="#.0"/></td>
                            		</c:when>
                            		<c:otherwise>
                            			<td align="right">0</td>
                            		</c:otherwise>
                            	</c:choose>
                            </tr>
                        </table>
                    </td>
                    <c:if test="${i % j == j - 1}">
                        </tr>
                    </c:if>
                    <c:set var="i" value="${i + 1}" />
            </c:forEach>
        </table>
        <!-- 검색 목록 반복문 끝 -->
        <!-- 페이징 -->
        <table>
            <tr>
                <td align=center>
                    <c:if test="${count > 0 }">
                        <fmt:parseNumber var="pageCount" value="${count/pageSize+(count%pageSize==0?0:1)}" integerOnly="true" />
                        <c:set var="startPage" value="${1 }" />
                        <c:set var="pageBlock" value="${10 }" />
                        <c:if test="${pageNum>pageBlock }">
                            <fmt:parseNumber var="startPage" value="${(pageNum/pageBlock-(pageNum%pageBlock==0?1:0))*pageBlock+1 }" integerOnly="true" />
                        </c:if>
                        <fmt:parseNumber var="endPage" value="${startPage+pageBlock-1 }" integerOnly="true" />
                        <c:if test="${endPage>pageCount }">
                            <c:set var="endPage" value="${pageCount }" />
                        </c:if>
                        <c:if test="${startPage>pageBlock }">
                        	<c:choose>
							    <c:when test="${cate2 !='' && cate2 != null}">
							    	<a href="list2?category1=${cate1}&category2=${cate2}&pageNum=${startPage-pageBlock}&field=${field}&search=${search}">[이전]</a>
							    </c:when>
							    <c:when test="${cate1 !='' && cate1 != null}">
							    	<a href="list?category1=${cate1}&pageNum=${startPage-pageBlock}&field=${field}&search=${search}">[이전]</a>
							    </c:when>
							    <c:otherwise>
							    	<a href="mainsearch?category1=${cate1}&pageNum=${startPage-pageBlock}&field=${field}&search=${search}">[이전]</a>
							    </c:otherwise>
							</c:choose>
                        </c:if>
                        <c:forEach var="i" begin="${startPage }" end="${endPage }">
                            <c:choose>
                                <c:when test="${pageNum == i }">
                                    <c:choose>
									    <c:when test="${cate2 !='' && cate2 != null}">
									    	<a href="list2?category1=${cate1}&category2=${cate2}&pageNum=${i}&field=${field}&search=${search}"><font style="color:black;font-size:18px;font-weight:bold;">${i }</font></a>
									    </c:when>
									    <c:when test="${cate1 !='' && cate1 != null}">
									        <a href="list?category1=${cate1}&pageNum=${i}&field=${field}&search=${search}"><font style="color:black;font-size:18px;font-weight:bold;">${i }</font></a>
									    </c:when>
									    <c:otherwise>
									    	<a href="mainsearch?pageNum=${i}&search=${search}"><font style="color:black;font-size:18px;font-weight:bold;">${i }</font></a>
									    </c:otherwise>
									</c:choose>
                                </c:when>
                                <c:otherwise>
                                	<c:choose>
									    <c:when test="${cate2 !='' && cate2 != null}">
									    	<a href="list2?category1=${cate1}&category2=${cate2}&pageNum=${i}&field=${field}&search=${search}">${i }</a>
									    </c:when>
									    <c:when test="${cate1 !='' && cate1 != null}">
									        <a href="list?category1=${cate1}&pageNum=${i}&field=${field}&search=${search}">${i }</a>
									    </c:when>
									    <c:otherwise>
									    	<a href="mainsearch?pageNum=${i}&search=${search}">${i }</a>
									    </c:otherwise>
									</c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    <c:if test="${endPage < pageCount}">
                    <c:choose>
					    <c:when test="${cate2 !='' && cate2 != null}">
					    	<a href="list2?category1=${cate1}&category2=${cate2}&pageNum=${startPage+pageBlock}&field=${field}&search=${search}">[다음]</a>
					    </c:when>
					    <c:when test="${cate1 !='' && cate1 != null}">
					    	<a href="list?category1=${cate1}&pageNum=${startPage+pageBlock}&field=${field}&search=${search}">[다음]</a>
					    </c:when>
					    <c:otherwise>
					    	<a href="mainsearch?pageNum=${startPage+pageBlock}&search=${search}">[다음]</a>
					    </c:otherwise>
					</c:choose>
                    </c:if>
                </c:if>
            </td>
        </tr>
    </table>
    <br>
</center>

<%@include file="/include/footer.jsp"%>

<script>
</script>
