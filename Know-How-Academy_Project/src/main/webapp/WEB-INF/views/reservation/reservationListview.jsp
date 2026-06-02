<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.list-area {
		margin : auto;
		width : 90% !important;
		text-align : center;
	}
	
	.list-area>tbody>tr:hover {
		cursor : pointer;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="outer">

        <br>
        <h2 align="center">예약리스트</h2>
        <br>


		<!-- 로그인한 회원만 보여지는 상담 신청 버튼 -->
		<c:if test="${ not empty sessionScope.loginUser }">
			<div style="width:90%; margin : auto; text-align : right; margin-bottom : 10px;">
				<a href="/know-how/reservation/reservationEnrollForm" class="btn btn-success">상담 신청</a>
			</div>
		</c:if>
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
        
        <script>
        	$(function() {
        		$(".list-area>tbody>tr").click(function() {
        			let rno = $(this).children().eq(0).text();
        			location.href = "/know-how/reservation/detail/" + rno;
        		});
        	});
        </script>
        
        <!-- 페이징 바 영역 -->
        <div class="paging-area">
        	<ul class="pagination justify-content-center">
        		
        		<c:choose>
        			<c:when test="${ requestScope.pi.currentPage eq 1 }">
        				<!-- 1번 페이지일 경우 -->
        				<li class="page-item disabled">
        					<a class="page-link">이전</a>
        				</li>
        			</c:when>
        			<c:otherwise>
        				<c:choose>
        					<c:when test="${ empty requestScope.condition }">
	        					<li class="page-item">
	        						<a class="page-link" href="/know-how/reservation/list?cpage=${ requestScope.pi.currentPage - 1 }">이전</a>
	        					</li>
        					</c:when>
        				</c:choose>      				        				
        			</c:otherwise>
        		</c:choose>
        		
        		<c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
	        		<c:choose>
	        			<c:when test="${ requestScope.pi.currentPage eq p }">
	        				<li class="page-item active">
	        					<a class="page-link">${ p }</a>
	        				</li>
	        			</c:when>
	        			<c:otherwise>
	        				<c:choose>
	        					<c:when test="${ empty requestScope.condition }">
	        						<li class="page-item">
	        							<a class="page-link" href="/know-how/reservation/list?cpage=${ p }">${ p }</a>
	        						</li>
	        					</c:when>
	        				</c:choose>
	        			</c:otherwise>
	        		</c:choose>       			
        		</c:forEach>
        		
        		<c:choose>
        			<c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
        				<li class="page-item disabled">
        					<a class="page-link">다음</a>
        				</li>
        			</c:when>
        			<c:otherwise>
        				<c:choose>
        					<c:when test="${ empty requestScope.condition }">
        						<li class="page-item">
        							<a class="page-link" href="/know-how/reservation/list?cpage=${ requestScope.pi.currentPage + 1 }">다음</a>
        						</li>
        					</c:when>
        				</c:choose>
        			</c:otherwise>
        		</c:choose>
        		
        	</ul>
        </div>
        

    </div>
</body>
</html>