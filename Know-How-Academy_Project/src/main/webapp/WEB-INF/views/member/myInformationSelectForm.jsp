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
        height: 50px;
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
   <br><br>
    <div class="selectForm-outer">
    
    <br>
    <h2 align="center" class="selectPage-title">내 정보 조회</h2>
     <br>
     
    <%-- 상담예약 페이지로 요청을 보냄--%>
    <div id="myInformationSelect-form">
                                              
      <table class="selectPage-table" >
        <thead>
        <tr>
          <th></th>
          <td></td>
          <th></th>
          <th align="right"><button type="button"
						            class="btn-selectPageCheck"
						            onclick="checkPasswordPage();">탈퇴</button>
          </th>
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
           </td>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="userName">이름</label></th>
           <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.userName }</label> 
           </td>
           <th></th>
           <td></td>
           <td></td>
        </tr>
        <tr>
            <th class="selectPage-tableTh"><label for="phone">휴대전화</label></th>
            <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.phone }</label>
            </td>
            <th colspan="5">상담신청하고 싶다면?</th>
            <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="email">이메일</label></th>
           <td class="selectPage-tableTd">
              <label>${ sessionScope.loginUser.email }</label>
           </td>
           <th colspan="5">
               <button type="button" onclick="reservationListPage();" class="btn-reserVationPage">상담신청</button>
           </th>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="class">반 번호</label></th>
           <td class="selectPage-tableTd">
             <label>${ sessionScope.loginUser.classNo } 번</label>
           </td>
           <th></th>
           <td></td>
           <td></td>
        </tr>
        <tr>
           <th class="selectPage-tableTh"><label for="userId">주소</label></th>
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
		
        function sendMail() {
			
			// 인증 번호를 이메일로 전송할 수 있도록 요청
			$.ajax({
				url : "/know-how/myPage/sendMail",
				type : "post",
				data : {
					email : $("#email").val()
				},
				success : function(result) {
					
					alert(result);
					
					// 인증번호 발급 후 이메일 관련 요소들은 비활성화
					$("#email").prop("readonly", true);
					$("#sendMail").prop("disabled", true);
					
					// 인증 관련 요소들은 활성화
					$("#checkNo").prop("disabled", false);
					$("#validateMail").prop("disabled", false);
					
				},
				error : function() {
					
					console.log("인증메일 발송용 ajax 통신 실패!");
				}
			});
		}
        function validateMail() {
			
			// 이메일주소와 인증 번호를 서버로 다시 보내서 대조 작업
			$.ajax({
				url : "/know-how/myPage/validate",
				type : "post", 
				data : {
					email : $("#email").val(),
					checkNo : $("#checkNo").val()
				}, 
				success : function(result) {
					
					if(result == "success") {
						// > 대조 성공일 경우
						
						alert("본인 인증에 성공했습니다.");
						
						// 인증 관련 요소들도 다시 disabled (readonly) 상태로 되돌려놓기
						$("#checkNo").prop("readonly", true);
						$("#validateMail").prop("disabled", true);
						
					} else {
						// > 대조 실패일 경우
						
						alert("본인 인증에 실패했습니다. 다시 진행해 주세요.");
						
						// 인증 관련 요소들도 다시 disabled 상태로 되돌려놓기
						// > 특히, 이미 입력한 인증번호를 초기화까지 시켜줘야함
						$("#checkNo").prop("disabled", true).val("");
						$("#validate").prop("disabled", true);
						
						// 이메일 관련 요소들도 다시 활성화 상태로 되돌리기
						// > 마찬가지로 이미 입력했던 이메일 주소도 초기화 해줘야함
						$("#email").prop("disabled", false).val("");
						$("#sendMail").prop("disabled", false);
						
					}
					
				},
				error : function() {
					
					console.log("인증번호 대조용 ajax 통신 실패!");
				}
			});
		}
	
		
	</script>

</body>
</html>