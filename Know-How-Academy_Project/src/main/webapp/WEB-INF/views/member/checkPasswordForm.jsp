<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    .checkPasswordForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 700px;
           max-heoght: 700px;
           margin: auto;
	    }
	.checkPasswordPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.checkPasswordPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.checkPasswordPage-table th {
        padding: 10px;
        color: black;
        font-weight: 500;
        font-size: 15px;
    }
    .checkPasswordPage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.checkPasswordPage-input {
	    height: 50px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-checkPasswordPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 50px;
        width: 150px;
        margin: auto;
	}
	.btn-checkPassword:hover {
	    background-color: #3225A3;
	}
 </style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
   <br><br>
   
   <div class="checkPasswordForm-outer">
   <form id="checkPassword-form" action="/know-how/myPage/memberDeleteForm" method="post">
        <br>
        <h2 align="center" class="checkPasswordPage-title">비밀번호 재확인</h2>
        <br><br>
        
      <table class="checkPasswordPage-table">
        <thead>
        <tr>
           <th></th>
           <th>
               <h4><label for="userId">아이디</label>
               <b>${ sessionScope.loginUser.userId }</b></h4>
           </th>
           <th></th>
        </tr>
        <tr>
           <th></th>
           <th>
              <h4><label for="password">비밀번호</label></h4>
              <input type="password" class="checkPasswordPage-input" name="userPwd" id="userPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required> 
           </th>
           <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
	        <th></th>
	        <td></td>
	        <th></th>
        </tr>
        <tr>
           <th></th>
           <th><button type="submit" class="btn-checkPasswordPage">확인</button><th>
           <th></th>
         </tr>
        </tbody>
      </table>
      
   </form>
   
   </div>

</body>
</html>