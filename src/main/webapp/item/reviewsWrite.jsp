<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/include/header.jsp" %>
<style>
	#back{
		border:none;
		background-color:black;
		color:white;
	}
	#back:hover{
		color:red;
	}
	#write{
		border:none;
		background-color:white;
	}
	#write:hover{
		color:red;
	}
</style>
<input type="hidden" id="it_uid" value="${re.it_uid}">
<input type="hidden" id="category2" value="${ca.ca_id}">

<center>
    <table width="500" bgcolor="black">
        <tr>
            <td align="left" width="100">
            	<input type="button" id="back" value="뒤로가기" onclick="backToThe()">
            </td>
            <td align="center" style="color:white;height:40px;">리뷰작성</td>
            <td width="100"></td>
        </tr>
    </table>
    <form method="post" enctype="multipart/form-data">
        <table width="500">
            <tr>
                <td width="75">제목</td>
                <td><input name="rv_sub" style="width:325px;" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <textarea rows="14" cols="59" name="rv_text" placeholder="리뷰를 남겨주세요!" id="myTextarea" maxlength="1000" required></textarea>
                </td>
            </tr>
            <tr><td colspan="2" style="border-bottom:1px solid black"></td></tr>
            <tr>
            	<td>
            		<select name="rating">
            			<option value="1">★</option>
            			<option value="2">★★</option>
            			<option value="3">★★★</option>
            			<option value="4">★★★★</option>
            			<option value="5">★★★★★</option>
            		</select>
            	</td>
            </tr>
            <tr><td colspan="2" style="border-bottom:2px solid black"></td></tr>
            <tr>
                <td>첨부파일1</td>
                <td><input type="file" name="file1"></td>
            </tr>
            <tr>
                <td>첨부파일2</td>
                <td><input type="file" name="file2"></td>
            </tr>
            <tr>
                <td>첨부파일3</td>
                <td><input type="file" name="file3"></td>
            </tr>
            <tr><td colspan="2" style="border-bottom:1px solid black"></td></tr>
            <tr>
                <td colspan="2" align="center">
                	<button id="write">작성 완료</button>
                </td>
            </tr>
            <tr><td colspan="2" style="border-bottom:2px solid black"></td></tr>
        </table>
    </form>
</center>

<%@include file="/include/footer.jsp" %>

<script>
    function backToThe() {
        var it_uid = document.getElementById("it_uid").value;
        var category2 = document.getElementById("category2").value;
        var url = "http://localhost:8080/item/view?it_uid=" + it_uid + "&category2=" + category2;
        location.href = url;
    }
</script>
