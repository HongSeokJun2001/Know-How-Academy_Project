<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담신청 상세조회</title>
<style>

	.outer {
		width : 1000px;
		margin : auto;
		padding : 30px;
		border : 1px solid #ccc;
		margin-top : 50px;
		min-height: 600px;
		padding-bottom: 50px;
	}
	

	.form-header {
		display : flex;
		justify-content : space-between;
		align-items : center;
		width : 90%;
		margin : auto;
		margin-bottom : 20px;
	}
	
	.action-btn-group {
		display: flex;
		gap: 10px;
		margin-left: auto;
	}
	.btn-custom {
		border: 1px solid #333;
		padding: 6px 22px;
		font-weight: bold;
		cursor: pointer;
		font-size: 15px;
		text-decoration: none;
		text-align: center;
		border-radius: 4px;
	}
	.btn-modify {
		background-color: #ffff00;
		color: #000;
	}
	.btn-delete {
		background-color: #ff0000;
		color: #fff;
	}
	.btn-list {
		background-color : #6c757d;
		color : #fff;
		border: 1px solid #5a6268;
	}
	.btn-modify:hover { background-color: #e6e600; color: #000; }
	.btn-delete:hover { background-color: #cc0000; color: #fff; }
	.btn-list:hover {background-color : #5a6268; color : #fff; }


	#detail-table {
		margin : auto;
		width : 90%;
		border-collapse: collapse;
	}
	#detail-table th {
		background-color : #e9ecef;
		text-align : center;
		vertical-align : middle;
		width : 15%;
		font-weight: bold;
	}
	#detail-table td {
		vertical-align : middle;
		padding: 12px;
	}
	
	.data-text {
		font-size: 16px;
		color: #333;
		padding-left: 5px;
	}
    .textarea-box {
		width: 100%;
		height: 200px;
		border: 1px solid #dee2e6;
		background-color: #fff;
		padding: 10px;
		white-space: pre-wrap;
		overflow-y: auto;
	}
	
	#detail-table .badge {
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
		<div class="form-header">
			<h2 style="margin: 0; font-weight: bold;">상담신청</h2>
			
			<div class="action-btn-group">
				<%--
					학생 본인 검증 및 상태 제어
					- 로그인 상태여야 함 (not empty loginUser)
					- 로그인한 유저의 이름과 신청서의 학생명이 일치해야 함 (userName eq r.studentName)
					- 상담이 이미 최종 '완료'된 상태가 아니어야 함 (r.reservationStatus ne 'COMPLETED')
				 --%>
				<c:if test="${ (not empty sessionScope.loginUser) and (sessionScope.loginUser.userName eq r.studentName) and (r.reservationStatus ne 'COMPLETED') }">
					<a class="btn-custom btn-modify" onclick="postFormSubmit(1);">수정</a>
					<a class="btn-custom btn-delete" onclick="postFormSubmit(2);">삭제</a>
				</c:if>
				<a class="btn-custom btn-list" onclick="history.back();">목록으로</a>
			</div>
			
			<%-- 버튼 노출 조건과 동일한 권한 체크 --%>
			<c:if test="${ (not empty sessionScope.loginUser) and (sessionScope.loginUser.userName eq r.studentName) and (r.reservationStatus ne 'COMPLETED') }">
				<form id="postForm" action="" method="post">
					<input type="hidden" name="rno" value="${ r.reservationNo }">
				</form>
				
				<script>
					function postFormSubmit(num) {
						if(num == 1) {
							$("#postForm").prop("action", "${pageContext.request.contextPath}/reservation/updateForm").submit();
						} else {
							if(confirm("정말 이 상담 예약을 취소(삭제)하시겠습니까?")) {
								$("#postForm").prop("action", "${pageContext.request.contextPath}/reservation/delete").submit();
							}
						}
					}
				</script>
			</c:if>
		</div>
	
	    <table id="detail-table" class="table table-bordered">
	    	<tr>
	    		<th>성함</th>
	    		<td><span class="data-text">${r.studentName}</span></td>
	    		<th>반</th>
	    		<td><span class="data-text">${r.className}</span></td>
	    	</tr>
	    	<tr>
	    		<th>전화번호</th>
	    		<td>
	    			<span class="data-text">
			        	<c:choose>
				            <%-- 휴대폰 번호(11자리)가 맞을 때만 하이픈 포맷팅 적용 --%>
				            <c:when test="${not empty r.phone and fn:length(r.phone) eq 11}">
				                ${fn:substring(r.phone, 0, 3)}-${fn:substring(r.phone, 3, 7)}-${fn:substring(r.phone, 7, 11)}
				            </c:when>
				            <%-- 누락되었거나 자리수가 다르면 있는 그대로 출력 --%>
				            <c:otherwise>
				                ${r.phone}
				            </c:otherwise>
			        </c:choose>
    				</span>
	    		</td>
	    		<th>이메일</th>
	    		<td><span class="data-text">${r.email}</span></td>
	    	</tr>
	    	<tr>
	    		<th>상담일자</th>
	    		<td><span class="data-text" id="displayDate">${r.consultDate}</span></td>
	    		<th>상담상태</th>
	    		<td>
	    			<span class="data-text" style="font-weight: bold;">
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
				    </span>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>상담자</th>
	    		<td><span class="data-text">${r.counselorName}</span></td>
	    		<th>상담유형</th>
	    		<td><span class="data-text">${r.categoryName}</span></td>
	    	</tr>
	    	<tr>
	    		<th>문의내용</th>
	    		<td colspan="3">
	    			<div class="textarea-box">${r.inquiryContent}</div>
	    		</td>
	    	</tr>
	    	<%-- 상담사가 상담일지를 작성 후, 학생 화면 하단에도 자동으로 일지 공개 --%>
	    	<c:if test="${ not empty log and not empty log.content }">
	    		<tr>
	    			<th>상담일지</th>
	    			<td colspan="3">
	    				<div style="width : 100%; min-height : 150px; border : 1px solid #dee2e6; background-color : #f8f9fa; padding : 12px; white-space : pre-wrap; overflow-y : auto; text-align: left; color : #333; font-size : 15px;">${ log.content }</div>
	    			</td>
	    		</tr>
	    	</c:if>
	    </table>
	</div>

	<jsp:include page="../common/footer.jsp"/>
	
	<script>
		$(function() {
			// 1. 서버에서 넘어온 "2026-06-12 15:30" 형태의 문자열 읽기
			let rawDateStr = $("#displayDate").text().trim();
			
			if(rawDateStr) {
				// 공백을 기준으로 [날짜, 시간] 분리 (예: ["2026-06-12", "15:30"])
				let parts = rawDateStr.split(" ");
				
				if(parts.length === 2) {
					let datePart = parts[0]; // "2026-06-12"
					let timePart = parts[1]; // "15:30"
					
					// 시, 분 분리
					let timeParts = timePart.split(":");
					let hour = parseInt(timeParts[0], 10);
					let minute = timeParts[1];
					
					// 오전, 오후 판별 및 12시간제 변환
					let ampm = hour >= 12 ? "오후" : "오전";
					
					if (hour > 12) {
						hour = hour - 12;
					} else if (hour === 0) {
						hour = 12; // 00시는 오전 12시로 매핑
					}
					
					// 시(Hour)가 한 자리 수일 때 앞에 0 붙여주기 (예: 3 -> 03)
					let formattedHour = hour < 10 ? "0" + hour : hour;
					
					// 최종 포맷 조합 (예: 2026-06-12 오후 03:30)
					let finalDateStr = datePart + " " + ampm + " " + formattedHour + ":" + minute;
					
					// 화면의 텍스트를 이쁘게 포맷팅된 문자열로 교체
					$("#displayDate").text(finalDateStr);
				}
			}
		});
	</script>

</body>
</html>