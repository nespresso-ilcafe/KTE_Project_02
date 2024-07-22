<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	span{
		cursor:pointer;
	}
	body {
        font-family: Arial, sans-serif;
        background-color: #000;
        color: #fff;
        margin: 0;
        padding: 0;
    }
    #a {
        border: 1px solid #fff;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #333;
    }
    td {
        background-color: #111;
    }
    a {
        color: #fff;
        text-decoration: none;
    }
    a:hover {
        color: #ccc;
    }
</style>
<c:if test="${sessionScope.level != 10}">
	<script>
		alert("관리자만 사용할 수 있습니다.");
		location.href="/";
	</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/admin/css/basic.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
</head>
<body>