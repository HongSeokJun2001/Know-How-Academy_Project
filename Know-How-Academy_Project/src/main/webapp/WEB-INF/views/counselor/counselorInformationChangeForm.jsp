<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
  
   <div class="mypage-outer">
	
		<br>
		<h2 align="center">내정보수정</h2>
		<br>

		<form id="counselorInformationChange-form" action="/know-how/myPage/update" method="post">
			<table align="center">
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 비밀번호</th>
					<td>
						<input type="password" name="userPwd" id="userPwd" maxlength="16" placeholder="8~20자리 영문자/숫자" >
					    <div class="errorMessage" id="newUserPwdErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>수정할 비밀번호 확인</th>
					<td>
						<input type="password" id="userPwdCheck" name="userPwdCheck" maxlength="20" >
						<div class="errorMessage" id="newUserPwdCheckErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이름</th>
					<td>
						<input type="text" name="userName" id="userName" maxlength="6" >
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이메일</th>
					<td>
						<input type="email" name="email" id="email">
					</td>
					<td>
                        <button type="button" onclick="emailCheck();"
								class="btn btn-secondary btn-sm">이메일 중복확인</button>
                    </td>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 주소</th>
					<td>
						<input type="text" name="address" id="address">
					</td>
					<td></td>
				</tr>
                <tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 전화번호</th>
					<td>
						<input type="text" name="phone" id="phone" placeholder="-제외하고 입력">
					</td>
					<td></td>
				</tr>
			</table>

			<br><br>

			<div align="center">
				<button type="submit" onclick="return validateInformation();" class="btn btn-primary btn-sm">내 정보 수정</button>
				<button type="reset" class="btn btn-secondary btn-sm">초기화</button>
                <br><br>
			</div>
		 </form>
		 <script>
		     const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).{8,20}$/
		     $(document).ready(function () {
			
		         $("#userPwd").on("blur", function () {
		             $('#userPwdErrorMessage').text(!passwordRegex.test($(this).val()) ? "8~20자의 영문 대/소문자, 숫자, 특수문자를 사용해야합니다." : "");
		         })
		         $('#userPwdCheck').on("blur", function () {
		             $('#userPwdCheckErrorMessage').text($(this).val() !== $("#userPwd").val() ? "비밀번호와 비밀번호 확인이 일치하지 않습니다" : "");
		         })
		         
		     })
		     
		     function validateInformation() {
	        		
	        		// 우선 변경할 비밀번호와 변경할 비밀번호 재입력값을 변수에 담아오기
	        		let userPwd = $("#counselorInformationChange-form input[name=userPwd]").val();
	        		let userPwdCheck = $("#counselorInformationChange-form input[name=userPwdCheck]").val();
	        		let email = $("#counselorInformationChange-form input[name=email]").val();
	        		let emailCheck = $("#counselorInformationChange-form button[name=emailCheck]").val();
	        		
	        		// 두 값이 일치하면 기본이벤트를 살리고, 두 값이 일치하지 않으면 기본이벤트를 제거할 것
	        		if(userPwd != userPwdCheck) {
	        			
	        			alertify.alert("비밀번호가 일치하지 않습니다.");
	        			
	        			return false;
	        		} 
	        		
	        		return true;
	        	}
		  </script>
	</div>
</body>
</html>