<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담목록</title>
<style>
	.outer {
		width : 1000px;
		margin : auto;
		min-height: 600px; 
		padding-bottom: 50px; 
	}

	.list-area {
		margin : auto;
		width : 90% !important;
		text-align : center;
	}
	
	.list-area>tbody>tr.data-row:hover {
		cursor : pointer;
	}
	
	.list-area .badge {
		font-size : 13px;
		padding : 6px 12px;
		font-weight : bold;
		color: #ffffff !important;
		
		text-shadow: 
			-1.5px -1.5px 0 #000,  
			 1.5px -1.5px 0 #000,
			-1.5px  1.5px 0 #000,
			 1.5px  1.5px 0 #000,
			 0px    1.5px 0 #000,
			 0px   -1.5px 0 #000,
			 1.5px  0px   0 #000,
			-1.5px  0px   0 #000;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="outer">

        <br>
        <h2 align="center" style="font-weight: bold;">상담목록</h2>
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
			    	<%--Case 1: 조회된 상담 내역이 없을 떄 --%>
			        <c:when test="${empty list}">
			            <tr>
			                <td colspan="5">조회된 완료 상담이 없습니다.</td>
			            </tr>
			        </c:when>
			        <%--Case 2: 조회된 상담 내역이 존재할 때 --%>
			        <c:otherwise>
			            <c:forEach var="r" items="${list}" varStatus="status">
			                <tr class="data-row" data-rno="${ r.reservationNo }">
			                	<td>${requestScope.pi.listCount - ((requestScope.pi.currentPage - 1) * requestScope.pi.reservationLimit) - status.index}</td>
			                    
			                    <td class="consult-date-cell">${r.consultDate}</td>
			                    
			                    <td>${r.counselorName}</td>
			                    <td>${r.categoryName}</td>
			                    <td>
									<span class="badge bg-primary">상담완료</span>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
        
        <script>
        	$(function() {
        		// 1. 행 클릭 시 상세조회 이동 로직
        		$(".list-area>tbody>tr.data-row").click(function() {
        			let rno = $(this).attr("data-rno");
        			location.href = "${pageContext.request.contextPath}/reservation/detail/" + rno;
        		});
        		
        		// 💡 2. 완료 상담일자 포맷을 '오전/오후' 형식으로 일괄 치환하는 로직 추가
        		$(".consult-date-cell").each(function() {
        			let rawDateStr = $(this).text().trim();
        			
        			if(rawDateStr) {
        				let parts = rawDateStr.split(" ");
        				if(parts.length === 2) {
        					let datePart = parts[0]; // "2026-06-12"
        					let timePart = parts[1]; // "15:30"
        					
        					let timeParts = timePart.split(":");
        					let hour = parseInt(timeParts[0], 10);
        					let minute = timeParts[1];
        					
        					// 오전, 오후 판별 및 12시간제 변환
        					let ampm = hour >= 12 ? "오후" : "오전";
        					
        					if (hour > 12) {
        						hour = hour - 12;
        					} else if (hour === 0) {
        						hour = 12;
        					}
        					
        					// 시간 값이 한 자리일 경우 가독성을 위해 앞에 '0' 패딩 처리
        					let formattedHour = hour < 10 ? "0" + hour : hour;
        					
        					// 예쁘게 조합된 최종 날짜 세팅 (예: 2026-06-12 오후 03:30)
        					let finalDateStr = datePart + " " + ampm + " " + formattedHour + ":" + minute;
        					
        					$(this).text(finalDateStr);
        				}
        			}
        		});
        	});
        </script>
        
        <div class="paging-area">
        	<ul class="pagination justify-content-center">
        		<c:choose>
        			<c:when test="${ requestScope.pi.currentPage eq 1 }">
        				<li class="page-item disabled">
        					<a class="page-link">이전</a>
        				</li>
        			</c:when>
        			<c:otherwise>
	        			<li class="page-item">
	        				<a class="page-link" href="/know-how/reservation/counselor/list?cpage=${ requestScope.pi.currentPage - 1 }">이전</a>
	        			</li>
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
	        				<li class="page-item">
	        					<a class="page-link" href="/know-how/reservation/counselor/list?cpage=${ p }">${ p }</a>
	        				</li>
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
		        					<a class="page-link" href="/know-how/reservation/counselor/list?cpage=${ requestScope.pi.currentPage + 1 }">다음</a>
		        				</li>
        					</c:when>
        				</c:choose>
        			</c:otherwise>
        		</c:choose>
        	</ul>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>

</body>
</html>