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
    .memberDeleteForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 1000px;
           margin: auto;
	    }
	.memberDeletePage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.memberDeletePage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.memberDeletePage-table th {
        padding: 5px;
        color: #6F6D80;
        font-weight: 500;
        font-size: 15px;
    }
    .memberDeletePage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	
	/* 버튼 */
	.btn-memberDeletePage {
	    background-color: red; /* 팀 메인 테마색 매칭 */
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
	.btn-memberDeletePage {
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
	.btn-memberDelete:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
   <jsp:include page="../common/menubar.jsp"/>
   
   <br><br>
   
   <div class="memberDeleteForm-outer">
   <form id="memberDelete-form" action="/know-how/myPage/memberDeleteForm/delete" method="post">
        
        <br>
          <h2 align="center">회원탈퇴 유의사항</h2>
        <br>
      
      <table class="memberDeleteForm-table" >
        <tr>
          <th></th>
          <th><h4>회원탈퇴를 신청하기 전에 안내사항을 꼭 확인해주세요.</h4><th>
          <th></th>
        </tr>
        <tr>
             <th><th>
              <h3>사용하고 계신 아이디${ sessionScope.loginUser.userId }는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</h3>
             <th><th>
        </tr>
        <tr>
             <th><th>
             <th><h3>사용중인 아이디는 탈퇴 시, 본인과 타인 모두 재사용및 복구할 수 없으니, 신중히 선택해 주세요.
               부정 가입/ 이용이 의심되는 아이디는 탈퇴 후 6개월까지 동일 실명정보로 재가입할 수 없습니다. </h3></th>
             <th><th>
        </tr>
        <tr>
            <th><th>
            <td></td>
            <th><th>
        </tr>
        <tr>
           <th><th>
           <th><h3>탈퇴 후 회원정보 및 개인형 서비스 이용기록 모두 삭제됩니다.</h3></th>
           <th><th>
        </tr>
        <tr>
           <th><th>
           <th><h3> 회원정보, 메일 등 개인형 서비스 이용기록이 모두 삭제되며, 이후 복구할 수 없습니다.</h3></th>
           <th><th>
        </tr>
      </table>
      
      <div align="center">
         <button type="submit" class="btn-memberDeletePage">
                  동의하고 탈퇴하기</button>
      </div>
   </form>
   
   
   </div>
</body>
</html>