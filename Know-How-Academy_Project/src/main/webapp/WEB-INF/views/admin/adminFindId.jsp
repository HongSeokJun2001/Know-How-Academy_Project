<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
	 * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', sans-serif;
    }

    html, body {
        width: 100%;
        height: 100%;
        background-color: #F8F9FA;
        color: #2C2A38;
        overflow: hidden;
    }

    #fake-header {
        width: 100%;
        height: 60px;
        background-color: #4233C7; 
        color: white;

        display: flex;
        align-items: center;

        padding: 0 24px;

        font-size: 18px;
        font-weight: 700;

        position: fixed;
        top: 0;
        left: 0;

        z-index: 1000;
    }

    #fake-header img {
        width: 36px;
        height: 36px;
        object-fit: contain;
    }

	.card {
        width: 800px;
        height: 450px;
		margin : 250px auto;
		padding : 40px;
        background-color : #fff;
		border : 1px solid #e5e7ed;
		border-radius : 14px;
		box-shadow : 0 4px 14px rgba(17, 12, 39, 0.06); 
        text-align: center; 
        justify-content: center; 
        align-items: center;
	}

    .card table {
        margin: 0 auto;
    }

    .card input {
        width: 300px;
        padding: 5px;
        border-radius: 4px;
        border: 1px solid black;
    }

    .card th{
        text-align: left;
        padding: 8px 0 4px 0;
        font-size: 14px;
    }

    .card p {
        font-size: 12px;
        color: #888;
        text-align: left;
        margin-left: 8px;
    }

    .card button {
        background-color: rgb(40, 40, 241);
        color: white;
        border: none;
        padding: 10px 130px;
        border-radius: 15px;
        cursor: pointer;
        box-shadow : 0 2px 5px rgba(0, 0, 0, 0.61); 
    }

    .card a {
        color: black;
        text-decoration: none;
        font-size: 12px;
    }

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div id="fake-header">
        <img src="/know-how/resources/image/로고색반전1.png"
             alt="know-how-academy 마크">
        &thinsp;
        KNOW-HOW ACADEMY &thinsp; 관리자 페이지
    </div>

	<div class="card">
        <form id="findIdForm">
			<h1>Know-how Academy</h1>
	        <br><br>
	        <table>
	            <tr>
	                <th>이름</th>
	            </tr>
	            <tr>
	                <td>
	                    <input type="text" id="userName" name="userName" required>
	                    <p></p>
	                </td>
	            </tr>
	            <tr>
	                <th>이메일</th>
	            </tr>
	            <tr>
	                <td>
	                    <input type="email" id="email" name="email" required>
	                    <p></p>
	                </td>
	            </tr>
	            <tr>
	                <td>
	                    <br>
	                    <button type="button" id="findId" name="findId">완료</button>
	                </td>
	            </tr>
	       </table>
	       <br>
       </form>
       <a>가입 문의하기</a> | <a href="/know-how/admin/loginForm">로그인하기</a> | <a href="/know-how/admin/extraPasswordForm">임시 비밀번호 발급</a>
	</div>
	<script>
		$(function () {

          $("#userName").on("blur", function() {
                if ($(this).val().trim() === "") {
                    $(this).css("border", "1px solid red");
                    $(this).next("p").text("이름을 입력해주세요.").show();
                } else {
                    $(this).css("border", "1px solid black");
                    $(this).next("p").hide();
                }
            });

            $("#email").on("blur", function() {
                if ($(this).val().trim() === "") {
                    $(this).css("border", "1px solid red");
                    $(this).next("p").text("이메일을 입력해주세요.").show();
                } else {
                    $(this).css("border", "1px solid black");
                    $(this).next("p").hide();
                }
            });

		  $("#findId").click(function () {
		    
			let userName = $("#userName").val();
		    let email = $("#email").val();
			
		    if($("#findIdForm")[0].checkValidity() === false){
			   $("#findIdForm")[0].reportValidity();
			   return;
			}
		    
		    $.ajax({
		      url: "/know-how/admin/findId",
		      type: "POST",
		      data: {
		        "userName": userName,
		        "email": email
		      },
		      success: function (result) {
		        alert(result);
		      },
		      error: function () {
		        console.log("아이디 찾기용 ajax 통신 오류!");
		      },
		    });

		  });
		});
	</script>
</body>
</html>