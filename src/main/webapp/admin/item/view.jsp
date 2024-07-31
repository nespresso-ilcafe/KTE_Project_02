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
		}
	});
}
</script>
<style>
	.a {
		color:black;
	}
</style>
<center>
<table style="background-color: white">
	<tr>
		<td>
			<input type="button" value="뒤로가기" onclick="location.href = '/admin/item/list'">
		</td>
	</tr>
</table>
<form action="view" method="post" enctype="multipart/form-data">
<br>
<table width=1000 border=1>
	<tr>
		<td class="a" align=center width=300>상품코드</td>
		<td class="a"><input type="text" name="it_uid" value="${item.it_uid }"></td>
	</tr>
	<tr>
		<td class="a" align=center>카테고리</td>
		<td class="a">
			<select id="category1" name="category1" onchange="cate_2(this.value)">
				<option value="${item.category1 }">=대분류 선택=</option>
				<c:forEach var="c" items="${v }">
				<option value="${c.ca_id }">${c.ca_name }</option>
				</c:forEach>
			</select>
			<span id="category2_result">
				<select id="category2" name="category2">
					<option value="${item.category2 }">=대분류를 먼저 선택하세요=</option>
				</select>
			</span>
			<font color="red">
				<c:choose>
					<c:when test="${item.category1 ==10 }">글러브 - </c:when>
					<c:when test="${item.category1 ==20 }">배트 - </c:when>
					<c:when test="${item.category1 ==30 }">용품 - </c:when>
				</c:choose>
				${item.cate2_name }
			</font>
		</td>
	</tr>
	<tr>
		<td class="a" align=center>상품명</td>
		<td class="a"><input name="it_name" value="${item.it_name}"></td>
	</tr>
	<tr>
		<td class="a" align=center>아이디</td>
		<td class="a"><input name="mb_id" value="${item.mb_id}"></td>
	</tr>
	<tr>
		<td class="a" align=center>판매가격</td>
		<td class="a"><input name="it_price" id="it_price" oninput="a()" value="${item.it_price}"></td>
	</tr>
	<tr>
		<td class="a" align=center>세일 가격</td>
		<c:choose>
			<c:when test="${item.it_sale == null || item.it_sale eq '' }">
				<td class="a"><input id="it_sale" name="it_sale" oninput="a()" value="0"></td>
			</c:when>
			<c:otherwise>
				<td class="a"><input id="it_sale" name="it_sale" oninput="a()" value="${item.it_sale }"></td>
			</c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<td class="a" align=center>상품포인트</td>
		<td class="a"><input name="it_point" id="it_point" value="${item.it_point}"></td>
	</tr>
	<tr>
		<td class="a" align=center>상품수량</td>
		<td class="a"><input name="it_qty" value="${item.it_qty}"></td>
	</tr>
	<tr>
		<td class="a" align=center>판매가능</td>
		<td class="a">
			Y<input type="radio" value="Y" name="it_use" <c:if test="${item.it_use == 'Y' }">checked</c:if>>
			N<input type="radio" value="N" name="it_use" <c:if test="${item.it_use == 'N' }">checked</c:if>>
		</td>
	</tr>
	<tr>
		<td class="a" align=center>상품 이미지</td>
		<td class="a">
			<table style="background-color: white">
				<tr>
					<td>
						<table border=0 style="background-color: white;color:black">
							<tr height=26>
								<td>
								    <input type="file" name="file1">
								</td>
								<td align=center style="font-weight: bold">1</td>
								<td align=center style="font-weight: bold">2</td>
								<td align=center style="font-weight: bold">3</td>
								<td align=center style="font-weight: bold">4</td>
								<td align=center style="font-weight: bold">5</td>
							</tr>
							<tr>
								<td>
									<input type="file" name="file2">
								</td>
								<td rowspan=3 width=80>
									<c:choose>
										<c:when test="${item.file1 != ''}">
											<img src="/upload_item/${item.file1 }" width=80>
										</c:when>
										<c:otherwise>
											<div style="text-align: center;">
											    <span style="font-weight: bold; font-size: 30px;color:red">X</span>
											</div>
										</c:otherwise>
									</c:choose>
								</td>
								<td rowspan=3 width=80>
									<c:choose>
										<c:when test="${item.file2 != ''}">
											<img src="/upload_item/${item.file2 }" width=80>
										</c:when>
										<c:otherwise>
											<div style="text-align: center;">
											    <span style="font-weight: bold; font-size: 30px;color:red">X</span>
											</div>
										</c:otherwise>
									</c:choose>
								</td>
								<td rowspan=3 width=80>
									<c:choose>
										<c:when test="${item.file3 != ''}">
											<img src="/upload_item/${item.file3 }" width=80>
										</c:when>
										<c:otherwise>
											<div style="text-align: center;">
											    <span style="font-weight: bold; font-size: 30px;color:red">X</span>
											</div>
										</c:otherwise>
									</c:choose>
								</td>
								<td rowspan=3 width=80>
									<c:choose>
										<c:when test="${item.file4 != ''}">
											<img src="/upload_item/${item.file4 }" width=80>
										</c:when>
										<c:otherwise>
											<div style="text-align: center;">
											    <span style="font-weight: bold; font-size: 30px;color:red">X</span>
											</div>
										</c:otherwise>
									</c:choose>
								</td>
								<td rowspan=3 width=80>
									<c:choose>
										<c:when test="${item.file5 != ''}">
											<img src="/upload_item/${item.file5 }" width=80>
										</c:when>
										<c:otherwise>
											<div style="text-align: center;">
											    <span style="font-weight: bold; font-size: 30px;color:red">X</span>
											</div>
										</c:otherwise>
									</c:choose>
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
								<td class="a" style="border:0px">${item.file1 }</td>
								<td class="a" style="border:0px">${item.file2 }</td>
								<td class="a" style="border:0px">${item.file3 }</td>
								<td class="a" style="border:0px">${item.file4 }</td>
								<td class="a" style="border:0px">${item.file5 }</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table style="background-color: white">
	<tr>
		<td>
			<button>수정</button>
			<button><a href="/admin/item/list" style="color:black">취소</a></button>
		</td>
	</tr>
</table>
</form>
</center>

<%@ include file="/admin/include/footer.jsp" %>