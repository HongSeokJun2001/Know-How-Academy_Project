<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
   #searchId-form table {
		margin : auto;
	}
	#searchId-form input {
         padding : 5px;
		 margin : 5px;
		 width : 250px;
	}
	#searchId-form button {
		 padding : 5px;
		 margin : 5px;
		 width : 100px;
	}
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

    <div id="searchPassword-form"> 
		            
               <br><br>
               
			<table id="login-page" align="center">
				<tr>
					<h2 align="center">비밀번호 찾기</h2>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" id="userId" >
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" id="userName" >
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="email" id="email" >
					</td>
					<td>
                        <button type="button" onclick="emailSend();"
								class="btn btn-secondary btn-sm">인증번호발송</button>
                    </td>
				</tr>
				<tr align="center">
					<th>이메일인증확인</th>
					<td>
						<input type="text" id="checkNo" disabled>
					</td>
					<td>
						<button type="button" onclick="validateMail();"
								id="validateMail"class="btn btn-secondary btn-sm">인증확인</button>
					</td>
				</tr>
				<tr>
					<th>
						<br>
					</th>
				</tr>
			    <tr>
					<th></th>
					<td align="center">
			            <button type="button" class="btn btn-secondary btn-sm">비밀번호 찾기</button>
			            <button type="button" class="btn btn-secondary btn-sm">확인</button>
			            <%-- 이름 아이디 + 이메일 일치확인 후 창에 비밀번호 값 띄워주고 
			                 확인 버튼 누르면 사라지게 해야됨 아직 기능 구현 x --%>
			        </td>
			    </tr>
			    <tr align="center">
			        <th colspan="3">
			           ----------------------------------------------------------
			        </th>
			    </tr>
				<tr>
					<th>
						<br>
					</th>
				</tr>
				<tr align="center">
					<th colspan="3">
						<button type="button" class="btn btn-secondary btn-sm"
											  onclick="enrollPage();">회원가입</button>
						<button type="button" class="btn btn-secondary btn-sm"
						                      onclick="myPage();">로그인</button>
						<button type="button" class="btn btn-secondary btn-sm"
						                      onclick="searchIdPage();">아이디 찾기</button>					  
					</th>
				</tr>
				<tr>
					<th><br><br></th>
				</tr>
			</table>
			
		</div>
		
		<script>
			function enrollPage() {
				
				// 회원가입페이지로 이동
				location.href = "/know-how/member/enrollForm";
				// GET 방식
			}
		</script>
		
		<script>
			function myPage() {
				
				// 마이페이지로 이동
				location.href = "/know-how/member/myPage";
				// GET 방식
			}
		</script>
		    
		<script>
			function searchIdPage() {
				
				// 아이디찾기페이지로 이동
				location.href = "/know-how/member/searchIdForm";
				// GET 방식
			}
			function validateMail() {
				
				// 이메일주소와 인증 번호를 서버로 다시 보내서 대조 작업
				$.ajax({
					url : "/email/validate",
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
							$("#validate").prop("disabled", true);
							
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
		
			function sendMail() {
				
				// 인증 번호를 이메일로 전송할 수 있도록 요청
				$.ajax({
					url : "/email/send",
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
						$("#validate").prop("disabled", false);
						
					},
					error : function() {
						
						console.log("인증메일 발송용 ajax 통신 실패!");
					}
				});
			}
		</script>
</body>
</html>