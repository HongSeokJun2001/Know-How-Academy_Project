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

		<div id="myInformationChange-form" >

			<table align="center">
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 비밀번호</th>
					<td>
						<input type="password" id="newUserPwd" maxlength="16" placeholder="8~20자리 영문자/숫자" >
					    <div class="errorMessage" id="newUserPwdErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>수정할 비밀번호 확인</th>
					<td>
						<input type="password" maxlength="20" >
						<div class="errorMessage" id="newUserPwdCheckErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이름</th>
					<td>
						<input type="text" id="newUserName" maxlength="6" >
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이메일</th>
					<td>
						<input type="email" id="newEmail">
					</td>
					<td>
                        <button type="button" onclick="newEmailSend();"
								class="btn btn-secondary btn-sm">인증번호 발송</button>
                    </td>
				</tr>
                <tr>
                   <th>&nbsp;&nbsp;&nbsp;이메일 인증번호</th>
                    <td>
                        <input type="text" id="newCheckNo" >
                    </td>
					<td>
						<button type="button" id="newValidateMail"  onclick="newValidateMail();"
								class="btn btn-secondary btn-sm">인증확인</button>
					</td>
                </tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 주소</th>
					<td>
						<input type="text" id="newAddress">
					</td>
					<td></td>
				</tr>
                <tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 전화번호</th>
					<td>
						<input type="text" id="newPhone" placeholder="-제외하고 입력">
					</td>
					<td></td>
				</tr>
			</table>

			<br><br>

			<div align="center">
				<button type="button" onclick="update();" class="btn btn-primary btn-sm">내 정보 수정</button>
				<button type="reset" class="btn btn-secondary btn-sm">초기화</button>
                <br><br>
			</div>
		 </div>
		 <script>
		     const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).{8,20}$/
		     $(document).ready(function () {
			
		         $("#myInformationChange-form").on("submit", requestUpdate)
		         $("#newUserPwd").on("blur", function () {
		             $('#newUserPwdErrorMessage').text(!passwordRegex.test($(this).val()) ? "8~20자의 영문 대/소문자, 숫자, 특수문자를 사용해야합니다." : "");
		         })
		         $('#newUserPwdCheck').on("blur", function () {
		             $('#newUserPwdCheckErrorMessage').text($(this).val() !== $("#newUserPwd").val() ? "비밀번호와 비밀번호 확인이 일치하지 않습니다" : "");
		         })
		         
		     })
		    function update() {
		    	
		    	// 업데이트 페이지로 이동
		    	location.href="/know-how/myPage/update";
		    }
		     function newValidateMail() {
					
					// 이메일주소와 인증 번호를 서버로 다시 보내서 대조 작업
					$.ajax({
						url : "/know-how/myPage/newValidateMail",
						type : "post", 
						data : {
							email : $("#newEmail").val(),
							checkNo : $("#newCheckNo").val()
						}, 
						success : function(result) {
							
							if(result == "success") {
								// > 대조 성공일 경우
								
								alert("본인 인증에 성공했습니다.");
							
								// 인증 관련 요소들도 다시 disabled (readonly) 상태로 되돌려놓기
								$("#newCheckNo").prop("readonly", true);
								$("#newValidateMail").prop("disabled", true);
								
							} else {
								// > 대조 실패일 경우
								
								alert("본인 인증에 실패했습니다. 다시 진행해 주세요.");
								
								// 인증 관련 요소들도 다시 disabled 상태로 되돌려놓기
								// > 특히, 이미 입력한 인증번호를 초기화까지 시켜줘야함
								$("#newCheckNo").prop("disabled", true).val("");
								$("#newValidateMail").prop("disabled", true);
								
								// 이메일 관련 요소들도 다시 활성화 상태로 되돌리기
								// > 마찬가지로 이미 입력했던 이메일 주소도 초기화 해줘야함
								$("#newEmail").prop("disabled", false).val("");
								$("#newSendMail").prop("disabled", false);
								
							}
							
						},
						error : function() {
							
							console.log("인증번호 대조용 ajax 통신 실패!");
						}
					});
				}
			
				function newSendMail() {
					
					// 인증 번호를 이메일로 전송할 수 있도록 요청
					$.ajax({
						url : "/know-how/myPage/newSendMail",
						type : "post",
						data : {
							email : $("#newEmail").val()
						},
						success : function(result) {
							
							alert(result);
							
							// 인증번호 발급 후 이메일 관련 요소들은 비활성화
							$("#newEmail").prop("readonly", true);
							$("#newSendMail").prop("readonly", true);
							
							// 인증 관련 요소들은 활성화
							$("#newCheckNo").prop("disabled", false);
							$("#newValidateMail").prop("disabled", false);
							
						},
						error : function() {
							
							console.log("인증메일 발송용 ajax 통신 실패!");
						}
					});
				}
		    
		 </script>
		</div> 	
</body>
</html>