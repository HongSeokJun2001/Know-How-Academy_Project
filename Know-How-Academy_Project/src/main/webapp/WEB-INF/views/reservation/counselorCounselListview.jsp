<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담 완료 내역</title>
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
		<h2 align="center" style="font-weight: bold;">상담 목록</h2>
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
					<%--Case1. 완료된 상담 목록이 비어있을 때 --%>
					<c:when test="${ empty list }">
						<tr>
							<td colspan="5">완료된 상담 내역이 없습니다.</td>
						</tr>
					</c:when>
					<%--Case2. 완료된 상담 목록이 존재할 떄 --%>
					<c:otherwise>
						<c:forEach var="r" items="${list}" varStatus="status">
							<tr class="data-row" data-rno="${ r.reservationNo }">
								<!-- 총 게시글 수 - ((현재페이지 - 1) * 페이징당 보여줄 개수) - 루프인덱스 수 -->
								<td>${ requestScope.pi.listCount - ((requestScope.pi.currentPage - 1) * requestScope.pi.reservationLimit) - status.index}</td>
								<td>${ r.consultDate }</td>
								<td>${ r.studentName }</td>
								<td>${ r.categoryName }</td>
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
				$(".list-area>tbody>tr.data-row").click(function() {
					// 클릭한 행에서 예약번호(rno) 추출 (.attr 활용)
					let rno = $(this).attr("data-rno");
					// 상담사 전용 상세 조회 페이지로 이동
					location.href = "${pageContext.request.contextPath}/reservation/counselorDetail/" + rno;
				});
			});
		</script>
		
		<div class="paging-area">
			<ul class="pagination justify-content-center">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq 1 }">
						<li class="page-item disabled">
							<a class="page-link">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${ pageContext.request.contextPath }/counselor/list?cpage=${requestScope.pi.currentPage - 1}">이전</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<!-- 페이지 번호 출력 -->
				<c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
					<c:choose>
						<c:when test="${ requestScope.pi.currentPage eq p }">
							<li class="page-item active">
								<a class="page-link">${ p }</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${ pageContext.request.contextPath }/counselor/list?cpage=${ p }">${ p }</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
						<li class="page-item disabled">
							<a class="page-link">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${ pageContext.request.contextPath }/counselor/list?cpage=${ requestScope.pi.currentPage + 1 }">다음</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp"/>

</body>
</html>