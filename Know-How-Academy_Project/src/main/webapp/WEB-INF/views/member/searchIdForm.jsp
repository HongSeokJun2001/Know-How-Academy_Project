<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   #searchId-form table {
		margin : auto;
	}
	#searchId-form input {
         padding : 5px;
		 margin : 5px;
		 width : 250px;
	}
	#searchId-form button {
		 padding : 5px;
		 margin : 5px;
		 width : 100px;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <form id="searchId-form" action="/know-how/member/myPage/login" method="post"> 
		            
	                <br><br>
	                
					<table id="login-page" align="center">
						<tr>
							<h2 align="center">아이디 찾기</h2>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="text" name="userName" placeholder="이름" >
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="email" name="email" placeholder="이메일">
							</td>
						</tr>
						<tr>
							<th>
								<br>
							</th>
						</tr>
					    <tr>
					        <th colspan="3">
					            <button type="button" class="btn btn-secondary btn-sm">확인</button>
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
								                      onclick="loginPage();">로그인</button>
								<button type="button" class="btn btn-secondary btn-sm"
								                      onclick="searchPasswordPage();">비밀번호 찾기</button>					  
							</th>
						</tr>
						<tr>
							<th><br><br></th>
						</tr>
					</table>
</body>
</html>