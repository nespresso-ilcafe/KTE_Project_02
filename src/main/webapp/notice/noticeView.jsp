<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<script>
   function a() {
      location.href = "noticemodify?uid=${n.uid}";
   }
      
   function b() {
      
    var tb_uid = document.getElementById("tb_uid").value;
    var tb_table = document.getElementById("tb_table").value;
    var tb_id = document.getElementById("tb_id").value;
    var tb_comment = document.getElementById("tb_comment").value;

    // AJAX 호출 전에 상태 변수 변경
    isRequestSent = true;

    $.ajax({
        url: "/notice/comment1", // 전송받을 페이지 경로
        type: "POST", // 데이터 전송 방식
        dataType: "text", // 서버 응답의 형식
        data: {
           tb_uid: tb_uid,
            tb_table: tb_table,
            tb_id: tb_id,
            tb_comment: tb_comment
        },
        error: function () { // 실패일 경우
            console.log("실패");
        },
        success: function (response) { // 성공일 경우
            console.log("성공");
            document.location.reload();
           
        },
        complete: function () { // 요청 완료 후
            // 요청 완료 후 상태 변수 다시 false로 설정
            isRequestSent = false;
        }
    });
    //var comment = document.getElementById("comment1").value;
   //location.href = "comment1?uid=${n.uid}&tb_table=notice&comment1="+comment;
}

   function c(uid){

       // AJAX 호출 전에 상태 변수 변경
       isRequestSent = true;

       $.ajax({
           url: "/notice/commentdelete", // 전송받을 페이지 경로
           type: "POST", // 데이터 전송 방식
           dataType: "text", // 서버 응답의 형식
           data: {
              uid : uid
           },
           error: function () { // 실패일 경우
               console.log("실패");
           },
           success: function (response) { // 성공일 경우
               console.log("성공");
               document.location.reload();
           },
           complete: function () { // 요청 완료 후
               // 요청 완료 후 상태 변수 다시 false로 설정
               isRequestSent = false;
           }
       });
   }
   function d() {
      location.href = "delete?uid=${n.uid }";
   }
</script>

<center>
   <br>
      <table width=1000 bgcolor="black">
         <tr>
            <td align="center" style="color:white;">제목</td>
         </tr>
         <tr>
            <td align="center" style="color:white;font-size:20px;">${n.subject }</td>
         </tr>
         <tr>
            <td align="center" colspan=2 style="color:white;font-size:12px;">${n.name }</td>
         </tr>
      </table>
      <table width=1000>
         <tr>
            <td height="200"></td>
            <td colspan=3 style="text-align:center;">${n.comment }</td>
            <td></td>
         </tr>
         <tr><td colspan="4" style="border-bottom:2px solid black;"></td></tr>
         <tr>
            <td style="text-align: center" width=100>댓글</td>
            <td colspan=2>
               <input style="width:90%" id="tb_comment">
               <input type="hidden" id="tb_uid" value="${n.uid }">
               <input type="hidden" id="tb_table" value="notice">
               <input type="hidden" name="tb_id" id="tb_id" value="${sessionScope.id }">
               <button type="button" onclick="b()">등록</button>
            </td>
         </tr>
         <tr><td colspan="4" style="border-bottom:1px solid black;"></td></tr>
         <tr>
            <td style="text-align: center;font-weight: bold">아이디</td>
            <td style="text-align: center;font-weight: bold">한줄 댓글</td>
            <td width=150 style="text-align: center;font-weight: bold">작성일자</td>
         </tr>
         <tr><td colspan="4" style="border-bottom:2px solid black;"></td></tr>
         <c:forEach var="m" items="${m }">
         <tr>
            <td style="text-align: center">${m.tb_id }</td>
            <td>${m.tb_comment }
               <c:if test="${sessionScope.level == 10 || m.tb_id eq sessionScope.id }">
                  <button onclick="c(${m.uid})">삭제</button>
               </c:if>
            </td>
            <td style="text-align: center" width=175>${m.tb_date }</td>
         </tr>
         <tr><td colspan="4" style="border-bottom:1px solid black;"></td></tr>
         </c:forEach>
      </table>
      <table width=1000>
         <tr>
            <c:if test="${sessionScope.id == n.id || sessionScope.level == 10}">
            <td colspan="2" style="text-align: right">
               <button type="button" onclick="a()">수정</button>
               <button type="button" onclick="d()">삭제</button>
            </td>
            </c:if>
         </tr>
      </table>
      <br>
</center>

<%@ include file="/include/footer.jsp" %>