<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정</title>
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
						<input type="password" name="newUserPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" >
					</td>
					<td></td>
				</tr>
				<tr>
					<th>수정할 비밀번호 확인</th>
					<td>
						<input type="password" maxlength="20" >
					</td>
					<td></td>
				</tr>
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이름</th>
					<td>
						<input type="text" name="newUserName" maxlength="6" >
					</td>
					<td></td>
				</tr>
			
				<tr>
					<th>&nbsp;&nbsp;&nbsp;수정할 이메일</th>
					<td>
						<input type="email" name="newEmail" >
					</td>
					<td>
                        <button type="button" onclick="emailSend();"
								class="btn btn-secondary btn-sm">인증번호 발송</button>
                    </td>
				</tr>
                <tr>
                   <th>&nbsp;&nbsp;&nbsp;이메일 인증번호</th>
                    <td>
                        <input type="email" name="newEmailkey" >
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
		 </form>
		</div> 	
</body>
</html>