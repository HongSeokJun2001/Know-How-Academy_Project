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
    
    .btn-unlock {
        background-color: #4233C7;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 700;
        margin-right: 4px;
        transition: background 0.2s;
    }
    .btn-unlock:hover { background-color: #3225A3; }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

    <div class="card">
        <h2>유저 계정 잠금 목록</h2>  
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>권한코드</th>
                    <th>로그인실패횟수</th>
                    <th>잠금발생시간</th>
                    <th>계정풀기</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${ not empty requestScope.list }">
		            	<c:forEach var="m" items="${ requestScope.list }">
			            	<tr>
			                    <td>${ m.userName }</td>
			                    <c:choose>
			                    	<c:when test="${ m.roleCode eq 'STUDENT' }">
			                    		<td>학원생</td>
			                    	</c:when>
			                    	<c:when test="${ m.roleCode eq 'COUNSELOR' }">
			                    		<td>상담사</td>
			                    	</c:when>
			                    	<c:when test="${ m.roleCode eq 'INSTRUCTOR' }">
			                    		<td>강사</td>
			                    	</c:when>
			                    	<c:when test="${ m.roleCode eq 'ADMIN' }">
			                    		<td>관리자</td>
			                    	</c:when>
			                    </c:choose>
			                    <td>${ m.failCount }회</td>
			                    <td>${ m.lockedAt }</td>
			                    <td><span class="btn-unlock" onclick="unlockMember('${ m.userName }', ${ m.userNo })">잠금해제</span></td>
			                </tr>
		            	</c:forEach>
	            	</c:when>
	            	<c:otherwise>
	            		<tr>
	            			<td colspan="5"><h3>계정 잠긴 내역이 존재하지 않습니다.</h3></td>
	            		</tr>
	            	</c:otherwise>
            	</c:choose>
            </tbody>
        </table>
    </div>

<script>
    function unlockMember(userName, userNo) {

        if(confirm(userName + "님의 계정을 잠금 해제 하시겠습니까?")) {
        	$.ajax({
        		url : "/know-how/admin/memberUnlock",
        		type : "post",
        		data : {
        			userNo : userNo
        		},
        		success(result) {
        			if(result == "success") {
        	            alert("[해제 완료]\n이름: " + userName);
						location.reload();
        			} else {
        				alert("잠금 해제가 실패되었습니다.");
        			}
        		},
        		error() {
        			console.log("잠금 해제용 ajax 통신 실패!!");
        		}
        	});
        }
    }
</script>

</body>
</html>