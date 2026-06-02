<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<div class="outer">
		<br>
		<h2 align="center">상담 신청 작성</h2>
		<br>
		
		<form id="enroll-form" action="/know-how/reservation/insert" method="post">
		    <table class="table">
		    	<tr>
		    		<th>상담일자</th>
		    		<td>
		    			<input type="date" name="consultDate" id="consultDate" class="form-control" style="width: 200px;" required>
		    		</td>
		    	</tr>
		    	<tr>
		    		<th>상담유형</th>
		    		<td>
		    			<select name="category">
		    				<c:forEach var="c" items="${ requestScope.list }">
		    					<option value="${ c.categoryNo }">${ c.categoryName }</option>
		    				</c:forEach>
		    			</select>
		    		</td>
		    	</tr>
		    	<tr>
		    		<th>상담사</th>
		    	</tr>
		    	<tr>
		    		<th>문의내용</th>
		    	</tr>
		    </table>
		</form>
	</div>
</body>
</html>