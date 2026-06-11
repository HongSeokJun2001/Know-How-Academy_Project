<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    

    body {
        background: #f6f7fb;
    }

    .signup-card {
        width: 90%;
        max-width: 550px;
        margin: 60px auto;
        background: #fff;
        border-radius: 18px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        padding: 0 34px 36px;
    }

    .signup-top-line {
        height: 7px;
        margin: 0 -34px 28px;
        background: linear-gradient(90deg, #4233C7, #6b5cff);
    }

    .signup-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .signup-header h2 {
        font-size: 26px;
        color: #222;
        margin-bottom: 8px;
    }

    .signup-header p {
        color: #777;
        font-size: 14px;
    }

    .form-group {
        margin-bottom: 18px;
        padding: 0 32px 0 0;
    }

    .form-group label {
        display: block;
        font-weight: 700;
        font-size: 14px;
        margin-bottom: 8px;
        color: #333;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 13px 14px;
        font-size: 14px;
        outline: none;
        transition: 0.2s;
    }

    .form-group input:focus,
    .form-group textarea:focus {
        border-color: #4233C7;
        box-shadow: 0 0 0 3px rgba(66, 51, 199, 0.12);
    }

    .input-row {
        display: flex;
        gap: 8px;
    }

    .input-row input {
        flex: 1;
    }

    .sub-btn {
        width: 100px;
        border: 1px solid #4233C7;
        background: #fff;
        color: #4233C7;
        border-radius: 10px;
        font-weight: 700;
        cursor: pointer;
    }

    .sub-btn:hover {
        background: #f1efff;
    }

    .form-group.padding {
        padding: 0;
    }

    .file-box {
        width: 100%;
        box-sizing: border-box;
        border: 1px dashed #bbb;
        border-radius: 12px;
        padding: 16px;
        background: #fafafa;
    }

    .file-box input {
        border: none;
        padding: 0;
        margin-bottom: 8px;
    }

    .file-box span {
        display: block;
        font-size: 13px;
        color: #777;
    }

    .profile-preview {
        display: none;
        width: 120px;
        height: 120px;
        margin-top: 12px;
        object-fit: cover;
        border-radius: 12px;
        border: 1px solid #ddd;
    }

    textarea {
        height: 100px;
        resize: none;
    }

    .helper-text {
        margin-top: 6px;
        margin-left: 7px;
        font-size: 12px;
        color: #888;
        text-align: left;
    }

    .main-btn {
        width: 100%;
        height: 50px;
        margin-top: 12px;
        border: none;
        border-radius: 12px;
        background: #4233C7;
        color: #fff;
        font-size: 16px;
        font-weight: 800;
        cursor: pointer;
        transition: 0.2s;
    }

    .main-btn:hover {
        background: #3528a5;
        transform: translateY(-1px);
    }
</style>
</head>
<body>

     <form class="signup-card" action="${contextPath}/counselor/signup" method="post" enctype="multipart/form-data">

        <div class="signup-top-line"></div>

        <div class="signup-header">
            <h2><strong>${inviteInfoDto.inviteName}</strong> 선생님 환영합니다</h2>
            <p>회원 가입을 진행하기 위해 추가 정보를 입력해 주세요.</p>
        </div>

        <!-- 아이디 -->
        <div class="form-group">
            <label for="userId">아이디</label>
            <div class="input-row">
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
                <button type="button" class="sub-btn">중복검사</button>
            </div>
            <div class="helper-text">영문자로 시작하는 8~16자의 영문자 또는 숫자를 입력해 주세요.</div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group">
            <label for="userPwd">비밀번호</label>
            <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요" required>
            <div class="helper-text">8~20자의 영문 대소문자, 숫자, 특수문자를 조합하여 입력해 주세요.</div>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="userPwdCheck">비밀번호 확인</label>
            <input type="password" id="userPwdCheck" name="userPwdCheck" placeholder="비밀번호를 다시 입력하세요" required>
            <div class="helper-text">비밀번호를 한 번 더 입력해 주세요.</div>
        </div>

        <!-- 전화번호 -->
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="text" id="phone" name="phone" placeholder="010-0000-0000" required>
        </div>

        <!-- 주소 -->
        <div class="form-group">
            <label for="address">주소</label>
            <input type="text" id="address" name="address" placeholder="주소를 입력하세요">
        </div>

        <!-- 프로필 이미지 -->
        <div class="form-group padding">
            <label for="profileImgPath">프로필 이미지</label>
            <div class="file-box">
                <input type="file" id="profileImgPath" name="profileImgPath" accept="image/*">
                <span>JPG, PNG 파일을 업로드해 주세요.</span>

                <img id="profilePreview" class="profile-preview" alt="프로필 이미지 미리보기">
            </div>
        </div>

        <!-- 소개글 -->
        <div class="form-group">
            <label for="bio">소개글</label>
            <textarea id="bio" name="bio" maxlength="100" placeholder="학생들에게 보여줄 프로필 소개글을 적어주세요. (최대 100자)"></textarea>
        </div>

        <button type="submit" class="main-btn">가입 완료</button>

    </form>
	
	<script>
	    const userIdRegex = /^[A-Za-z][A-Za-z0-9]{8,16}$/
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).{8,20}$/
		 $(document).ready(function () {
            $("#profileImgPath").on("change", function () {
                const file = this.files[0];
                const $preview = $("#profilePreview");

                if (!file) {
                    $preview.hide().attr("src", "");
                    return;
                }

                $preview.attr("src", URL.createObjectURL(file));
                $preview.show();
            });

            $('#userId').on("blur", function () {
                $('#userIdErrorMessage').text(!userIdRegex.test($(this).val()) ? "영문자로 시작해야 하며 8~16자의 영문자, 숫자를 사용해야합니다." : "");
            });
            $("#userPwd").on("blur", function () {
                $('#userPwdErrorMessage').text(!passwordRegex.test($(this).val()) ? "8~20자의 영문 대/소문자, 숫자, 특수문자를 사용해야합니다." : "");
            })
            $('#userPwdCheck').on("blur", function () {
                $('#userPwdCheckErrorMessage').text($(this).val() !== $("#userPwd").val() ? "비밀번호와 비밀번호 확인이 일치하지 않습니다" : "");
            })
	         
	     })
	     
		function idCheck() {
			
			let $userId = $("#enroll-form input[name=userId]");
		
			$.ajax({
				url : "/know-how/myPage/memberEnrollForm/idCheck",
				type : "get",
				data : { checkId : $userId.val() },
				success : function(result) {
					
					if(result == "NNNNN") {
						// > 사용 불가한 아이디일 경우
						
						alert("이미 사용중이거나 탈퇴한 회원의 아이디입니다.");
						
						// 아이디 재입력 유도
						$userId.focus();
						
					} else {
						// > 사용 가능한 아이디일 경우
						
						if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")){
							// > 사용하겠다고 의사를 밝힌 경우 (확인 버튼 클릭 시)
							
							// 아이디값을 확정 (다시는 수정 못하게)
							$userId.prop("readonly", true);
							
						} else {
							// > 사용하지 않겠다고 의사를 밝힌 경우 (취소 버튼 클릭 시)
							
							// 아이디 재입력 유도
							$userId.focus();
						}
					}
				},
				error : function() {
					
					console.log("아이디 중복체크용 ajax 통신 실패!");
				}
			});
			
		}
		
        function validateMail() {
			
        	let $email = $("#enroll-form input[id=email]");
			let $sendMail = $("#enroll-form button[id=sendMail]");
			let $checkNo = $("#enroll-form input[id=checkNo]");
			let $valiadateMail = $("#enroll-form button[id=validateMail]");
        	
			// 이메일주소와 인증 번호를 서버로 다시 보내서 대조 작업
			$.ajax({
				url : "/know-how/myPage/validateMail",
				type : "post", 
				data : {
					email : $email.val(),
					checkNo : $checkNo.val()
				}, 
				success : function(result) {
					
					if(result == "success") {
						// > 대조 성공일 경우
						
						alert("본인 인증에 성공했습니다.");
					
						// 인증 관련 요소들도 다시 disabled (readonly) 상태로 되돌려놓기
						$checkNo.prop("readonly", true);
						$validateMail.prop("disabled", true);
						
					} else {
						// > 대조 실패일 경우
						
						alert("본인 인증에 실패했습니다. 다시 진행해 주세요.");
						
						// 인증 관련 요소들도 다시 disabled 상태로 되돌려놓기
						// > 특히, 이미 입력한 인증번호를 초기화까지 시켜줘야함
						$checkNo.prop("disabled", true).val("");
						$validateMail.prop("disabled", true);
						
						// 이메일 관련 요소들도 다시 활성화 상태로 되돌리기
						// > 마찬가지로 이미 입력했던 이메일 주소도 초기화 해줘야함
						$email.prop("disabled", false).val("");
						$sendMail.prop("disabled", false);
						
					}
					
				},
				error : function() {
					
					console.log("인증번호 대조용 ajax 통신 실패!");
				}
			});
		}
	
		function sendMail() {
			
			let $email = $("#enroll-form input[id=email]");
			let $sendMail = $("#enroll-form button[id=sendMail]");
			let $checkNo = $("#enroll-form input[id=checkNo]");
			let $valiadateMail = $("#enroll-form button[id=validateMail]");
			
			// 인증 번호를 이메일로 전송할 수 있도록 요청
			$.ajax({
				url : "/know-how/myPage/sendMail",
				type : "post",
				data : {
					email : $email.val() 
				},
				success : function(result) {
					
					alert(result);
					
					// 인증번호 발급 후 이메일 관련 요소들은 비활성화
					$email.prop("readonly", true);
					$sendMail.prop("readonly", true);
					
					// 인증 관련 요소들은 활성화
					$checkNo.prop("disabled", false);
					$validateMail.prop("disabled", false);
					
				},
				error : function() {
					
					console.log("인증메일 발송용 ajax 통신 실패!");
				}
			});
		}
		
		function requestEnrollForm() {
			
			let $userId = $("#enroll-form input[name=userId]");
			let $userPwd = $("#enroll-form input[name=userPwd]");
			let $userName = $("#enroll-form input[name=userName]");
			let $email = $("#enroll-form input[name=email]");
			let $address = $("#enroll-form input[name=address]");
			let $phone = $("#enroll-form input[name=phone]");
			
            $.ajax({
                url: "/know-how/myPage/memberEnrollForm/insert",
                type: "POST",
                data: {
                	userId : $userId.val(),
                	userPwd : $userPwd.val(),
                	userName : $userName.val(),
                	email : $email.val(),
                	address : $address.val(),
                	phone : $pnone.val()
                },
                success: function() {
                	
                    alert("회원가입이 완료되었습니다.");
                    
                },
                error: function() {
                	
                    console.log("회원가입 발송용 ajax 통신 실패!");
                }
            })
        }
		
	</script>

</body>
</html>