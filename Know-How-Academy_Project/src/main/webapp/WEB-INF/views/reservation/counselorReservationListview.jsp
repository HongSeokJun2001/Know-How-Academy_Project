<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담예약 접수 현황</title>
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
	
	<c:choose>
		<%--
			로그인 유저의 권한별로 페이징 주소 동적 분기 처리
			- 관리자/강사 : 전체 예약 리스트 조회
			- 상담사 : 본인에게 배정된 예약 리스트 조회 
		--%>
		<c:when test="${sessionScope.loginUser.roleCode eq 'ADMIN' or sessionScope.loginUser.roleCode eq 'INSTRUCTOR'}">
			<c:set var="pageUrl" value="list" />
		</c:when>
		<c:otherwise>
			<c:set var="pageUrl" value="counselorReservationList" />
		</c:otherwise>
	</c:choose>
	
	<div class="outer">
		<br>
		<h2 align="center">상담예약 접수 현황</h2>
		<br>
		
		<table class="list-area table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>상담일</th>
					<th>학생명</th>
					<th>상담유형</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				<%--Case1. 신청 혹은 배정된 상담 예약 내역이 비어있을 때 --%>
					<c:when test="${ empty list }">
						<tr>
							<td colspan="5">신청된 상담 예약이 없습니다.</td>
						</tr>
					</c:when>
					<%--Case2. 상담 예약 내역이 존재할 떄 --%>
					<c:otherwise>
						<c:forEach var="r" items="${list}" varStatus="status">
							<tr class="data-row" data-rno="${ r.reservationNo }">
								<td>${ requestScope.pi.listCount - ((requestScope.pi.currentPage - 1) * requestScope.pi.reservationLimit) - status.index}</td>
								
								<td class="consult-date-cell">${ r.consultDate }</td>
								
								<td>${ r.studentName }</td>
								<td>${ r.categoryName }</td>
								<td>
									<c:choose>
										<c:when test="${ r.reservationStatus eq 'APPLIED' }">
											<span class="badge bg-warning text-dark">예약대기</span>
										</c:when>
										<c:when test="${ r.reservationStatus eq 'CANCELED' }">
											<span class="badge bg-danger">예약취소</span>
										</c:when>
										<c:when test="${ r.reservationStatus eq 'RESERVED' }">
											<span class="badge bg-success">예약완료</span>
										</c:when>
										<c:when test="${ r.reservationStatus eq 'COMPLETED' }">
											<span class="badge bg-primary">상담완료</span>
										</c:when>
										<c:when test="${ r.reservationStatus eq 'REJECTED' }">
											<span class="badge bg-danger">상담반려</span>
										</c:when>
										<c:otherwise>${ r.reservationStatus }</c:otherwise>
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
				// 1. 행 클릭 시 상세 페이지 이동 로직
				$(".list-area>tbody>tr.data-row").click(function() {
					let rno = $(this).attr("data-rno");
					location.href = "${pageContext.request.contextPath}/reservation/counselorDetail/" + rno;
				});
				
				// 💡 2. 접수 현황 리스트 날짜를 '오전/오후' 형식으로 실시간 치환
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
							
							// 시(Hour) 단위가 한 자리일 경우 앞에 '0' 붙이기
							let formattedHour = hour < 10 ? "0" + hour : hour;
							
							// 최정 결과 조립 (예: 2026-06-12 오후 03:30)
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
					<%--이전 버튼 --%>
					<c:when test="${ requestScope.pi.currentPage eq 1 }">
						<li class="page-item disabled">
							<a class="page-link">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${ pageContext.request.contextPath }/reservation/${pageUrl}?cpage=${requestScope.pi.currentPage - 1}">이전</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<%--페이지 버튼 --%>
				<c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
					<c:choose>
						<c:when test="${ requestScope.pi.currentPage eq p }">
							<li class="page-item active">
								<a class="page-link">${ p }</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${ pageContext.request.contextPath }/reservation/${pageUrl}?cpage=${ p }">${ p }</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<%-- 다음 버튼 --%>
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
						<li class="page-item disabled">
							<a class="page-link">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${ pageContext.request.contextPath }/reservation/${pageUrl}?cpage=${ requestScope.pi.currentPage + 1 }">다음</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp"/>

</body>
</html>