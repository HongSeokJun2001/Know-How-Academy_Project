<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    .mypagelogout-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 600px;
           max-height: 700px;
           margin: auto;
	    }
	.logoutPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.logoutPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.logoutPage-table th {
        padding: 5px;
        color: black;
        font-weight: 600;
        font-size: 15px;
    }
    .logoutPage-table td {
        padding: 15px;
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.logoutPage-input {
	    height: 40px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
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
        width: 150px;
        margin: auto;
	}
	.btn-logoutPageInformation {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        font-size: 20px;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 50px;
        width: 250px;
        margin: auto;
	}
	
	.btn-logoutPage:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
    
    <br><br>
    
    <div class="mypagelogout-outer">
	 <!-- 직원계정 로그인 시 -->
	   <br>
       <h2 align="center" class="loginPage-title">마이페이지</h2>
        <br>
        <div id="user-info">	
		 <table class="logoutPage-table">
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
					<button type="button" class="btn-logoutPageInformation"
							onclick="counselorInformationSelectPage();">내 정보 조회</button>					  
			    </th>
			    <th></th>
			 </tr>
			 <tr>
			    <th></th>
				<th>
				    <button type="button" class="btn-logoutPageInformation"
						    onclick="counselorInformationChangePage();">내 정보 수정</button>
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
				<th></th>
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
		function counselorInformationSelectPage() {
			
			// 내정보 조회 페이지로 이동
			location.href = "/know-how/myPageCounselor/counselorInformationSelectForm";
			// GET 방식
		}
	    
		function counselorInformationChangePage() {
			
			// 내정보 수정 페이지로 이동
			location.href = "/know-how/myPageCounselor/counselorInformationChangeForm";
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