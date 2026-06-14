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
    .selectForm-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 800px;
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
        color: black;
        font-weight: 500;
        font-size: 20px;
    }
    .selectPage-table td {
        vertical-align: middle;
        color: black;
        font-size: 17px;
    }
    .selectPage-tableTd {
        border-bottom: 2px solid black;
    }
    .selectPage-tableTh {
        border-bottom: 2px solid black;
        background-color: lightgray;
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
        width: 120px;
        margin: auto;
        font-size: 15px;
	}
	.btn-selectPageCheck {
	    background-color: pink; /* 학생목록조회버튼 */
        color: black;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 400;
        transition: background 0.1s;
        height: 50px;
        width: 200px;
        margin: auto;
      
	}
	.btn-select:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
    
    <br><br>
    
    <div class="selectForm-outer">
     <br>
     <h3 align="center" class="selectPage-title">내정보 조회</h3>
     <br>
    <%-- 상담예약 페이지로 요청을 보냄--%>
    <div id="counselorInformationSelect-form">
                                              
      <table class="selectPage-table" >
        <thead>
        <tr>
          <th></th>
          <td></td>
          <th></th>
          <th></th>
          <td></td>
        </tr>
        <tr>
           <th><br></th>
        </tr>
        <tr>
            <td class="selectPage-tableTd"></td>
            <td class="selectPage-tableTd"></td>
            <td class="selectPage-tableTd"></td>
            <td class="selectPage-tableTd"></td>
            <td class="selectPage-tableTd"></td>
        </tr>
        </thead>
        
        <tbody>
         <tr>
           <th class="selectPage-tableTh"><label for="userId">아이디</label></th>
           <td class="selectPage-tableTd">
               <label>${ sessionScope.loginUser.userId }</label>  
           </td>
           <th class="selectPage-tableTh"><label for="createdAt">기간</label></th>
           <td class="selectPage-tableTd">
               <label>${ sessionScope.loginUser.createdAt }</label>
           </th>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="name">이름</label></th>
           <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.userName }</label> 
           </td>
           <th></th>
           <td></td>
           <td>   
           </td>
        </tr>
        <tr>
            <th class="selectPage-tableTh"><label for="phone">휴대전화 번호</label></th>
            <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.phone }</label>
            </td>
            <th colspan="5">우리반학생들이 궁금하다면?</th>
            <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="email">이메일</label></th>
           <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.email }</label>
           </td>
           <th colspan="5">
               <button type="button" onclick="myStudentClassListPage();" class="btn-selectPageCheck">우리반학생목록</button>
           </th>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="class">반</label></th>
           <td class="selectPage-tableTd">
             <label>${ sessionScope.loginUser.classNo } 반</label>
           </td>
           <th></th>
           <td></td>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="address">주소</label></th>
           <td class="selectPage-tableTd">
             <label>${ sessionScope.loginUser.address }</label>
           </td>
           <th></th>
           <td></td>
           <td></td>
        </tr>
        </tbody>
      </table>
     </div>
    </div>
    
    <script>
		function myStudentClassListPage() {
			
		    // 상담예약 페이지로 이동
		    location.href = "/know-how/myPageCounselor/myStudentClassListForm";
		    // GET 방식
		}
	</script>
</body>
</html>