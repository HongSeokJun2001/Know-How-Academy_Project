<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 조회</title>
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
    .selectForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 700px;
           margin: auto;
	    }
	.selectPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.selectPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.selectPage-table th {
        padding: 5px;
        color: #6F6D80;
        font-weight: 500;
        font-size: 15px;
    }
    .selectPage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.selectPage-input {
	    height: 30px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-reserVationPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 40px;
        width: 200px;
        margin: auto;
	}
	.btn-selectPageCheck {
	    background-color: red; /* 탈퇴버튼 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 400;
        transition: background 0.1s;
        height: 40px;
        width: 120px;
        margin: auto;
        font-size: 15px;
      
	}
	.btn-select:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
    <div class="selectForm-outer">
    <br><br>
    <h2 align="left" class="selectPage-title">내정보</h2>
     <br>
    <%-- 상담예약 페이지로 요청을 보냄--%>
    <div id="myInformationSelect-form">
                                              
      <table class="selectPage-table" >
        <thead>
        <tr>
          <th></th>
          <th></th>
          <th></th>
          <th align="right"><button type="button"
						            class="btn-selectPageCheck"
						            onclick="checkPasswordPage();">탈퇴</button>
          </th>
        </tr>
        </thead>
        
        <tbody>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;아이디</th>
           <th>
               <b>${ sessionScope.loginUser.userId }</b>  
           </th>
           <th>&nbsp;&nbsp;&nbsp;기간</th>
           <th>
               <b>${ sessionScope.loginUser.createdAt }</b>
           </th>
           <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;이름</th>
           <th>
              <b>${ sessionScope.loginUser.userName }</b> 
           </th>
           <th></th>
           <th></th>
           <td>   
           </td>
        </tr>
        <tr>
            <th>&nbsp;&nbsp;&nbsp;휴대폰번호</th>
            <th>
              <b>${ sessionScope.loginUser.phone }</b>
            </th>
            <th colspan="5">상담신청하고 싶다면?</th>
            <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;이메일</th>
           <th>
              <b>${ sessionScope.loginUser.email }</b>
           </th>
           <th colspan="5">
               <button type="button" onclick="reservationListPage();" class="btn-reserVationPage">상담신청</button>
           </th>
           <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;반</th>
           <td>
             <b>${ sessionScope.loginUser.email }</b>
           </td>
           <th></th>
           <th></th>
           <td></td>
        </tr>
        <tr>
           <th>&nbsp;&nbsp;&nbsp;주소</th>
           <th>
             <b>${ sessionScope.loginUser.address }</b>
           </th>
           <th></th>
           <th></th>
           <td></td>
        </tr>
        </tbody>
      </table>
     </div>
    </div>
    
    <script>
		function checkPasswordPage() {
			
		    // 비밀번호확인 페이지로 이동
		    location.href = "/know-how/myPage/checkPasswordForm";
		    // GET 방식
		}
	
		function reservationListPage() {
			
		    // 상담예약 페이지로 이동
		    location.href = "/know-how/reservation/list";
		    // GET 방식
		}
	</script>

</body>
</html>