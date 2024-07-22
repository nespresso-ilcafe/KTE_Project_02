<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<select id="category2" name="category2" required>
	<option value="">=중분류 선택=</option>
	<c:forEach var="c" items="${v }">
	<option value="${c.ca_id}">${c.ca_name}</option>
	</c:forEach>
</select>