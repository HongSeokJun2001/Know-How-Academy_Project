<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', -apple-system, sans-serif;
    }

    body {
        background-color: #F8F9FA;
    }

    .card {
        background-color: #ffffff;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        border: 1px solid #EAE9F5;
        max-width: 1200px;
        margin: 0 auto;
    }
    
    h2 {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #2C2A38;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
    
    table th {
        padding: 15px;
        border-bottom: 2px solid #F3F1FF;
        color: #6F6D80;
        font-size: 15px;
    }
    
    table td {
    	padding: 15px 0;
        border-bottom: 1px solid #EAE9F5;
        text-align : center;
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
    
    .status-pending {
        background-color: #F8F9FA;
        color: #9291A5;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 700;
        border: 1px solid #EAE9F5;
    }
    
    .status-rejected {
        background-color: #ffc6af;
        color: #ff3c00;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 700;
        border: 1px solid #ff3c00;
    }
    
    .btn {
    	border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 700;
        margin-right: 4px;
        transition: background 0.2s;
    }
    
    .btn.approve {
        background-color: #4233C7;
        color: white;
    }
    .btn.approve:hover { background-color: #3225A3; }
    
    .btn.rejected {
        background-color: #E84118;
        color: white;
    }
    .btn.rejected:hover { background-color: #C23616; }
    
    .btn.delete {
        background-color: #d3d3d3;
        color: white;
    }
    .btn.delete:hover { background-color: #b0b0b0; }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

    <div class="card">
        <h2>신규 가입 신청 목록</h2>
        
        <table>
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
			                    <c:choose>
			                    	<c:when test="${ s.status eq 'PENDING'}">
			                    		<td><span class="status-pending">대기</span></td>
			                    		<td>
					                        <button type="button" class="btn approve" onclick="approveStudent(${ s.userNo }, '${ s.studentName }')">승인</button>
					                        <button type="button" class="btn rejected" onclick="rejectStudent(${ s.userNo }, '${ s.studentName }')">거절</button>
					                    </td>
			                    	</c:when>
			                  		<c:otherwise>
			                  			<td><span class="status-rejected">거절</span></td>
			                  			<td><button type="button" class="btn delete" onclick="deleteStudent(${ s.userNo }, '${ s.studentName }')">삭제</button><td>
			                  		</c:otherwise>
			                    </c:choose>
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
        				alert('[거절 완료]\n학생이름: ' + studentName + '\n\n목록에서 거절 처리됩니다.');
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
    
    function deleteStudent(userNo, studentName) {
        if(confirm(studentName + '학생의 가입 신청을 정말로 삭제하시겠습니까?')) {
        	$.ajax({
        		url : "/know-how/admin/student/delete",
        		type : "post",
        		data : {
        			userNo : userNo
        		},
        		success(result) {
        			if(result == "success") {
        				alert('[삭제 완료]\n학생이름: ' + studentName + '\n\n목록에서 삭제 처리됩니다.');
        				location.reload();
        			} else {
        				alert("가입 삭제가 실패되었습니다.");
        			}
        		},
        		error() {
        			console.log("가입 삭제용 ajax 통신 실패!!");
        		}
        	});
            
        }
    }
</script>

</body>
</html>