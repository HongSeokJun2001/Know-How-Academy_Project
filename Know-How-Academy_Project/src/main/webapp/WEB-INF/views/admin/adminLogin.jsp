<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	 * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', sans-serif;
    }

    html, body {
        width: 100%;
        height: 100%;
        background-color: #F8F9FA;
        color: #2C2A38;
        overflow: hidden;
    }

    #fake-header {
        width: 100%;
        height: 60px;
        background-color: #4233C7; 
        color: white;

        display: flex;
        align-items: center;

        padding: 0 24px;

        font-size: 18px;
        font-weight: 700;

        position: fixed;
        top: 0;
        left: 0;

        z-index: 1000;
    }

    #fake-header img {
        width: 36px;
        height: 36px;
        object-fit: contain;
    }

	.login-card {
        width: 800px;
        height: 450px;
		margin : 250px auto;
		padding : 40px;
        background-color : #fff;
		border : 1px solid #e5e7ed;
		border-radius : 14px;
		box-shadow : 0 4px 14px rgba(17, 12, 39, 0.06); 
        text-align: center; 
        justify-content: center; 
        align-items: center;
	}

    .login-card table {
        margin: 0 auto;
    }

    .login-card input {
        width: 300px;
        padding: 5px;
        border-radius: 4px;
        border: 1px solid red;
    }

    .login-card th{
        text-align: left;
        padding: 8px 0 4px 0;
        font-size: 14px;
    }

    .login-card p {
        font-size: 12px;
        color: #888;
        text-align: left;
        margin-left: 8px;
    }

    .login-card button {
        background-color: rgb(40, 40, 241);
        color: white;
        border: none;
        padding: 10px 130px;
        border-radius: 15px;
        cursor: pointer;
        box-shadow : 0 2px 5px rgba(0, 0, 0, 0.61); 
    }

    .login-card a {
        color: black;
        text-decoration: none;
        font-size: 12px;
    }

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div id="fake-header">
        <img src="/know-how/resources/image/로고색반전1.png"
             alt="know-how-academy 마크">
        &thinsp;
        KNOW-HOW ACADEMY &thinsp; 관리자 페이지
    </div>

	<form class="login-card" id="loginForm">
        
		<h1>Know-how Academy</h1>
        <br><br>
        <table>
            <tr>
                <th>아이디</th>
            </tr>
            <tr>
                <td>
                    <input type="text" name="userId" required>
                    <p>아이디를 입력해주세요</p>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
            </tr>
            <tr>
                <td>
                    <input type="password" name="userPwd" required>
                    <p>비밀번호를 입력해주세요</p>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <br>
                    <button type="submit">로그인</button>
                </td>
            </tr>
       </table>
       <br>
       <a href="/know-how/admin/signup">가입 문의하기</a> | <a href="/know-how/admin/findId">아이디 찾기</a> | <a href="/know-how/admin/findPassword">비밀번호 찾기</a>
	</form>
	<script>
		$(window).ready(function () {
		    $("#loginForm").submit(function (event) {
		        event.preventDefault();
		        let formData = $(this).serialize();
		        $.ajax({
		            url: "/know-how/admin/login",
		            type: "POST",
		            contentType: "application/x-www-form-urlencoded",
		            data: formData,
		            success: function (result) {
		            	if(result == "success") {
		            		alert("성공적으로 로그인이 되었습니다.");
		            	} else if(result == "fail") { 
		            		alert("관리자가 아니기 때문에 로그인할 수 없습니다.");
		            	} else {
		            		alert("아이디 또는 비밀번호를 잘못 입력했습니다.");
		            	}
		            	
		            	window.location.href = "/know-how/admin/index";
		            },
		            error: function () {
		                console.log("관리자 로그인용 ajax 통신 실패!!")
		            }
		        });
		    });
		});
	</script>
</body>
</html>