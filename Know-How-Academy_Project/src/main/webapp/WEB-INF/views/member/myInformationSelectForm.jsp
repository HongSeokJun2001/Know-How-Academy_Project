<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 조회</title>
<style>
  
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
    <div class="mypage-outer">
  
    <%-- 상담예약 페이지로 요청을 보냄--%>
    <form id="myInformationSelect-form" action="/know-how/reservation/reservationListview" method="post">
                                              
      <table class="myinformation" align="center">
        <thead>
        <tr>
          <th><h2 align="left">내정보</h2></th>
          <td></td>
          <th></th>
          <td align="right"><button type="button"
						            class="btn btn-primary btn-sm"
						            onclick="memberDelectPage();">탈퇴</button>
          </td>
        </tr>
        </thead>
        
        <tbody>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;아이디</th>
           <td>
               <b>${ sessionScope.loginUser.userId }</b>  
           </td>
           <th>&nbsp;&nbsp;&nbsp;기간</th>
           <td>
               <b>${ sessionScope.loginUser.createdAt }</b>
           </td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;이름</th>
           <td>
              <b>${ sessionScope.loginUser.userName }</b> 
           </td>
           <th></th>
           <td>   
           </td>
        </tr>
        <tr>
            <th>&nbsp;&nbsp;&nbsp;휴대폰번호</th>
            <td>
              <b>${ sessionScope.loginUser.phone }</b>
            </td>
            <th colspan="5">상담신청하고 싶다면?</th>
            <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;이메일</th>
           <td>
              <b>${ sessionScope.loginUser.email }</b>
           </td>
           <th colspan="5">
               <button type="submit" class="btn btn-primary btn-sm">상담신청</button>
           </th>
           <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;반</th>
           <td>
             <b>${ sessionScope.loginUser.email }</b>
           </td>
           <th></th>
           <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;주소</th>
           <td>
             <b>${ sessionScope.loginUser.address }</b>
           </td>
           <th></th>
           <td></td>
        </tr>
        </tbody>
      </table>
     </form>
    </div>
    
    <script>
		function memberDelectPage() {
			
		    // 회원탈퇴 페이지로 이동
		    location.href = "/know-how/member/myPage/memberDelectForm";
		    // GET 방식
		}
	</script>
    
    <script>
		function reservationListPage() {
			
		    // 상담예약 페이지로 이동
		    location.href = "/know-how/reservation/reservationListview";
		    // GET 방식
		}
	</script>

</body>
</html>