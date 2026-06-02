<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
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

		<!-- 
			* 회원가입 기능 구현
			http://localhost:8006/know-how/member/myPage/insert 로 요청 (POST 방식으로)
			
			- 회원가입 클릭 시 validate 함수를 거쳐감. (사용자가 입력한 값들이 유효한지 정규표현식 등으로 검사)
		-->
		<form id="enroll-form" action="/know-how/member/myPage/insert" method="post">

			<table>
				<tr>
					<th>* 아이디</th>
					<td>
						<input type="text" name="userId" maxlength="16" placeholder="8~16자리 영문자/숫자" required>
					</td>
					<td>
						<button type="button" onclick="idCheck();"
								class="btn btn-secondary btn-sm">중복확인</button>
						
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td>
						<input type="password" name="userPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td>
						<input type="password" maxlength="20" required>
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
                        <button type="button" onclick="emailSend();"
								class="btn btn-secondary btn-sm">인증번호발송</button>
                    </td>
				</tr>
                <tr>
                   <th>* 이메일 인증번호</th>
                    <td>
                        <input type="email" name="emailkey" required>
                    </td>
					<td>
						<button type="button" onclick="emailKeyCheck();"
								class="btn btn-secondary btn-sm">인증확인</button>
					</td>
                </tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;주소</th>
					<td>
						<input type="text" name="address">
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
				url : "/know-how/member/myPage/idCheck",
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
							
							// 회원가입 버튼 활성화
							$("#enroll-form button[type=submit]").removeAttr("disabled");
							
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
	</script>

</body>
</html>