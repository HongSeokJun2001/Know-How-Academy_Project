<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 1. 기본 스타일 세팅 (기존 대시보드와 일치감 형성) */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', -apple-system, sans-serif;
    }

    body {
        background-color: #F8F9FA;
    }

    /* 2. 가입 승인 컨테이너 스타일 */
    .approval-container {
        background-color: #ffffff;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        border: 1px solid #EAE9F5;
        max-width: 1200px;
        margin: 0 auto;
    }
    .approval-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #2C2A38;
    }
    .approval-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
    .approval-table th {
        padding: 15px;
        border-bottom: 2px solid #F3F1FF;
        color: #6F6D80;
        font-weight: 600;
        font-size: 15px;
    }
    .approval-table td {
        padding: 15px;
        border-bottom: 1px solid #EAE9F5;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
    .class-select {
        padding: 6px 12px;
        border-radius: 6px;
        border: 1px solid #DDD8FF;
        outline: none;
        font-weight: 600;
        color: #4233C7;
        background-color: #F8F7FF;
        cursor: pointer;
    }
    .status-badge {
        background-color: #F8F9FA;
        color: #9291A5;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 700;
        border: 1px solid #EAE9F5;
    }
    .btn-approve {
        background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 700;
        margin-right: 4px;
        transition: background 0.2s;
    }
    .btn-approve:hover { background-color: #3225A3; }
    
    .btn-reject {
        background-color: #E84118;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 700;
        transition: background 0.2s;
    }
    .btn-reject:hover { background-color: #C23616; }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<div class="content-area">

    <div class="approval-container">
        <h2 class="approval-title">신규 가입 신청 목록</h2>
        
        <table class="approval-table">
            <thead>
                <tr>
                    <th>이름</th>
                    <th>클래스 배정</th>
                    <th>신청일</th>
                    <th>상태</th>
                    <th>승인 관리</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${ not empty requestScope.list }">
		            	<c:forEach var="s" items="${ requestScope.list }">
			            	<tr>
			                    <td>${ s.studentName }</td>
			                    <td>
			                        <select class="class-select" id="classSelect_${ s.userNo }">
			                            <option value="1">A 반</option>
			                            <option value="2">B 반</option>
			                            <option value="3">C 반</option>
			                            <option value="4">D 반</option>
			                            <option value="5">AWS DevOps 1기</option>
			                            <option value="6">Java Backend 1기</option>
			                            <option value="7">Frontend Basic 1기</option>
			                        </select>
			                    </td>
			                    <td>${ s.createdAt }</td>
				                <td><span class="status-badge">대기</span></td>
			                    <td>
			                        <button type="button" class="btn-approve" onclick="approveStudent(${ s.userNo }, '${ s.studentName }')">승인</button>
			                        <button type="button" class="btn-reject" onclick="rejectStudent(${ s.userNo }, '${ s.studentName }')">거절</button>
			                    </td>
			                </tr>
		            	</c:forEach>
	            	</c:when>
	            	<c:otherwise>
	            		<tr>
	            			<td colspan="5"><h3>가입 승인 대기 내역이 존재하지 않습니다.</h3></td>
	            		</tr>
	            	</c:otherwise>
            	</c:choose>
            </tbody>
        </table>
    </div>

</div>

<script>
    function approveStudent(userNo, studentName) {
        let classNo = $("#classSelect_" + userNo).val();
        let selectedClass = $("#classSelect_" + userNo + " option:selected").text();
        
        if(confirm(studentName + ' 학생을 [' + selectedClass + '](으)로 지정하여 가입 승인하시겠습니까?')) {
        	$.ajax({
        		url : "/know-how/admin/student/approve",
        		type : "post",
        		data : {
        			userNo : userNo,
        			classNo : classNo
        		},
        		success(result) {
        			if(result == "success") {
        	            alert("[승인 완료]\n학생이름: " + studentName + "\n배정클래스: " + selectedClass);
						location.reload();
        			} else {
        				alert("가입 승인이 실패되었습니다.");
        			}
        		},
        		error() {
        			console.log("가입 승인용 ajax 통신 실패!!");
        		}
        	});
        	
        }
    }

    function rejectStudent(userNo, studentName) {
        if(confirm(studentName + '학생의 가입 신청을 정말로 거절하시겠습니까?')) {
        	$.ajax({
        		url : "/know-how/admin/student/reject",
        		type : "post",
        		data : {
        			userNo : userNo
        		},
        		success(result) {
        			if(result == "success") {
        				alert('[거절 완료]\n학생이름: ' + studentName + '\n\n목록에서 제외 처리됩니다.');
        				location.reload();
        			} else {
        				alert("가입 거절이 실패되었습니다.");
        			}
        		},
        		error() {
        			console.log("가입 거절용 ajax 통신 실패!!");
        		}
        	});
            
        }
    }
</script>

</body>
</html>