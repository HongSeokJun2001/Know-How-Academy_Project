<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

    .myStudentClassListForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 1000px;
           margin: auto;
	    }
	
	.list-title {
		text-align: center;
		font-weight: bold;
	}
	
	.list-area {
		margin : auto;
		width : 100% !important;
		text-align : center;
	}
	
	.mscl-className { width: 25%; }
	.mscl-userName     { width: 25%; }
	.mscl-phone    { width: 25%; }
	.mscl-status    { width: 25%; }
	
	.user-name {
		font-weight: bold;
	}
	
	.empty-cell {
		padding: 50px 0;
		color: #666;
	}
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   <br><br>
   <div class="myStudentClassListForm-outer">
        <br>
        <h2 class="list-title">학생리스트</h2>
        <br>

        <table class="list-area table table-hover">
            <thead>
                <tr>
                    <th class="mscl-className">반이름</th>
                    <th class="mscl-userName">학생 이름</th>
                    <th class="mscl-phone">연락처</th>
                    <th class="mscl-status">상태</th>
                </tr>
            </thead>
            <tbody>
			    <c:choose>
			    	<%--Case1. 조회된 반학생이 아무도 없을 때 --%>
			        <c:when test="${empty ClassList}">
			            <tr>
			                <td colspan="4" class="empty-cell">현재 학생이 없습니다</td>
			            </tr>
			        </c:when>
			        <%--Case. 반학생이 존재할 떄 --%>
			        <c:otherwise>
			            <c:forEach var="c" items="${ClassList}">
			                <tr>
			                    <td>${c.className}</td>
			                    
			                    <td class="user-name">${m.userName}</td>
			                    
			                    <td>
			                        <c:choose>
			                            <%-- 번호가 정상적으로 존재하고, 일반적인 휴대폰 번호(11자리) 길이일 때 분할 처리 --%>
			                            <c:when test="${not empty m.phone and fn:length(m.phone) eq 11}">
			                                ${fn:substring(m.phone, 0, 3)}-${fn:substring(m.phone, 3, 7)}-${fn:substring(m.phone, 7, 11)}
			                            </c:when>
			                            <%-- 혹시 자릿수가 다르거나 비어있다면 원본 데이터 노출 --%>
			                            <c:otherwise>
			                                ${m.phone}
			                            </c:otherwise>
			                        </c:choose>
			                    </td>
			                    
			                    <td>${m.status}</td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
        
        <br>
    </div>
</body>
</html>