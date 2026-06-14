<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    .changeForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 700px;
           margin: auto;
	    }
	.changePage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.changePage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.changePage-table th {
        padding: 5px;
        color: black;
        font-weight: 500;
        font-size: 15px;
    }
    .changePage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.changePage-input {
	    height: 30px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-changePage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 40px;
        width: 140px;
        margin: auto;
  
	}
	.btn-changePageCheck {
	    background-color: coral; 
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 400;
        transition: background 0.1s;
        height: 40px;
        width: 130px;
        margin: auto;
        font-size: 14px;
      
	}
	.btn-enroll:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
   <br><br>
   
   <div class="changeForm-outer">
	
		<br>
		<h2 align="center" class="changePage-title">내정보수정</h2>
		<br>

		<form id="counselorInformationChange-form" action="/know-how/myPage/update" method="post">
			<table class="changePage-table">
			  <thead> 
				<tr>
					<th><label for="password">수정할 비밀번호</label></th>
					<th>
						<input type="password" class="changePage-input" name="userPwd"  
						minlength="8" maxlength="20" pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*\(\)_+=\-])[a-zA-Z\d!@#$%^&*\(\)_+=\-]+$" 
						title="8~20자리 영문자/숫자/특수문자 포함" placeholder="8~20자리 영문자/숫자/특수문자 포함" autocomplete="new-password">
					    <div class="errorMessage" id="newUserPwdErrorMessage"></div>
					</th>
					<th></th>
				</tr>
				<tr>
					<th><label for="password">수정할 비밀번호 재확인</label></th>
					<th>
						<input type="password" class="changePage-input" id="userPwdCheck" name="userPwdCheck" 
						autocomplete="new-password" maxlength="20" >
						<div class="errorMessage" id="newUserPwdCheckErrorMessage"></div>
					</th>
					<th></th>
				</tr>
				<tr>
					<th><label for="userName">수정할 이름</label></th>
					<th>
						<input type="text" class="changePage-input" name="userName" 
						minlength="2" maxlength="10" pattern="[가-힣]+" title="한글 2~10자리" placeholder="한글 2~10자리" >
					</th>
					<th></th>
				</tr>
			    <tr>
					<th><label for="email">수정할 휴대전화 번호</label></th>
					<th>
						<input type="text" class="changePage-input" name="phone" 
						       pattern="[0-9]+" minlength="11" maxlength="11"
						       value="${ sessionScope.loginUser.phone }" placeholder="-제외하고 입력">
					</th>
					<th></th>
				</tr>
				<tr>
					<th><label for="email">수정할 이메일</label></th>
					<th>
						<input type="email" class="changePage-input" name="email" >
					</th>
					<th>
                        <button type="button" id="emailCheckBtn" onclick="emailCheck();"
								class="btn-changePageCheck">이메일 중복확인</button>
                    </th>
				</tr>
				<tr>
					<th><label for="address">수정할 주소</label></th>
					<th>
						<input type="text" class="changePage-input" name="address"  
						value="${ sessionScope.loginUser.address }">
					</th>
					<th></th>
				</tr>
				<tr>
				   <th></th>
				   <td></td>
				   <th></th>
				</tr>
			  </thead>
			  <tbody>
			    <tr>
				   <th></th>
				   <th><input type="hidden" name="userId" value="${ sessionScope.loginUser.userId }"></th>
				   <th></th>
				</tr>
				<tr>
				<th></th>
				<th>
				    <button type="submit" onclick="return validateInformation();" class="btn-changePage">내 정보 수정</button>
				    <button type="reset" class="btn-changePage">초기화</button>
				</th>
                <th></th>
				</tr>
			  </tbody>
			</table>

			<br><br>

		 </form>
		 <script>
		 function emailCheck() {
				
				let $email = $("#counselorInformationChange-form input[name=email]");
				
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
					
				if($("#counselorInformationChange-form input[name=userPwd]").val() != $("#counselorInformationChange-form input[name=userPwdCheck]").val()) {
						
					alertify.alert("비밀번호가 일치하지 않습니다.");
					return false;
				}
			  }
	
			  function resetForm() {
						
				$("#counselorInformationChange-form input[name=userId]").prop("readonly", false);
				$("#idCheckBtn").removeAttr("disabled");
			  }
		     
		  </script>
	</div>
</body>
</html>