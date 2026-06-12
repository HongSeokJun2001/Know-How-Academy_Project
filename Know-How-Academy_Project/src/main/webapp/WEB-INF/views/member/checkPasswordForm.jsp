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
        padding: 5px;
        color: #6F6D80;
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
	    height: 30px;
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
        height: 40px;
        width: 120px;
        margin: auto;
	}
	.btn-checkPasswordPage {
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
        
        <tr>
           <th>&nbsp;&nbsp;&nbsp;아이디</th>
           <td>
               <b>${ sessionScope.loginUser.userId }</b>  
               
           </td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;비밀번호</th>
           <td>
              <input type="password" class="checkPasswordPage-input" name="userPwd" id="userPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required> 
           </td>
        </tr>
      </table>
      
      <div align="center">
         <button type="submit" class="btn-checkPasswordPage">확인</button>
      </div>
   </form>
   
   </div>

</body>
</html>