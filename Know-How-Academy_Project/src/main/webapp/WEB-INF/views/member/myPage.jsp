<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="jakarta.tags.core" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #login-form table {
		margin : auto;
	}
	#login-form input {
         padding : 5px;
		 margin : 5px;
		 width : 250px;
	}
	#login-form button {
		 padding : 5px;
		 margin : 5px;
		 width : 100px;
	}
</style>
</head>
<body>
      <jsp:include page="../common/menubar.jsp"/> 
      
      <br><br>
      
      <div class="mypage-outer">
      <!-- 로그인 관련 영역 -->
	  <div class="login-area">

		<c:choose>
		
			<c:when test="${ empty sessionScope.loginUser }">
			
				<!-- case1. 로그인 전 -->
				<%-- 
					* 로그인 기능 구현
					- 아이디와 비밀번호를 입력한 후 로그인 버튼을 클릭
					- 로그인 요청 시 http://localhost:8002/know-how/member/myPage/login 으로 요청
				--%>
                
				<form id="login-form" action="/know-how/member/myPage/login" method="post"> 
		            
	                <br><br>
	                
					<table id="login-page" align="center">
						<tr>
							<h2 align="center">로그인</h2>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="userId">
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="userPwd" required>
							</td>
						</tr>
						<tr>
							<th>
								<br>
							</th>
						</tr>
					    <tr>
					        <th colspan="3">
					            <button type="submit" class="btn btn-secondary btn-sm">로그인</button>
					        </th>
					    </tr>
						<tr>
							<th>
								<br>
							</th>
						</tr>
						<tr align="center">
							<th colspan="3">
								<button type="button" class="btn btn-secondary btn-sm"
													  onclick="enrollPage();">회원가입</button>
								<button type="button" class="btn btn-secondary btn-sm"
								                      onclick="searchIdPage();">아이디 찾기</button>
								<button type="button" class="btn btn-secondary btn-sm"
								                      onclick="searchPasswordPage();">비밀번호 찾기</button>					  
							</th>
						</tr>
						<tr>
							<th><br><br></th>
						</tr>
					</table> 
					
					<script>
					function enrollPage() {
						
						// 회원가입페이지로 이동
						location.href = "/know-how/member/enrollForm";
						// GET 방식
					}
				    </script>
				    
				    <script>
					function searchIdPage() {
						
						// 아이디찾기페이지로 이동
						location.href = "/know-how/member/searchIdForm";
						// GET 방식
					}
				    </script>
				    
				    <script>
					function searchPasswordPage() {
						
						// 비밀번호찾기페이지로 이동
						location.href = "/know-how/member/searchPasswordForm";
						// GET 방식
					}
				    </script> 
		    </c:when>
	     <c:otherwise>	
	        
	        <!-- case2. 로그인 후 -->
				<div id="user-info">
				    
					  <table id="login-page" align="center">
					      <tr>
							<h2 align="center">마이페이지</h2>
							<td>
                              <b>${ sessionScope.loginUser.userName }</b> 님 환영합니다.
							</td>
							<br><br>
						  </tr>
						  <tr>
							 <th></th>
						  </tr>
						  <tr align="center">
						    <th>
								<button type="button" class="btn btn-secondary btn-sm"
													  onclick="myInformationSelectPage();">내정보 조회</button>					  
						    </th>
						 </tr>
						 <tr>
							<th>
							    <button type="button" class="btn btn-secondary btn-sm"
									                  onclick="myInformationChangePage();">내정보 수정</button>
						   </th>
						 </tr>
					</table> 
					
					<script>
					function myInformationSelectPage() {
						
						// 내정보 찾기 페이지로 이동
						location.href = "/know-how/member/myInformationSelectFrom";
						// GET 방식
					}
				    </script>
				    
				    <script>
					function myInformationChangePage() {
						
						// 내정보 수정 페이지로 이동
						location.href = "/know-how/member/myInformationChangeForm";
						// GET 방식
					}
				    </script>
				  </div>
		
			</c:otherwise>
		
		</c:choose>	        
         
        </div> 
      </div>
      
     
</body>
</html>