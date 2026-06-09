<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
    
    <br><br>
    
    <div class="mypage-outer">
	 <!-- 직원계정 로그인 시 -->	

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
										  onclick="counselorMyInformationSelectPage();">내정보 조회</button>					  
			    </th>
			 </tr>
			 <tr align="center">
				<th>
				    <button type="button" class="btn btn-secondary btn-sm"
						                  onclick="counselorMyInformationChangePage();">내정보 수정</button>
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
		function counselorMyInformationSelectPage() {
			
			// 내정보 조회 페이지로 이동
			location.href = "/know-how/myPageCounselor/counselorMyInformationSelectForm";
			// GET 방식
		}
	    
		function counselorMyInformationChangePage() {
			
			// 내정보 수정 페이지로 이동
			location.href = "/know-how/myPageCounselor/counselorMyInformationChangeForm";
			// GET 방식
		}
	    
		function logout() {
			
			// 로그아웃
			location.href = "/know-how/myPage/logout";
			// GET 방식
		}
	    </script> 
	    </div>
	 </div>
</body>
</html>