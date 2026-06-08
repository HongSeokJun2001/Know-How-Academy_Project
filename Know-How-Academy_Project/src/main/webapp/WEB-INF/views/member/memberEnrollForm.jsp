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

		<form id="enroll-form" >
           <div id="enroll-form">
			<table>
				<tr>
					<th><label for="userId" >* 아이디</label></th>
					<td>
						<input type="text" id="userId" name="userId" maxlength="16" placeholder="8~16자리 영문자/숫자" required>
						<div class="errorMessage" id="userIdErrorMessage"></div>
					</td>
					<td>
						<button type="button" onclick="idCheck();"
								class="btn btn-secondary btn-sm" >중복확인</button>
						
					</td>
				</tr>
				<tr>
					<th><label for="userPwd" >* 비밀번호</label></th>
					<td>
						<input type="password" id="userPwd" name="userPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required>
						<div class="errorMessage" id="userPwdErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th><label for="userPwdCheck" >* 비밀번호</label></th>
					<td>
						<input type="password" id="userPwdCheck" name="userPwdCheck" maxlength="20" required>
						<div class="errorMessage" id="userPwdCheckErrorMessage"></div>
					</td>
					<td></td>
				</tr>
				<tr>
					<th><label for="userName" >* 이름</label></th>
					<td>
						<input type="text" id="userName" name="userName" maxlength="6" required>
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th><label for="email" >* 이메일</label></th>
					<td>
						<input type="email" id="email" name="email" required>
					</td>
					<td>
                        <button type="button" id="sendMail"  onclick="sendMail();"
								class="btn btn-secondary btn-sm">인증번호발송</button>
                    </td>
				</tr>
                <tr>
                   <th><label for="checkNo" >* 이메일 인증번호</label></th>
                    <td>
                        <input type="text" id="checkNo" disabled required>
                    </td>
					<td>
						<button type="button" id="validateMail"  onclick="validateMail();"
								class="btn btn-secondary btn-sm" disabled>인증확인</button>
					</td>
                </tr>
				<tr>
					<th><label for="address">&nbsp;&nbsp;&nbsp;주소</label></th>
					<td>
						<input type="text" id="address" name="address" >
					</td>
					<td></td>
				</tr>
                <tr>
					<th><label for="phone">&nbsp;&nbsp;&nbsp;전화번호</label></th>
					<td>
						<input type="text" id="phone" name="phone" placeholder="-제외하고 입력">
					</td>
					<td></td>
				</tr>
			</table>

			<br><br>

			<div align="center">
				<button type="submit" class="btn btn-primary btn-sm" >회원가입</button>
				<button type="reset" class="btn btn-secondary btn-sm">초기화</button>
                <br><br>
			</div>
           </div>
		</form>

	</div>
	
	<br><br>
	
	<script>
	    const userIdRegex = /^[A-Za-z][A-Za-z0-9]{8,16}$/
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).{8,20}$/
		 $(document).ready(function () {
	
	         $("#enroll-Form").on("submit", requestEnrollForm)
	         $('#userId').on("blur", function () {
	             $('#userIdErrorMessage').text(!userIdRegex.test($(this).val()) ? "영문자로 시작해야 하며 8~16자의 영문자, 숫자,특수문자를 사용해야합니다." : "");
	         });
	         $("#userPwd").on("blur", function () {
	             $('#userPwdErrorMessage').text(!passwordRegex.test($(this).val()) ? "8~20자의 영문 대/소문자, 숫자, 특수문자를 사용해야합니다." : "");
	         })
	         $('#userPwdCheck').on("blur", function () {
	             $('#userPwdCheckErrorMessage').text($(this).val() !== $("#userPwd").val() ? "비밀번호와 비밀번호 확인이 일치하지 않습니다" : "");
	         })
	         
	     })
	     
		function idCheck() {
			
			let $userId = $("#enroll-form input[name=userId]");
		
			$.ajax({
				url : "/know-how/myPage/memberEnrollForm/idCheck",
				type : "get",
				data : { checkId : $userId.val() },
				success : function(result) {
					
					if(result == "NNNNN") {
						// > 사용 불가한 아이디일 경우
						
						alert("이미 사용중이거나 탈퇴한 회원의 아이디입니다.");
						
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
			
		}
		
        function validateMail() {
			
			// 이메일주소와 인증 번호를 서버로 다시 보내서 대조 작업
			$.ajax({
				url : "/know-how/myPage/validateMail",
				type : "post", 
				data : {
					email : $("#email").val(),
					checkNo : $("#checkNo").val()
				}, 
				success : function(result) {
					
					if(result == "success") {
						// > 대조 성공일 경우
						
						alert("본인 인증에 성공했습니다.");
					
						// 인증 관련 요소들도 다시 disabled (readonly) 상태로 되돌려놓기
						$("#checkNo").prop("readonly", true);
						$("#validateMail").prop("disabled", true);
						
					} else {
						// > 대조 실패일 경우
						
						alert("본인 인증에 실패했습니다. 다시 진행해 주세요.");
						
						// 인증 관련 요소들도 다시 disabled 상태로 되돌려놓기
						// > 특히, 이미 입력한 인증번호를 초기화까지 시켜줘야함
						$("#checkNo").prop("disabled", true).val("");
						$("#validateMail").prop("disabled", true);
						
						// 이메일 관련 요소들도 다시 활성화 상태로 되돌리기
						// > 마찬가지로 이미 입력했던 이메일 주소도 초기화 해줘야함
						$("#email").prop("disabled", false).val("");
						$("#sendMail").prop("disabled", false);
						
					}
					
				},
				error : function() {
					
					console.log("인증번호 대조용 ajax 통신 실패!");
				}
			});
		}
	
		function sendMail() {
			
			// 인증 번호를 이메일로 전송할 수 있도록 요청
			$.ajax({
				url : "/know-how/myPage/sendMail",
				type : "post",
				data : {
					email : $("#email").val()
				},
				success : function(result) {
					
					alert(result);
					
					// 인증번호 발급 후 이메일 관련 요소들은 비활성화
					$("#email").prop("readonly", true);
					$("#sendMail").prop("readonly", true);
					
					// 인증 관련 요소들은 활성화
					$("#checkNo").prop("disabled", false);
					$("#validateMail").prop("disabled", false);
					
				},
				error : function() {
					
					console.log("인증메일 발송용 ajax 통신 실패!");
				}
			});
		}
		
		function requestEnrollForm() {
			
			let $userId = $("#enroll-form input[name=userId]");
			let $userPwd = $("#enroll-form input[name=userPwd]");
			let $userName = $("#enroll-form input[name=userName]");
			let $email = $("#enroll-form input[name=email]");
			let $address = $("#enroll-form input[name=address]");
			let $phone = $("#enroll-form input[name=phone]");
			
            $.ajax({
                url: "/know-how/myPage/memberEnrollForm/insert",
                type: "POST",
                data: {
                	userId : $userId.val(),
                	userPwd : $userPwd.val(),
                	userName : $userName.val(),
                	email : $email.val(),
                	address : $address.val(),
                	phone : $pnone.val()
                },
                success: function() {
                	
                    alert("회원가입이 완료되었습니다.");
                    
                },
                error: function() {
                	
                    console.log("회원가입 발송용 ajax 통신 실패!");
                }
            })
        }
		
	</script>

</body>
</html>