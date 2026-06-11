<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    #enroll-form table {
		margin : auto;
	}

	#enroll-form input {
		padding : 5px;
		margin : 5px;
		width : 300px;
	}
</style>
</head>
<body>

     <jsp:include page="../common/menubar.jsp" />
     
     <div class="mypage-outer">
	
		<br>
		<h2 align="center">회원가입</h2>
		<br>

		 <form id="enroll-form" action="/know-how/myPage/memberEnrollForm/insert" method="post">
		   
			<table>
				<tr>
					<th>* 아이디</th>
					<td>
						<input type="text" name="userId" maxlength="16" placeholder="8~16자리 영문자/숫자" required>
						<div class="errorMessage" id="userIdErrorMessage"></div>
					</td>
					<td>
						<button type="button" onclick="idCheck();"
								class="btn btn-secondary btn-sm" >중복확인</button>
						
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td>
						<input type="password" name="userPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" autocomplete="new-password" required>
						<div class="errorMessage" id="userPwdErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td>
						<input type="password" name="userPwdCheck" maxlength="20" required>
						<div class="errorMessage" id="userPwdCheckErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td>
						<input type="text" name="userName" maxlength="6" required>
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th>* 이메일</th>
					<td>
						<input type="email" name="email" required>
					</td>
					<td>
                        <button type="button" onclick="emailCheck();"
								class="btn btn-secondary btn-sm" required>이메일중복확인</button>
                    </td>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;주소</th>
					<td>
						<input type="text" name="address" >
					</td>
					<td></td>
				</tr>
                <tr>
					<th>&nbsp;&nbsp;&nbsp;전화번호</th>
					<td>
						<input type="text" name="phone" placeholder="-제외하고 입력">
					</td>
					<td></td>
				</tr>
			</table>

			<br><br>

			<div align="center">
				<button type="submit" class="btn btn-primary btn-sm" disabled>회원가입</button>
				<button type="reset" class="btn btn-secondary btn-sm">초기화</button>
                <br><br>
			</div>
          
		</form>
      </div>
	
	<br><br>
	
	<script>
		function idCheck() {
			
			let $userId = $("#enroll-form input[name=userId]");
		
			$.ajax({
				url : "/know-how/myPage/memberEnrollForm/idCheck",
				type : "get",
				data : { checkId : $userId.val() },
				success : function(result) {
					
					if(result == "NNNNN") {
						// > 사용 불가한 아이디일 경우
						
						alert("이미 사용중인 아이디입니다.");
						
						// 아이디 재입력 유도
						$userId.focus();
						
					} else {
						// > 사용 가능한 아이디일 경우
						
						if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")){
							// > 사용하겠다고 의사를 밝힌 경우 (확인 버튼 클릭 시)
							
							// 아이디값을 확정 (다시는 수정 못하게)
							$userId.prop("readonly", true);
							
						} else {
							// > 사용하지 않겠다고 의사를 밝힌 경우 (취소 버튼 클릭 시)
							
							// 아이디 재입력 유도
							$userId.focus();
						}
					}
				},
				error : function() {
					
					console.log("아이디 중복체크용 ajax 통신 실패!");
				}
			});
			
			function emailCheck() {
				
				let $email = $("#enroll-form input[name=email]");
			
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
								
								// 회원가입 버튼 활성화
								$("#enroll-form button[type=submit]").removeAttr("disabled");
								
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

</body>
</html>