<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담일지 작성</title>
<style>
	.outer {
		width : 1000px;
		margin : auto;
		padding : 30px;
		border : 1px solid #ccc;
		margin-top : 50px;
		background-color : #ffffff;
	}
	
	.form-header {
		display : flex;
		justify-content :space-between;
		align-items : center;
		width : 90%;
		margin : auto;
		margin-bottom : 20px;
	}
	
	.action-btn-group {
		display : flex;
		gap : 10px;
		margin-left : auto;
	}
	
	.btn-custom {
		border : 1px solid #333;
		padding : 6px 22px;
		font-weight : bold;
		cursor : pointer;
		font-size : 15px;
		text-decoration : none;
		text-align : center;
		border-radius : 4px;
	}
	
	.btn-insert {
		background-color : #28a745;
		color : white;
	}
	
	.btn-modify {
		background-color : #ffaa44;
		color : white;
	}
	
	.btn-delete {
		background-color : #dc3545;
		color : white;
	}
	
	.btn-list {
		background-color : #6c757d;
		color : white;
	}
	
	.btn-custom:hover {
		opacity : 0.8;
	}
	
	#detail-table {
		margin : auto;
		width : 90%;
		border-collapse : collapse;
	}
	
	#detail-table th {
		background-color : #e9ecef;
		text-align : center;
		vertical-align : middle;
		width : 15%;
		font-weight : bold;
	}
	
	#detail-table td {
		vertical-align : middle;
		padding : 12px;
	}
	
	.data-text {
		font-size : 16px;
		color : #333;
		padding-left : 5px;
	}
	
	.textarea-box-read {
		width : 100%;
		height : 150px;
		border : 1px solid #dee2e6;
		background-color : #f8f9fa;
		padding : 10px;
		white-space : pre-wrap;
		overflow-y : auto;
		text-align : left;
		color : #555;
	}
	
	.textarea-box-input {
		width : 100%;
		height : 250px;
		border : 1px solid #dee2e6;
		background-color : #fff;
		padding : 10px;
		resize : none;
		text-align : left;
		font-size : 15px;
	}
	
	#detail-table .badge {
		font-size : 13px;
		padding : 6px 12px;
		font-weight : bold;
		color : #ffffff !important;
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
		<form id="logForm" action="" method="post">
			<input type="hidden" name="reservationNo" value="${ r.reservationNo }">
			
			<div class="form-header">
				<h2 style="margin : 0; font-weight : bold">상담일지 작성</h2>
				
				<div class="action-btn-group">
					<c:choose>
						<%--기존에 작성된 상딤일지 내용이 있다면 '수정' 버튼 노출 --%>
						<c:when test="${ not empty log and not empty log.content }">
							<button type="button" class="btn-custom btn-modify" onclick="logAction('update');">수정</button>
						</c:when>
						<%--기존 상담일지가 없다면 '등록' 버튼 노출 --%>
						<c:otherwise>
							<button type="button" class="btn-custom btn-insert" onclick="logAction('insert');">등록</button>
						</c:otherwise>
					</c:choose>
					<button type="button" class="btn-custom btn-list" onclick="location.href='${ pageContext.request.contextPath }/reservation/counselorReservationList'">목록으로</button>
				</div>
			</div>
			
			<table id="detail-table" class="table table-bordered">
				<tr>
					<th>성함</th>
					<td>
						<span class="data-text">${ r.studentName }</span>
					</td>
					<th>반</th>
					<td>
						<%--삼항 연산자를 이용해 소속 학급이 없을 경우 '미지정' 처리 --%>
						<span class="data-text">${ r.className != null ? r.className : '미지정'}</span>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<span class="data-text">${ r.phone }</span>
					</td>
					<th>이메일</th>
					<td>
						<span class="data-text">${ r.email }</span>
					</td>
				</tr>
				<tr>
					<th>상담일자</th>
					<td>
						<span class="data-text">${ r.consultDate }</span>
					</td>
					<th>상담상태</th>
					<td>
						<span class="data-text" style="font-weight : bold">
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
					<td>
						<span class="data-text">${ r.counselorName }</span>
					</td>
					<th>상담유형</th>
					<td>
						<span class="data-text">${ r.categoryName }</span>
					</td>
				</tr>
				<tr>
					<th>문의내용</th>
					<td colspan="3">
						<div class="textarea-box-read">${ r.inquiryContent }</div>
					</td>
				</tr>
				<tr>
					<th>상담일지</th>
					<td colspan="3">
						<textarea name="content" class="textarea-box-input" placeholder="상담 및 소현 내용을 상세히 입력해주세요." required>${ log.content }</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
		function logAction(type) {
			let form = document.getElementById("logForm");
			
			if(type == 'insert') {
				if(confirm("작성하신 상담일지를 등록하시겠습니까?")) {
					form.action = "${pageContext.request.contextPath}/reservation/insertLog";
					form.submit();
				}
			} else if(type == 'update') {
				if(confirm("상담일지 내용을 수정하시겠습니까?")) {
					form.action = "${pageContext.request.contextPath}/reservation/updateLog";
					form.submit();
				}
			} else if(type == 'delete') {
				if(confirm("등록된 상담일지를 삭제하시겠습니까?")) {
					form.action = "${pageContext.request.contextPath}/reservation/deleteLog?rno=" + form.reservationNo.value;
					form.submit();
				}
			}
		}
	</script>

	<jsp:include page="../common/footer.jsp"/>
</body>
</html>