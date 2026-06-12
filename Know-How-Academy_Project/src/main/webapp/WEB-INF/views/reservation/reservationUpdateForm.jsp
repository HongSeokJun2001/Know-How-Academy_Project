<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담신청 수정</title>
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
		background-color: #6c757d; 
		color: #fff;
	}
	.btn-modify:hover { background-color: #e6e600; color: #000; }
	.btn-delete:hover { background-color: #5a6268; color: #fff; }

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
	

	.form-control-readonly {
		width: 100%;
		border: none;
		background-color: transparent;
		font-size: 16px;
		color: #333;
		padding-left: 5px;
		outline: none;
	}
	.form-control-edit {
		width: 100%;
		padding: 6px 10px;
		font-size: 16px;
		border: 1px solid #ced4da;
		color: #333;
		outline: none;
	}
	
    .textarea-box-edit {
		width: 100%;
		height: 200px;
		border: 1px solid #dee2e6;
		background-color: #fff;
		padding: 10px;
		font-size: 16px;
		color: #333;
		resize: none; 
		outline: none;
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
		<form action="update" method="post">
			<input type="hidden" name="reservationNo" value="${r.reservationNo}">
			
			<div class="form-header">
				<h2 style="margin: 0; font-weight: bold;">상담신청 수정</h2>
				
				<div class="action-btn-group">
					<button type="submit" class="btn-custom btn-modify">수정완료</button>
					<button type="button" class="btn-custom btn-delete" onclick="history.back();">취소</button>
				</div>
			</div>
		
		    <table id="detail-table" class="table table-bordered">
		    	<tr>
		    		<th>성함</th>
		    		<td><input type="text" class="form-control-readonly" value="${r.studentName}" readonly></td>
		    		<th>반</th>
		    		<td><input type="text" class="form-control-readonly" value="${r.className}" readonly></td>
		    	</tr>
		    	<tr>
		    		<th>전화번호</th>
		    		<td><input type="text" class="form-control-readonly" value="${r.phone}" readonly></td>
		    		<th>이메일</th>
		    		<td><input type="text" class="form-control-readonly" value="${r.email}" readonly></td>
		    	</tr>
		    	<tr>
		    		<th>상담일자</th>
		    		<td>
		    			<div style="display: flex; align-items: center; gap: 10px;">
		    				<input type="date" name="consultDate" class="form-control-edit" value="${r.consultDate}" required>
		    				<input type="time" name="consultTime" id="consultTime" class="form-control-edit" style="width: 150px;" required>
		    			</div>
		    		</td>
		    		<th>상담상태</th>
		    		<td>
		    			<span class="data-text" style="font-weight: bold; padding-left: 5px; display: inline-block; vertical-align: middle;">
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
		    		<td><input type="text" class="form-control-readonly" value="${r.counselorName}" readonly></td>
		    		<th>상담유형</th>
		    		<td><input type="text" class="form-control-readonly" value="${r.categoryName}" readonly></td>
		    	</tr>
		    	<tr>
		    		<th>문의내용</th>
		    		<td colspan="3">
		    			<textarea name="inquiryContent" class="textarea-box-edit" required>${r.inquiryContent}</textarea>
		    		</td>
		    	</tr>
		    </table>
		</form>
	</div>

	<jsp:include page="../common/footer.jsp"/>

</body>
</html>