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

   <div class="outer">
    <form id="searchPassword-form"> 
		            
               <br><br>
               
			<table id="login-page" align="center">
				<tr>
					<h2 align="center">비밀번호 찾기</h2>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="userName" >
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="email" name="email" >
					</td>
					<td>
                        <button type="button" onclick="emailSend();"
								class="btn btn-secondary btn-sm">인증번호발송</button>
                    </td>
				</tr>
				<tr align="center">
					<th>이메일인증확인</th>
					<td>
						<input type="email" name="email">
					</td>
					<td>
						<button type="button" onclick="emailKeyCheck();"
								class="btn btn-secondary btn-sm">인증확인</button>
					</td>
				</tr>
				<tr>
					<th>
						<br>
					</th>
				</tr>
			    <tr>
					<th></th>
					<td align="center">
			            <button type="button" class="btn btn-secondary btn-sm">비밀번호 찾기</button>
			            <button type="button" class="btn btn-secondary btn-sm">확인</button>
			            <%-- 이름 아이디 + 이메일 일치확인 후 창에 비밀번호 값 띄워주고 
			                 확인 버튼 누르면 사라지게 해야됨 아직 기능 구현 x --%>
			        </td>
			    </tr>
			    <tr align="center">
			        <th colspan="3">
			           ----------------------------------------------------------
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
						                      onclick="myPage();">로그인</button>
						<button type="button" class="btn btn-secondary btn-sm"
						                      onclick="searchIdPage();">아이디 찾기</button>					  
					</th>
				</tr>
				<tr>
					<th><br><br></th>
				</tr>
			</table>
			
		</form>	
		
		<script>
			function enrollPage() {
				
				// 회원가입페이지로 이동
				location.href = "/know-how/member/myPage/enrollForm";
				// GET 방식
			}
		</script>
		
		<script>
			function myPage() {
				
				// 마이페이지로 이동
				location.href = "/know-how/member/myPage";
				// GET 방식
			}
		</script>
		    
		<script>
			function searchIdPage() {
				
				// 아이디찾기페이지로 이동
				location.href = "/know-how/member/myPage/searchIdForm";
				// GET 방식
			}
		</script>
	 </div>	
</body>
</html>