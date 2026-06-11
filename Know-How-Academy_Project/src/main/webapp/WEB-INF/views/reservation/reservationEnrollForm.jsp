<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상담신청 등록</title>
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
	.btn-submit {
		background-color : #c722e6;
		color : white;
		border : none;
		padding : 10px 35px;
		font-weight : bold;
		cursor : pointer;
		font-size : 16px;
	}
	.btn-submit:hover {
		background-color : #a81bc4;
	}
	.table th {
		background-color : #f2f2f2;
		text-align : center;
		vertical-align : middle;
		width : 15%;
	}
	#enroll-form table {
		margin : auto;
		width : 90%;
	}
	
	#enroll-form input, #enroll-form textarea, #enroll-form select {
		padding : 5px;
	}
	
	#enroll-form input, #enroll-form textarea {
		width : 100%;
	}
	#enroll-form textarea {
		resize : none;
		height : 300px;
	}
	
	.fixed-width {
		width : 200px !important;
	}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<div class="outer">
		
		<form id="enroll-form" action="/know-how/reservation/insert" method="post">
		
			<div class="form-header">
				<h2 style="margin : 0; font-weight : bold;">상담신청</h2>
				<button type="submit" class="btn-submit">등록</button>				
			</div>
		
		    <table class="table">
		    	<tr>
		    		<th class="text-center align-middle">상담일자</th>
		    		<td colspan="3">
		    			<input type="date" name="consultDate" id="consultDate" class="form-control" style="width: 200px;" required>
		    		</td>
		    		
		    	</tr>
		    	<tr>
		    		<th class="text-center align-middle">상담유형</th>
		    		<td>
		    			<input type="text" class="form-control fixed-width" value="${ selectedCounselor.categoryName }" readonly>
		    			<input type="hidden" name="categoryNo" value="${ selectedCounselor.categoryNo }">
		    		</td>
		    		<th class="text-center align-middle">상담사</th>
		    		<td>
		    			<input type="text" class="form-control fixed-width" value="${ selectedCounselor.counselorName }" readonly>
		    			<input type="hidden" name="counselNo" value="${ selectedCounselor.counselNo }">
		    		</td>
		    	</tr>
		    	<tr>
		    		<th class="text-center align-middle">문의내용</th>
		    		<td colspan="3">
		    			<textarea name="inquiryContent" required></textarea>
		    		</td>
		    	</tr>
		    </table>
		</form>
	</div>

	<jsp:include page="../common/footer.jsp"/>

</body>
</html>