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
        color: #6F6D80;
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
        width: 120px;
        margin: auto;
	}
	.btn-changePageCheck {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
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
	.btn-enroll:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
  
   <div class="mypage-outer">
	
		<br>
		<h2 align="center">내정보수정</h2>
		<br>

		<form id="counselorInformationChange-form" action="/know-how/myPage/update" method="post">
			<table class="changePage-table">
			  <thead>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 비밀번호</th>
					<th>
						<input type="password" class="changePage-input" name="userPwd" id="userPwd" maxlength="16" placeholder="8~20자리 영문자/숫자" >
					    <div class="errorMessage" id="newUserPwdErrorMessage"></div>
					</th>
					<th></th>
				</tr>
				<tr>
					<th>수정할 비밀번호 확인</th>
					<th>
						<input type="password" class="changePage-input" id="userPwdCheck" name="userPwdCheck" maxlength="20" >
						<div class="errorMessage" id="newUserPwdCheckErrorMessage"></div>
					</th>
					<th></th>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이름</th>
					<th>
						<input type="text" class="changePage-input" name="userName" id="userName" maxlength="6" >
					</th>
					<th></th>
				</tr>
			
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이메일</th>
					<th>
						<input type="email" class="changePage-input" name="email" id="email">
					</th>
					<th>
                        <button type="button" onclick="emailCheck();"
								class="btn btn-secondary btn-sm">이메일 중복확인</button>
                    </th>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 주소</th>
					<th>
						<input type="text" class="changePage-input" name="address" id="address">
					</th>
					<th></th>
				</tr>
                <tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 전화번호</th>
					<th>
						<input type="text" class="changePage-input" name="phone" id="phone" placeholder="-제외하고 입력">
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
				    <th></th>
					<th>
					  <button type="submit" onclick="return validateInformation();" class="btn-changePage">내 정보 수정</button>
					  <button type="reset" class="btn-changePage">초기화</button>
	                </th>
	                <th></th>
				 </tbody>
			</table>

			<br><br>

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