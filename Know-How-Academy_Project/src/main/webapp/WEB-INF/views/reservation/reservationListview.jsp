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
        <h2 align="center">예약리스트</h2>
        <br>

        <table class="list-area table table-hover">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>상담일</th>
                    <th>상담사명</th>
                    <th>상담유형</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>

			    <c:choose>
			
			        <c:when test="${empty list}">
			            <tr>
			                <td colspan="5">조회된 예약이 없습니다.</td>
			            </tr>
			        </c:when>
			
			        <c:otherwise>
			
			            <c:forEach var="r" items="${list}">
			                <tr>
			                    <td>${r.reservationNo}</td>
			                    <td>${r.consultDate}</td>
			                    <td>${r.counselorName}</td>
			                    <td>${r.categoryName}</td>
			                    <td>
			                        <c:choose>
								        <c:when test="${r.reservationStatus eq 'APPLIED'}">상담신청</c:when>
								        <c:when test="${r.reservationStatus eq 'CANCELED'}">신청취소</c:when>
								        <c:when test="${r.reservationStatus eq 'RESERVED'}">예약됨 (상담수락)</c:when>
								        <c:when test="${r.reservationStatus eq 'COMPLETED'}">상담완료</c:when>
								        <c:otherwise>${r.reservationStatus}</c:otherwise>
								    </c:choose>
			                    </td>
			                </tr>
			            </c:forEach>
			
			        </c:otherwise>
			
			    </c:choose>

			</tbody>

        </table>

    </div>
</body>
</html>