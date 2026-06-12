<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="jakarta.tags.core" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
   * {
        margin: auto;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', -apple-system, sans-serif;
    }

    body {
        background-color: #F8F9FA;
        padding: 32px;
    }
    .mypagelogin-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 600px;
           margin: auto;
	    }
	.mypagelogout-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 600px;
           max-height: 700px;
	    }    
	.loginPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.loginPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.loginPage-table th {
        padding: 5px;
        color: #6F6D80;
        font-weight: 600;
        font-size: 15px;
    }
    .loginPage-table td {
        padding: 15px;
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.loginPage-input {
	    height: 40px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 아이디 저장 */
	.save-id {
	    font-size: 14px;
	    height: 20px;
	    width: 20px;
	}
	
	/* 버튼 */
	.btn-loginPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 50px;
        width: 150px;
        margin: auto;
	}
	.btn-logoutPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 50px;
        width: 120px;
        margin: auto;
	}
	
	.btn-loginPage:hover {
	    background-color: #3225A3;
	}
	
</style>
</head>
<body>
      <jsp:include page="../common/menubar.jsp"/> 
      
      <br><br>
      
      <div class="mypagelogin-outer">
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
	            
	                <br>
	                <h2 align="center" class="loginPage-title">로그인</h2>
					
					<table class="loginPage-table">
						<thead>
					    <tr>
					        <th></th>
							<th>&nbsp;아이디&nbsp; <input type="text" name="userId" class="loginPage-input" required value="${ cookie.saveId.value }"></th>
						    <th></th>
						</tr>
						<tr>  
						    <th></th>
						    <th>비밀번호<input type="password" name="userPwd" class="loginPage-input" required></th>
						    <th></th>
						</tr>
						<tr class="save-id" id="idcheck" >
						    <!-- 아이디 저장 -->
							<!-- 로그인 요청 시 아이디 저장 여부를 서버로 같이 넘기기 -->
							
							<th></th>
							<th><input type="checkbox" id="saveId" name="saveId" value="y"><label for="saveId">&nbsp;아이디 저장</label></th>
							<th></th>
							
						</tr>
						</thead>
						<tbody>
					     <tr>
					        <th></th>
					        <td><button type="submit" class="btn-loginPage">로그인</button></td>
					        <th></th>
					      </tr>
					      <tr>   
					        <th></th>
					        <th>
							    <button type="button" class="btn-loginPage"
										    onclick="enrollPage();">&nbsp;회원가입&nbsp;&nbsp;</button>
							    <button type="button" class="btn-loginPage"
							                onclick="searchIdPage();">아이디 찾기</button>
							    <button type="button" class="btn-loginPage"
							                onclick="searchPasswordPage();">비밀번호 찾기</button>
						 	</th>	
				            <th>
				            </th>
						  </tr>
						</tbody>
	                   </table>
					</form>
					<script>  
					function enrollPage() {
						
						// 회원가입페이지로 이동
						location.href = "/know-how/myPage/memberEnrollForm";
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
				<div id="userstudent-info">
					    <br><br>
					    <h2 align="center">마이페이지</h2>
					    <br>
					  <table class="loginPage-table" >
					     <thead>
					      <tr>
							<th></th>
							<th>
                              <h3><b>${ sessionScope.loginUser.userName }</b> 님 환영합니다.</h3>
							</th>
							<th></th>
						  </tr>
						 </thead>
						 <tbody>
						  <tr>
							 <th></th>
							 <th></th>
							 <th></th>
						  </tr>
						  <tr>
						    <th></th>
						    <th>
								<button type="button" class="btn-logoutPage"
													  onclick="myInformationSelectPage();">내정보 조회</button>					  
						    </th>
						    <th></th>
						 </tr>
						 <tr>
						    <th></th>
							<th>
							    <button type="button" class="btn-logoutPage"
									                  onclick="myInformationChangePage();">내정보 수정</button>
						   </th>
						   <th></th>
						 </tr>
						 <tr>
							<th></th>
							<td></td>
							<th></th>
						 </tr>
						 <tr>
						   <th></th>
						   <th>
						       <button type="button" class="btn-logoutPage" 
						               onclick="logout();">로그아웃</button>             
						   </th>
						   <th></th>
						 </tr>
					   </tbody>
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