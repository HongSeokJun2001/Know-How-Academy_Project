<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .counselor-list-table { width: 100%; border-collapse: collapse; }
    .counselor-list-table th { background-color: #F3F1FF; color: #4233C7; }
</style>
</head>
<body>
	<div class="page-title">상담사 목록 관리</div>
	
	<table class="counselor-list-table">
	    <thead>
	        <tr>
	            <th>제목1</th>
	            <th>제목2</th>
	            <th>제목3</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="counselor" items="${counselor}">
	            <tr>
	                <td>${counselor.~}</td>
	                <td>${counselor.~}</td>
	                <td>${counselor.~}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
</body>
</html>