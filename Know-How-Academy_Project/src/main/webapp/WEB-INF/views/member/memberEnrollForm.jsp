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
    .enrollForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 700px;
           margin: auto;
	    }
	.enrollPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.enrollPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.enrollPage-table th {
        padding: 5px;
        color: black;
        font-weight: 500;
        font-size: 15px;
    }
    .enrollPage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.enrollPage-input {
	    height: 30px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-enrollPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 40px;
        width: 120px;
        margin: auto;
	}
	.btn-enrollPageCheck {
	    background-color: coral; 
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 400;
        transition: background 0.1s;
        height: 40px;
        width: 140px;
        margin: auto;
        font-size: 15px;
      
	}
	.btn-enrollPage:hover {
	    background-color: #3225A3;
	}
	.btn-enrollPageCheck:hover {
	    background-color: lightcoral;
	}
	button:disabled {
	     opacity : 0.6;
	     
	}
</style>
</head>
<body>

     <jsp:include page="../common/menubar.jsp" />
     
     <br><br>
     
     <div class="enrollForm-outer">

		 <form id="enroll-form" action="/know-how/myPage/memberEnrollForm/insert" method="post">
		          <br>
		          <h2 align="center" class="enrollPage-title">회원가입</h2>
	              <br><br>
			<table class="enrollPage-table">
			    <thead>
				<tr>
					<th><label for="userId">* 아이디</label></th>
					<th>
						<input type="text" class="enrollPage-input" name="userId" 
						minlength="8" maxlength="16" pattern="(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+" 
						title="8~16자리 영문자/숫자" placeholder="8~16자리 영문자/숫자" required>
								
					</th>
					<th><button type="button" id="idCheckBtn" onclick="idCheck();"
								class="btn-enrollPageCheck" >중복확인</button></th>		
				</tr>
				<tr>
					<th><label for="userPwd">* 비밀번호</label></th>
					<th>
						<input type="password" class="enrollPage-input" name="userPwd" 
						minlength="8" maxlength="20" pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*\(\)_+=\-])[a-zA-Z\d!@#$%^&*\(\)_+=\-]+$" 
						title="8~20자리 영문자/숫자/특수문자 포함" placeholder="8~20자리 영문자/숫자/특수문자 포함" autocomplete="new-password" required>
					    
					</th>
					<th></th>
				</tr>
				<tr>
					<th><label for="userPwd">* 비밀번호 확인</label></th>
					<th>
						<input type="password" class="enrollPage-input" name="userPwdCheck" autocomplete="new-password" required>
						
					</th>
					<th></th>
				</tr>
				<tr>
					<th><label for="userName">* 이름</label></th>
					<th>
					    
						<input type="text" class="enrollPage-input" name="userName" 
						minlength="2" maxlength="10" pattern="[가-힣]+" title="한글 2~10자리" placeholder="한글 2~10자리" required>
					</th>
					<th></th>
				</tr>
			
				<tr>
					<th><label for="email">* 이메일</label></th>
					<th>
						<input type="email" class="enrollPage-input" name="email" required>
					</th>
					<th><button type="button" id="emailCheckBtn" onclick="emailCheck();"
								class="btn-enrollPageCheck" hover disabled>이메일중복확인</button>
					</th>
				</tr>
				<tr>
					<th><label for="address">주소</label></th>
					<th>
						<input type="text" class="enrollPage-input" 
						  maxlength="100" name="address">
					</th>
					<th></th>
				</tr>
                <tr>
					<th><label for="phone">전화번호</label></th>
					<th>
						<input type="text" class="enrollPage-input" name="phone" 
						pattern="[0-9]+" minlength="11" maxlength="11" placeholder="-제외하고 입력">
					</th>
					<th></th>
				</tr>
				<tr>
				   <th></th>
				   <td></td>
				   <th></th>
				</tr>
				<thead>
				<tbody>
				  <tr>
				   <th></th>
				   <th></th>
				   <th></th>
				  </tr>
				   <tr>
				     <th></th>
				     <th>
				        <button type="submit" class="btn-enrollPage" onclick="return validateForm();" disabled>회원가입</button>
				        <button type="reset" class="btn-enrollPage" onclick="resetForm();">초기화</button>
				     </th>
                     <th></th>
                   <tr>
				</tbody>
			</table>

			<br><br>
          
		</form>
      </div>
	
	<br><br>
	
	<script>
		function idCheck() {
			
			let $userId = $("#enroll-form input[name=userId]");
		
			if($userId[0].checkValidity() === false){
			   $userId[0].reportValidity();
			   return;
			} 

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
							$("#idCheckBtn").attr("disabled", true);
							$("#emailCheckBtn").removeAttr("disabled");
							alertify.alert("이메일인증버튼이 활성화되었습니다.");
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
			function emailCheck() {
				
			let $email = $("#enroll-form input[name=email]");
			
			if($email[0].checkValidity() === false){
			   $email[0].reportValidity();
			   return;
			} 

			$.ajax({
				url : "/know-how/myPage/emailCheck",
				type : "get",

				
				data : { checkEmail : $email.val() },
				success : function(result) {
					
					if(result == "NNNNN") {
						// > 사용 불가한 이메일일 경우
						
						alert("이미 사용중인 이메일입니다.");
						
						// 이메일 재입력 유도
						$email.focus();
						
					} else {
						// > 사용 가능한 이메일일 경우
						
						if(confirm("사용 가능한 이메일입니다. 사용하시겠습니까?")){
							
							// 이메일값을 확정 (다시는 수정 못하게)
							$email.prop("readonly", true);
							$("#emailCheckBtn").attr("disabled", true);
							// 회원가입 버튼 활성화
							$("#enroll-form button[type=submit]").removeAttr("disabled");
							alertify.alert("회원가입버튼이 활성화되었습니다.");
						} else {
							// > 사용하지 않겠다고 의사를 밝힌 경우 (취소 버튼 클릭 시)
							
							// 이메일 재입력 유도
							$email.focus();
						}
					}
				},
				error : function() {
					
					console.log("이메일 중복체크용 ajax 통신 실패!");
				}
			});	
			
		}

	    function validateForm() {
		
			if($("#enroll-form input[name=userPwd]").val() != $("#enroll-form input[name=userPwdCheck]").val()) {
				
				alertify.alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
		}

		function resetForm() {
				
			$("#enroll-form input[name=userId]").prop("readonly", false);
			$("#idCheckBtn").removeAttr("disabled");
		}
	</script>

</body>
</html>