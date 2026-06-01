<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 소식</title>
<style>
	.detail-area {
		margin : auto;
		width : 90% !important;
	}
	.detail-area th {
		background-color : lightgray;
		text-align: center;
		vertical-align: middle !important;
	}
	.detail-area>tr:first-child {
		border-top : 1px solid black !important;
	}
	.detail-area>tr:last-child {
		border-bottom : 1px solid black !important;
	}
</style>
</head>
<body>
	<jsp:include page="menubar.jsp"/>
	
	<div class="outer">
		<br>
		<h2 align="center">학원 소식</h2>
		<br>
		
		<table class="detail-area table">
			<tr>
				<th>제목</th>
				<td colspan="3">
					학원소식제목입니다.
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>2026-05-29</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<p style="height : 300px;">
						취업률 90% 유지하고 있습니다.
					</p>
				</td>
			</tr>
			<tr>
				<th>대표이미지</th>
				<td colspan="3" align="center">
					<img src="/know-how/resources/image/academynews1.png" alt="학원소식이미지1"
						 width="500" height="300">
				</td>
			</tr>
			<tr>
				<th>상세이미지</th>
				<td colspan="3" align="center">
					<%--<c:choose>
						<c:when test="${ requestScope.list.size() eq 1 }">
							상세이미지가 존재하지 않습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="1" end="${ requestScope.list.size() - 1 }" step="1">--%>
							
								<img src="/know-how/resources/image/academynews2.png" alt="학원소식이미지2"
									 width="200" height="160">
								<img src="/know-how/resources/image/academynews3.png" alt="학원소식이미지3"
									 width="200" height="160">
								<img src="/know-how/resources/image/academynews4.png" alt="학원소식이미지4"
									 width="200" height="160">
							
							<%--</c:forEach>
						</c:otherwise>
					</c:choose>--%>
				</td>
			</tr>
		</table>
		
		<br><br>
		
	</div>
	
	<br><br>
	
	<jsp:include page="footer.jsp" />
</body>
</html>