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
    .mypagesearchPassword-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 600px;
           margin: auto;
	    }
	.searchPasswordPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.searchPasswordPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.searchPasswordPage-table th {
        padding: 5px;
        color: #6F6D80;
        font-weight: 600;
        font-size: 15px;
    }
    .searchPasswordPage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.searchPasswordPage-input {
	    height: 40px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-searchPasswordPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 40px;
        width: 130px;
        margin: auto;
	}
	
	.btn-searchPasswordPage:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

   <br><br>
   
   <div class="mypagesearchPassword-outer">
     
       <div class="login-area"> 
               
           <form id="searchPassword-form" action="/know-how/myPage/searchPassword" method="post">
			
				<br><br>
				<h2 align="center" class="searchPasswordPage-title">비밀번호 찾기</h2>
				<br>
				
				<table class="searchPasswordPage-table">
				   <thead>
					<tr>
						<th></th>
						<th>
						    <label for="userId">&nbsp;아이디</label>
							<input type="text" class="searchPasswordPage-input" name="userId" id="userId" required>
						</th>
						<th></th>
					</tr>
					<tr>
						<th></th>
						<th>
						    <label for="userName">&nbsp;&nbsp;이름&nbsp;&nbsp;&nbsp;</label>
							<input type="text" class="searchPasswordPage-input" name="userName" id="userName" required>
						</th>
						<th></th>
					</tr>
					<tr>
						<th></th>
						<th>
						    <label for="email">&nbsp;이메일</label>
							<input type="email" class="searchPasswordPage-input" name="email" id="email" required>
						</th>
						<th></th>
					</tr>
					<tr>
						<th>
						</th>
					</tr>
				    <tr>
						<th></th>
						<th>
				            <button type="submit" class="btn-searchPasswordPage">비밀번호 찾기</button>
				        </th>
				        <th></th>
				    </tr>
				    </thead>
				    <tbody>
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
							<button type="button" class="btn-searchPasswordPage"
												  onclick="enrollPage();">회원가입</button>
							<button type="button" class="btn-searchPasswordPage"
							                      onclick="myPage();">로그인</button>
							<button type="button" class="btn-searchPasswordPage"
							                      onclick="searchIdPage();">아이디 찾기</button>					  
						</th>
						<th></th>
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
		
			function myPage() {
				
				// 마이페이지로 이동
				location.href = "/know-how/myPage";
				// GET 방식
			}
		
			function searchIdPage() {
				
				// 아이디찾기페이지로 이동
				location.href = "/know-how/myPage/searchIdForm";
				// GET 방식
			}
			
		</script>
	   </div>
	 </div>	
</body>
</html>