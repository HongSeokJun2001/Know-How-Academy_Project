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
        margin-left: 14px;
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

     <form class="signup-card" action="${contextPath}/counselor/signup" method="post" 
           id="enroll-form" enctype="multipart/form-data">

        <div class="signup-top-line"></div>

        <div class="signup-header">
            <h2><strong>${inviteInfoDto.inviteName}</strong> 선생님 환영합니다</h2>
            <p>회원 가입을 진행하기 위해 추가 정보를 입력해 주세요.</p>
        </div>

        <!-- 아이디 -->
        <div class="form-group">
            <label for="userId">아이디*</label>
            <div class="input-row">
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
                <button type="button" class="sub-btn" onclick="idCheck();">중복검사</button>
            </div>
            <div class="helper-text">영문자로 시작하는 8~16자의 영문자 또는 숫자를 입력해 주세요.</div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group">
            <label for="userPwd">비밀번호*</label>
            <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요" required>
            <div class="helper-text">8~20자의 영문 대소문자, 숫자, 특수문자를 조합하여 입력해 주세요.</div>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label for="userPwdCheck">비밀번호 확인*</label>
            <input type="password" id="userPwdCheck" placeholder="비밀번호를 다시 입력하세요" required>
            <div class="helper-text">비밀번호를 한 번 더 입력해 주세요.</div>
        </div>

        <!-- 전화번호 -->
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="text" id="phone" name="phone" placeholder="010-0000-0000">
        </div>

        <!-- 주소 -->
        <div class="form-group">
            <label for="address">주소</label>
            <input type="text" id="address" name="address" placeholder="주소를 입력하세요">
        </div>

        <!-- 프로필 이미지 -->
        <div class="form-group padding">
            <label for="profileImg">프로필 이미지</label>
            <div class="file-box">
                <input type="file" id="profileImg" name="profileImg" accept="image/*">
                <span>JPG, PNG 파일을 업로드해 주세요.</span>

                <img id="profilePreview" class="profile-preview" alt="프로필 이미지 미리보기">
            </div>
        </div>

        <!-- 소개글 -->
        <div class="form-group">
            <label for="bio">소개글</label>
            <textarea id="bio" name="bio" maxlength="100" placeholder="학생들에게 보여줄 프로필 소개글을 적어주세요. (최대 100자)"></textarea>
        </div>

        <button type="button" class="main-btn" onclick="requestEnrollForm();">가입 완료</button>

    </form>
	
	<script>
	    const userIdRegex = /^[A-Za-z][A-Za-z0-9]{7,15}$/
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).{8,20}$/
		 $(document).ready(function () {

            $("#profileImg").on("change", function () {
                const file = this.files[0];
                const $preview = $("#profilePreview");

                if (!file) {
                    $preview.hide().attr("src", "");
                    return;
                }

                $preview.attr("src", URL.createObjectURL(file));
                $preview.show();
            });
	         
	     })
	     
		function idCheck() {
    
            let $userId = $("#enroll-form input[name=userId]");

            if (!userIdRegex.test($userId.val())) {
                alert("아이디는 영문자로 시작하는 8~16자의 영문자 또는 숫자여야 합니다.");
                $userId.focus();
                return;
            }

            $.ajax({
                url: "/know-how/myPage/memberEnrollForm/idCheck",
                type: "get",
                data: { checkId: $userId.val() },
                success: function(result) {
                    
                    if (result == "NNNNN") {
                        alert("이미 사용중이거나 탈퇴한 회원의 아이디입니다.");
                        $userId.focus();
                    } else {
                        if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
                            $userId.prop("readonly", true);
                        } else {
                            $userId.focus();
                        }
                    }
                },
                error: function() {
                    console.log("아이디 중복체크용 ajax 통신 실패!");
                }
            });
        }

		function requestEnrollForm() {

            if (!$("#userId").prop("readonly")) {
                alert("아이디 중복검사를 진행해 주세요.");
                $("#userId").focus();
                return;
            }

            if (!userIdRegex.test($("#userId").val())) {
                alert("아이디 형식을 확인해 주세요.");
                $("#userId").focus();
                return;
            }

            if (!passwordRegex.test($("#userPwd").val())) {
                alert("비밀번호 형식을 확인해 주세요.");
                $("#userPwd").focus();
                return;
            }

            if ($("#userPwd").val() !== $("#userPwdCheck").val()) {
                alert("비밀번호 확인이 일치하지 않습니다.");
                $("#userPwdCheck").focus();
                return;
            }

            const formData = new FormData($("#enroll-form")[0]);

            $.ajax({
                url: "/know-how/myPageCounselor/counselor/signup/process",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(message) {
                    if (message != "imgFail") {
                        alert(message);
                        location.href = "/know-how/";
                    } else if(message === 'RuntimeException'){
                        alert("서버가 혼잡합니다. 잠시 후 다시 시도해주세요.");
                    } else {
                        alert("이미지 파일 저장에 실패했습니다. 잠시 후 다시 시도해주세요.");
                    }
                },
                error: function() {
                    console.log("회원가입 발송용 ajax 통신 실패!");
                    alert("회원가입 처리 중 오류가 발생했습니다.");
                }
            });
        }
		
	</script>

</body>
</html>