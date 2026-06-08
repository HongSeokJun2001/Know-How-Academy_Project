<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
     #memberDelete-form table>h4 {
         color : gray
     }
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
   <div class="mypage-outer">
   <form id="memberDelete-form" action="/know-how/myPage/memberDeleteForm/delete" method="post">
      <table class="myinformationDelete" align="center">
        <tr>
          <h2>회원탈퇴 유의사항</h2>
        </tr>
        <tr>
          <h4>회원탈퇴를 신청하기 전에 안내사항을 꼭 확인해주세요.</h4>
        </tr>
        <tr>
           <th>사용하고 계신 아이디${ sessionScope.loginUser.userId }는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</th>
           <th>
               <h4>사용중인 아이디는 탈퇴 시, 본인과 타인 모두 재사용및 복구할 수 없으니, 신중히 선택해 주세요.
               부정 가입/ 이용이 의심되는 아이디는 탈퇴 후 6개월까지 동일 실명정보로 재가입할 수 없습니다. </h4>
           </th>
        </tr>
        <tr>
            <b>---------------------------------------------------------------------------------------------</b>
        </tr>
        <tr>
           <th>탈퇴 후 회원정보 및 개인형 서비스 이용기록 모두 삭제됩니다.</th>
           <td>
               <h4> 회원정보, 메일 등 개인형 서비스 이용기록이 모두 삭제되며, 이후 복구할 수 없습니다.</h4>
           </td>
        </tr>
      </table>
      
      <div align="center">
         <button type="submit" class="btn btn-danger btn-sm">
                  동의하고 탈퇴하기</button>
      </div>
   </form>
   
   
   </div>
</body>
</html>