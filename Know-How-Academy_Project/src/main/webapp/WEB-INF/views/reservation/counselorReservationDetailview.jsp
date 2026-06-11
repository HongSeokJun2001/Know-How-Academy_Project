<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
		background-color : #ffffff;
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
		border-radius : 4px;
	}
	
	.btn-approve {
		background-color : #28a745;
		color : white;
	}
	.btn-reject {
		background-color : #dc3545;
		color : white;
	}
	.btn-complete {
		background-color : #ffaa44;
		color : white;
	}
	.btn-modify {
		background-color :#ffaa44;
		color : white;
	}
	.btn-delete {
		background-color : #dc3545;
		color : white;
	}
	.btn-log {
		background-color : #28a745;
		color : white;
	}
	.btn-list {
		background-color : #6c757d;
		color : white;
	}
	
	.btn-approve:hover, .btn-reject:hover, .btn-complete:hover, .btn-log:hover, .btn-list:hover, .btn-modify:hover, .btn-delete:hover {
		opacity : 0.8;
		cursor : pointer;
	}
	.btn-complete:hover, .btn-modify:hover {
		background-color : #e68a22;
	}

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
		text-align: left;   
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
			<h2 style="margin: 0; font-weight: bold;">상담신청 상세내역</h2>
			
			<div class="action-btn-group">
				<c:choose>
					<c:when test="${sessionScope.loginUser.roleCode eq 'ADMIN' or sessionScope.loginUser.roleCode eq 'INSTRUCTOR'}">
						<button type="button" class="btn-custom btn-list" onclick="location.href='${ pageContext.request.contextPath }/reservation/list'">목록으로</button>
					</c:when>
					
					<c:otherwise>
						<c:if test="${ r.reservationStatus eq 'APPLIED' }">
							<button type="button" class="btn-custom btn-approve" onclick="statusChange('approve');">승인</button>
							<button type="button" class="btn-custom btn-reject" onclick="statusChange('reject');">거절</button>
						</c:if>
						<c:if test="${ r.reservationStatus eq 'RESERVED' }">
							<button type="button" class="btn-custom btn-complete" onclick="statusChange('complete');">상담완료</button>
						</c:if>
						<c:if test="${ r.reservationStatus eq 'COMPLETED' }">
							<c:choose>
								<c:when test="${ not empty log and not empty log.content }">
									<button type="button" class="btn-custom btn-complete" onclick="location.href='${pageContext.request.contextPath}/reservation/logForm?rno=${ r.reservationNo }'">수정</button>
									<button type="button" class="btn-custom btn-delete" onclick="deleteLogAction()">삭제</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn-custom btn-log" onclick="location.href='${pageContext.request.contextPath}/reservation/logForm?rno=${ r.reservationNo }'">상담일지 작성하러 가기</button>
								</c:otherwise>
							</c:choose>
						</c:if>
						<button type="button" class="btn-custom btn-list" onclick="location.href='${ pageContext.request.contextPath }/reservation/counselorReservationList'">목록으로</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<table id="detail-table" class="table table-bordered">
			<tr>
				<th>성함</th>
				<td><span class="data-text">${ r.studentName }</span></td>
				<th>반</th>
				<td><span class="data-text">${ r.className != null ? r.className : '미지정' }</span></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><span class="data-text">${ r.phone }</span></td>
				<th>이메일</th>
				<td><span class="data-text">${ r.email }</span></td>
			</tr>
			<tr>
				<th>상담일자</th>
				<td><span class="data-text">${ r.consultDate }</span></td>
				<th>상담상태</th>
				<td>
					<span class="data-text" style="font-weight: bold;">
						<c:choose>
							<c:when test="${ r.reservationStatus eq 'APPLIED' }">
								<span class="badge bg-warning">예약대기</span>
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
				<th>상담사</th>
				<td><span class="data-text">${ r.counselorName }</span></td>
				<th>상담유형</th>
				<td><span class="data-text">${ r.categoryName }</span></td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td colspan="3">
					<div class="textarea-box">${ r.inquiryContent }</div>
				</td>
			</tr>
			
			<c:if test="${ not empty log and not empty log.content }">
				<tr>
					<th>상담일지</th>
					<td colspan="3">
						<div style="width: 100%; min-height: 150px; border: 1px solid #dee2e6; background-color: #f8f9fa; padding: 12px; white-space: pre-wrap; overflow-y: auto; text-align: left; color: #333; font-size: 15px;">${ log.content }</div>
					</td>
				</tr>				
			</c:if>
		</table>
	</div>
	
	<form id="statusForm" action="" method="post">
		<input type="hidden" name="rno" value="${ r.reservationNo }">
	</form>
	
	<script>
		function statusChange(type) {
			let form = document.getElementById("statusForm");
			if(type == 'approve') {
				if(confirm("이 상담 신청을 승인하시겠습니까?")) {
					form.action = "${pageContext.request.contextPath}/reservation/approve";
					form.submit();
				}
			} else if (type == 'reject') {
				if(confirm("이 상담 신청을 거절(반려)하시겠습니까?")) {
					form.action = "${pageContext.request.contextPath}/reservation/reject";
					form.submit();
				}
			} else if (type == 'complete') {
				if(confirm('이 상담을 완료 처리하시겠습니까?')) {
					form.action = "${pageContext.request.contextPath}/reservation/complete";
					form.submit();
				}
			}
		}
		
		function deleteLogAction() {
			if(confirm("등록된 상담일지를 완전히 삭제하시겠습니까?")) {
				let form = document.getElementById("statusForm");
				form.action = "${pageContext.request.contextPath}/reservation/deleteLog";
				form.submit();
			}
		}
	</script>

	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>