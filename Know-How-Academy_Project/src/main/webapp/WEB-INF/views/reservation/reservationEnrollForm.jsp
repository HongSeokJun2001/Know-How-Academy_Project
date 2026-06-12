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
		
		<input type="hidden" id="reservedDatesStr" value="${String.join(',', reservedDates)}">
		
		<form id="enroll-form" action="/know-how/reservation/insert" method="post">
		
			<div class="form-header">
				<h2 style="margin : 0; font-weight : bold;">상담신청</h2>
				<button type="submit" class="btn-submit">등록</button>				
			</div>
		
		    <table class="table">
		    	<tr>
		    		<th class="text-center align-middle">상담일자</th>
		    		<td colspan="3">
		    			<div style="display: flex; align-items: center; gap: 10px;">
		    				<input type="date" name="consultDate" id="consultDate" class="form-control" style="width: 200px;" required>
		    				<input type="time" name="consultTime" id="consultTime" class="form-control" style="width: 150px;" required>
		    			</div>
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
	
	<script>
		$(function() {
		    // 1. 오늘 이전 날짜 선택 불가능하게 설정
		    let today = new Date().toISOString().split('T')[0];
		    $('#consultDate').attr("min", today);
		    
		    // 2. hidden 태그에 담긴 기존 예약 문자열 리스트를 꺼내와 배열로 쪼갭니다.
		    let reservedDatesStr = $('#reservedDatesStr').val();
		    let reservedDates = reservedDatesStr ? reservedDatesStr.split(',') : [];
		    
		    // 3. 숫자만 추출하여 매칭률을 극대화한 중복 체크 함수
		    function checkDateTimeDuplicate() {
		        let selectedDate = $("#consultDate").val(); // YYYY-MM-DD
		        let selectedTime = $("#consultTime").val(); // HH:mm
		        
		        if(selectedDate && selectedTime) {
		            // 사용자가 선택한 날짜+시간에서 숫자만 추출 (예: "202606121530")
		            let targetValue = (selectedDate + selectedTime).replace(/[^0-9]/g, "");
		            
		            // 기존 예약 목록 중 일치하는 숫자가 있는지 검사
		            let isReserved = reservedDates.some(function(reservedDate) {
		                let existingValue = reservedDate.replace(/[^0-9]/g, "");
		                
		                // 초 단위가 붙어있을 수 있으므로 사용자가 고른 길이만큼만 잘라서 정확히 비교
		                return existingValue.substring(0, targetValue.length) === targetValue;
		            });
		            
		            if(isReserved) {
		                alert("해당 일시에는 이미 예약이 완료되었습니다. 다른 날짜나 시간을 선택해주세요.");
		                $("#consultTime").val(""); // 시간 입력칸 초기화
		                document.getElementById("consultTime").setCustomValidity("이미 예약된 시간입니다.");
		            } else {
		                document.getElementById("consultTime").setCustomValidity("");
		            }
		        }
		    }
	
		    // 날짜나 시간이 바뀔 때마다 중복 체크 실행
		    $("#consultDate, #consultTime").on("change", checkDateTimeDuplicate);
		});
	</script>

	<jsp:include page="../common/footer.jsp"/>

</body>
</html>