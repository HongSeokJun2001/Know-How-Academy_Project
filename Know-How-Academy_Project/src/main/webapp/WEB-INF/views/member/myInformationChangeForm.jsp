<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="mypage-outer">
	
		<br>
		<h2 align="center">내정보수정</h2>
		<br>

		<form id="myInformationChange-form" action="/know-how/myPage/update" method="post">
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
	        		let userPwd = $("input[name=userPwd]").val();
	        		let userPwdCheck = $("input[name=userPwdCheck]").val();
	        		let email = $("input[name=email]").val();
	        		let emailCheck = $("button[name=emailCheck]").val();
	        		
	        		// 두 값이 일치하면 기본이벤트를 살리고, 두 값이 일치하지 않으면 기본이벤트를 제거할 것
	        		if(userPwd != userPwdCheck) {
	        			
	        			alertify.alert("비밀번호가 일치하지 않습니다.");
	        			
	        			return false;
	        		} 
	        		
	        		return true;
	        	}
		     
		    function emailCheck() {
				
				let $email = $("#myInformationChange-form input[name=email]");
			
				$.ajax({
					url : "/know-how/myPage/emailCheck",
					type : "get",
					data : { checkEmail : $emailCheck.val() },
					success : function(result) {
						
						if(result == "NNNNN") {
							// > 사용 불가한 아이디일 경우
							
							alert("이미 사용중인 이메일입니다.");
							
							// 아이디 재입력 유도
							$email.focus();
							
						} else {
							// > 사용 가능한 아이디일 경우
							
							if(confirm("사용 가능한 이메일입니다. 사용하시겠습니까?")){
								
								// 이메일값을 확정 (다시는 수정 못하게)
								$email.prop("readonly", true);
								
							} else {
								// > 사용하지 않겠다고 의사를 밝힌 경우 (취소 버튼 클릭 시)
								
								// 아이디 재입력 유도
								$email.focus();
							}
						}
					},
					error : function() {
						
						console.log("이메일 중복체크용 ajax 통신 실패!");
					}
				});	
			
		      }
		    
		 </script>
		</div> 	
</body>
</html>