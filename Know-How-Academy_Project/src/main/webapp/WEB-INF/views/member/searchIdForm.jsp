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
    .mypagesearchId-outer {
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 600px;
           margin: auto;
	    }
	.searchIdPage-title {
	    font-size: 36px;
	    font-weight: bold;
	    margin-bottom: 10px;
	    color: #2C2A38;
	}
	.searchIdPage-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }
	.searchIdPage-table th {
        padding: 5px;
        color: #6F6D80;
        font-weight: 600;
        font-size: 15px;
    }
    .searchIdPage-table td {
        border-bottom: 2px solid black;
        vertical-align: middle;
        color: #5C5B6E;
        font-size: 15px;
    }
	/* 입력창 */
	.searchIdPage-input {
	    height: 40px;
	    width: 300px;
	    padding: 10px;
	    margin-bottom: 10px;
	}
	
	/* 버튼 */
	.btn-searchIdPage {
	    background-color: #4233C7; /* 팀 메인 테마색 매칭 */
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        transition: background 0.2s;
        height: 40px;
        width: 140px;
        margin: auto;
	}
	
	.btn-searchIdPage:hover {
	    background-color: #3225A3;
	}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
    
   <br><br>
   
   <div class="mypagesearchId-outer">
    <form id="searchId-form" action="/know-how/myPage/searchId" method="post"> 
    
		     <br>
		      <h2 align="center" class="searchIdPage-title">아이디 찾기</h2>      
             <br><br>
             
		<table class="searchIdPage-table" >
			<thead>
			<tr>
			    <th></th>
				<th>
				    <label for="userName">이름</label>
					<input type="text" class="searchIdPage-input" name="userName" id="userId">
				</th>
				<th></th>
			</tr>
			<tr>
			    <th></th>
				<th>
				    <label for="email">이메일</label>
					<input type="email" class="searchIdPage-input" name="email" id="email">
				</th>
				<th></th>
			</tr>
		    <tr>
				<th></th>
				<th>
					<button type="submit" class="btn-searchIdPage">아이디 찾기</button>
		            <button type="button" class="btn-searchIdPage">확인</button>
		            <%-- 이름 일치확인 + 이메일 인증 후 
		               창에 아이디 값 띄워주고 확인 버튼 누르면 사라지게 해야됨 아직 기능 구현 x --%>
		        </th>
		        <th></th>
		    </tr>
		    <tr>
				<th><td></td></th>
			</tr>
			</thead>
			<tbody>
			<tr>
			    <th></th>
				<th>
					<button type="button" class="btn-searchIdPage"
										  onclick="enrollPage();">회원가입</button>
					<button type="button" class="btn-searchIdPage"
					                      onclick="myPage();">로그인</button>
					<button type="button" class="btn-searchIdPage"
					                      onclick="searchPasswordPage();">비밀번호 찾기</button>					  
				</th>
				<th></th> 
			</tr>
			<tr>
				<th><br><br></th>
			</tr>
			</tbody>
		</table>
		
		</form>
		</div>
		
		<br><br>
	     
		<script>
		   function enrollPage() {
				
			 // 회원가입페이지로 이동
			 location.href = "/know-how/myPage/enrollForm";
			 // GET 방식
		   }
	
		  function myPage() {
			
			// 마이페이지로 이동
			location.href = "/know-how/myPage";
			// GET 방식
		  }
		
		  function searchPasswordPage() {
			
			// 비밀번호찾기페이지로 이동
			location.href = "/know-how/myPage/searchPasswordForm";
			// GET 방식
		  }
		  
		  
		</script>
		
</body>
</html>