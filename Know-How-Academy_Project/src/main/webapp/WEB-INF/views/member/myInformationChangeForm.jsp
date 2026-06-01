<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="mypage-outer">
	
		<br>
		<h2 align="center">내정보수정</h2>
		<br>

		<!-- 
			* 회원가입 기능 구현
			- 아이디 ~ 주소까지 입력 후 회원가입 버튼 클릭 시
			
			http://localhost:8006/myweb/member/insert 로 요청 (POST 방식으로)
			
			- 단, 회원가입 버튼 클릭 시 곧바로 요청이 들어가면 안됨!!
			  validate 함수를 거쳐가야함!! (사용자가 입력한 값들이 유효한지 정규표현식 등으로 검사)
		-->
		<form id="enroll-form" action="/know-how/member/update" method="post">

			<!--
				* 회원가입 시 입력받아야 하는 것들
				- 아이디, 비번, 이름, 전화번호, 이메일, 주소
				- 아이디, 비번, 이름은 "필수입력사항"
			-->

			<table>
				<tr>
					<th>수정할 비밀번호</th>
					<td>
						<input type="password" name="newUserPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>수정할 비밀번호 확인</th>
					<td>
						<input type="password" maxlength="20" required>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>수정할 이름</th>
					<td>
						<input type="text" name="newUserName" maxlength="6" required>
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th>수정할 이메일</th>
					<td>
						<input type="email" name="newEmail" required>
					</td>
					<td>
                        <button type="button" onclick="emailSend();"
								class="btn btn-secondary btn-sm">인증번호 발송</button>
                    </td>
				</tr>
                <tr>
                   <th>이메일 인증번호</th>
                    <td>
                        <input type="email" name="newEmailkey" required>
                    </td>
					<td>
						<button type="button" onclick="emailKeyCheck();"
								class="btn btn-secondary btn-sm">인증확인</button>
					</td>
                </tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 주소</th>
					<td>
						<input type="text" name="newAddress">
					</td>
					<td></td>
				</tr>
                <tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 전화번호</th>
					<td>
						<input type="text" name="newPhone" placeholder="-제외하고 입력">
					</td>
					<td></td>
				</tr>
			</table>

			<br><br>

			<div align="center">
				<button type="submit" class="btn btn-primary btn-sm" disabled>내 정보 수정</button>
				<button type="reset" class="btn btn-secondary btn-sm">초기화</button>
                <br><br>
			</div>
</body>
</html>