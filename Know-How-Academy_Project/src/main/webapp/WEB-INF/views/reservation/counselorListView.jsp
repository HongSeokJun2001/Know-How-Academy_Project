<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 리스트</title>
<style>

	.outer {
		width : 1000px;
		margin : auto;
		margin-top : 50px;
		border : 1px solid #ccc;
		padding : 40px;
	}
	
	.list-title {
		text-align: center;
		font-weight: bold;
	}
	
	.list-area {
		margin : auto;
		width : 100% !important;
		text-align : center;
	}
	
	.col-category { width: 15%; }
	.col-name     { width: 20%; }
	.col-phone    { width: 25%; }
	.col-email    { width: 25%; }
	.col-btn      { width: 15%; }
	
	.counselor-name {
		font-weight: bold;
	}
	
	.empty-cell {
		padding: 50px 0;
		color: #666;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="outer">
        <br>
        <h2 class="list-title">직원 리스트</h2>
        <br>

        <table class="list-area table table-hover">
            <thead>
                <tr>
                    <th class="col-category">카테고리</th>
                    <th class="col-name">이름</th>
                    <th class="col-phone">연락처</th>
                    <th class="col-email">이메일</th>
                    <th class="col-btn">상담신청</th>
                </tr>
            </thead>
            <tbody>
			    <c:choose>
			    	<%--Case1. 조회된 상담사가 아무도 없을 때 --%>
			        <c:when test="${empty counselorList}">
			            <tr>
			                <td colspan="5" class="empty-cell">현재 재직중인 상담사가 없습니다.</td>
			            </tr>
			        </c:when>
			        <%--Case. 재직 중인 상담사가 존재할 떄 --%>
			        <c:otherwise>
			            <c:forEach var="c" items="${counselorList}">
			                <tr>
			                    <td>${c.categoryName}</td>
			                    <td class="counselor-name">${c.counselorName}</td>
			                    <td>${c.phone}</td>
			                    <td>${c.email}</td>
			                    <td>
			                    	<!-- 클릭 시 counselNo를 쿼리스트링에 실어서 신청서 작성 폼으로 이동 -->
			                    	<a href="${pageContext.request.contextPath}/reservation/reservationEnrollForm?counselNo=${c.counselNo}" class="btn btn-success btn-sm">신청</a>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
        
        <br>
    </div>
</body>
</html>