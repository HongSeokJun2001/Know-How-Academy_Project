<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="jakarta.tags.core" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
	#login-page table > button {
	     padding : 5px;
		 margin : 5px;
		 width : 150px;
	}
	#login-form table>thead {
        padding : 20%;
	}
	#login-form table>tbody {
        padding : 40%;
	}
	#login-form table>tfoot {
        padding : 24%;
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
					- 로그인 요청 시 http://localhost:8002/know-how/myPage/login 으로 요청
				--%>
                
				<form id="login-form" action="/know-how/myPage/login" method="post"> 
		            
	                <br><br>
	                
					<table id="login-page">
						<thead>
						<tr>
							<h2 align="center">로그인</h2>
						</tr>
						</thead>
						<tbody>
						<tr align="center">
							<th>&nbsp;&nbsp;&nbsp;아이디<input type="text" name="userId" required value="${ cookie.saveId.value }"></th>
						</tr>
						<tr>	
							<th>&nbsp;&nbsp;&nbsp;비밀번호<input type="password" name="userPwd" required></th>
						</tr>
						<tr id="idcheck" align="right">
						    <!-- 아이디 저장 -->
							<!-- 로그인 요청 시 아이디 저장 여부를 서버로 같이 넘기기 -->
							<th>
							<input type="checkbox" id="saveId" name="saveId" value="y">
						    <label for="saveId">아이디 저장</label>
							</th>
						</tr>
                        </table>
						<div id="loginbutton" align="center">
					    
					            <button type="submit" class="btn btn-secondary btn-sm">로그인</button>
					    </div>
						<div align="center">
					      --------------------------------------------------------------
						<br>
							
								<button type="button" class="btn btn-secondary btn-sm"
													  onclick="enrollPage();">회원가입</button>
								<button type="button" class="btn btn-secondary btn-sm"
								                      onclick="searchIdPage();">아이디 찾기</button>
								<button type="button" class="btn btn-secondary btn-sm"
								                      onclick="searchPasswordPage();">비밀번호 찾기</button>					  
						<br><br>
						</div>
					 
					
					</form>
					
					<script>
					function enrollPage() {
						
						// 회원가입페이지로 이동
						location.href = "/know-how/myPage/enrollForm";
						// GET 방식
					}
				    
					function searchIdPage() {
						
						// 아이디찾기페이지로 이동
						location.href = "/know-how/myPage/searchIdForm";
						// GET 방식
					}
			
					function searchPasswordPage() {
						
						// 비밀번호찾기페이지로 이동
						location.href = "/know-how/myPage/searchPasswordForm";
						// GET 방식
					}
				    </script> 
		    </c:when>
	     <c:otherwise>	
	        
	        <!-- case2. 로그인 후 -->
				<div id="user-info">
				    
					  <table id="login-page" align="center">
					      <tr align="center">
							<h2 align="center">마이페이지</h2>
							<td>
                              <h3><b>${ sessionScope.loginUser.userName }</b> 님 환영합니다.</h3>
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
						 <tr align="center">
							<th>
							    <button type="button" class="btn btn-secondary btn-sm"
									                  onclick="myInformationChangePage();">내정보 수정</button>
						   </th>
						 </tr>
						 <tr>
							<th>--------------------------------------------</th>
						 </tr>
						 <tr align="center">
						   <th>
						       <button type="button" class="btn btn-secondary btn-sm" 
						               onclick="logout();">로그아웃</button>             
						   </th>
						 </tr>
					</table> 
					
					<script>
					function myInformationSelectPage() {
						
						// 내정보 조회 페이지로 이동
						location.href = "/know-how/myPage/myInformationSelectForm";
						// GET 방식
					}
				    
					function myInformationChangePage() {
						
						// 내정보 수정 페이지로 이동
						location.href = "/know-how/myPage/myInformationChangeForm";
						// GET 방식
					}
				    
					function logout() {
						
						// 로그아웃
						location.href = "/know-how/myPage/logout";
						// GET 방식
					}
				    </script>
				  </div>
		
			</c:otherwise>
		
		</c:choose>	        
         
        </div> 
      </div>
      
      <script>
		$(function() {
			
			let saveId = "${ cookie.saveId.value }"; 
			
			// console.log(saveId); // "admin" / ""
			
			if(saveId != "") {
				// 쿠키에 저장된 아이디가 있으면 
				
				$("#saveId").prop("checked", true);
			}
			
		});
	</script>
</body>
</html>