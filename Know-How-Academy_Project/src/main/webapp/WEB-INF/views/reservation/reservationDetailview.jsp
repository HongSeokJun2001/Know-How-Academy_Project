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
				<c:if test="${ (not empty sessionScope.loginUser) and (sessionScope.loginUser.userName eq r.studentName) and (r.reservationStatus ne 'COMPLETED') }">
					<a class="btn-custom btn-modify" onclick="postFormSubmit(1);">수정</a>
					<a class="btn-custom btn-delete" onclick="postFormSubmit(2);">삭제</a>
				</c:if>
				<a class="btn-custom btn-list" onclick="location.href='${pageContext.request.contextPath}/reservation/list'">목록으로</a>
			</div>
			
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
	    		<td><span class="data-text">${r.phone}</span></td>
	    		<th>이메일</th>
	    		<td><span class="data-text">${r.email}</span></td>
	    	</tr>
	    	<tr>
	    		<th>상담일자</th>
	    		<td><span class="data-text">${r.consultDate}</span></td>
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

</body>
</html>