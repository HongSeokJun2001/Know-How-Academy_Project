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

        <!--에약리스트 기능 구현-->
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
            		<c:when>
            			<tr>
            				<th colspan="5">
            					조회된 게시글이 없습니다.
            				</th>
            			</tr>
            		</c:when>
            	</c:choose>
            	<c:otherwise>
            		<c:forEach var="reservation" items="${ requestScope.list }">
            			<tr>
            				<td>${ reservation.reservationNo }</td> <!-- 번호 -->
            				<td>${ reservation.consultDate }</td> <!-- 상담일 -->
            				<td>${ reservation.counselNo }</td> <!-- 상담사번호 -->
            				<td>${ reservation.categoryNo }</td> <!-- 상담카테고리번호 -->
            				<td>${ reservation.reservationStatus } <!-- 예약상태 -->
            			</tr>
            		</c:forEach>
            	</c:otherwise>
            </tbody>
        </table>

    </div>
</body>
</html>