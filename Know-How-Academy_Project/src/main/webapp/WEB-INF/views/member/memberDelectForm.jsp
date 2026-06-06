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
   <form id="memberDelect-form" action="/know-how/member/myPage/delect" method="post">
      <table class="myinformation" align="center">
        <tr>
          <h2 align="center">비밀번호 재확인</h2>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;아이디</th>
           <td>
               <b>${ sessionScope.loginUser.userId }</b>  
           </td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;비밀번호</th>
           <td>
              <input type="password" name="UserPwd" maxlength="20" placeholder="8~20자리 영문자/숫자" required> 
           </td>
        </tr>
      </table>
      
      <div align="center">
         <button type="button" class="btn btn-secondary btn-sm">
                  확인</button>
      </div>
   </form>
   </div>
</body>
</html>