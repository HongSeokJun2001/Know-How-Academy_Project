<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <style>
        .counselor-invite-section {
            width: 100%;
            padding: 0 40px 80px;
            box-sizing: border-box;
        }

        /* 페이지 제목 */
        .invite-title-area {
            margin-bottom: 24px;
        }

        .invite-title-area h2 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            color: #2c2f3f;
        }

        .invite-title-area p {
            margin: 10px 0 0;
            font-size: 15px;
            color: #6b7280;
        }

        /* 상단 안내 카드 */
        .invite-guide-card {
            display: flex;
            align-items: center;
            gap: 22px;
            padding: 28px 32px;
            margin-bottom: 24px;
            background-color: #fff;
            border: 1px solid #dedbff;
            border-radius: 16px;
            box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
        }

        .guide-icon {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            background: #f2f0ff;
            color: #4233c7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .guide-text h3 {
            margin: 0;
            font-size: 24px;
            font-weight: 900;
            color: #2c2f3f;
        }

        .guide-text p {
            margin: 8px 0 0;
            font-size: 15px;
            line-height: 1.6;
            color: #6b7280;
        }

        /* 폼 + 안내 2단 */
        .invite-content-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.3fr) minmax(320px, 0.7fr);
            gap: 24px;
            margin-bottom: 28px;
        }

        /* 폼 카드 */
        .invite-form-card,
        .invite-info-card,
        .invite-history-card {
            background-color: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
        }

        .invite-form-card {
            padding: 32px;
        }

        .card-title-area {
            margin-bottom: 28px;
            padding-bottom: 18px;
            border-bottom: 1px solid #eef0f4;
        }

        .card-title-area h3 {
            margin: 0;
            font-size: 22px;
            font-weight: 900;
            color: #2c2f3f;
        }

        .card-title-area p {
            margin: 8px 0 0;
            font-size: 14px;
            color: #6b7280;
        }

        /* 입력 폼 */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            margin-bottom: 9px;
            font-size: 15px;
            font-weight: 800;
            color: #2c2f3f;
        }

        .invite-input {
            width: 100%;
            height: 48px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 9px;
            background-color: #fff;
            color: #374151;
            font-size: 15px;
            outline: none;
            box-sizing: border-box;
        }

        .invite-input:focus {
            border-color: #4233c7;
            box-shadow: 0 0 0 3px rgba(66, 51, 199, 0.12);
        }

        .input-help {
            margin: 8px 0 0;
            font-size: 13px;
            color: #6b7280;
        }

        .input-help.error {
            color: #ef4444;
        }

        /* 버튼 영역 */
        .form-button-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 12px;
        }

        /* 오른쪽 안내 카드 */
        .invite-info-card {
            padding: 28px;
        }

        .invite-info-card h3 {
            margin: 0 0 22px;
            font-size: 20px;
            font-weight: 900;
            color: #2c2f3f;
        }

        .process-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .process-list li {
            display: flex;
            gap: 14px;
        }

        .process-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #f2f0ff;
            color: #4233c7;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .process-list strong {
            display: block;
            margin-bottom: 4px;
            color: #2c2f3f;
            font-size: 15px;
            font-weight: 900;
        }

        .process-list p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.5;
        }

        .security-note {
            margin-top: 26px;
            padding: 16px;
            border-radius: 12px;
            background-color: #fafafa;
            border: 1px solid #eef0f4;
        }

        .security-note strong {
            display: block;
            margin-bottom: 6px;
            color: #2c2f3f;
            font-size: 14px;
            font-weight: 900;
        }

        .security-note p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.5;
        }

        /* 최근 초대 내역 */
        .invite-history-card {
            padding: 28px;
        }

        .history-header {
            margin-bottom: 18px;
        }

        .history-header h3 {
            margin: 0;
            font-size: 20px;
            font-weight: 900;
            color: #2c2f3f;
        }

        .history-header p {
            margin: 8px 0 0;
            font-size: 14px;
            color: #6b7280;
        }

        .invite-history-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
            min-width: 1100px;
        }

        .invite-history-table thead th {
            height: 52px;
            padding: 0 18px;
            background-color: #fafafa;
            color: #2c2f3f;
            font-weight: 800;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        .invite-history-table tbody td {
            padding: 15px 18px;
            color: #374151;
            border-bottom: 1px solid #eef0f4;
            vertical-align: middle;
        }

        .invite-history-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* 상태 배지 */
        .invite-status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 72px;
            height: 28px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 800;
        }

        /* 초대 발송 */
        .invite-status.pending {
            background-color: #fff5d6;
            color: #c47a00;
        }

        /* 가입 완료 */
        .invite-status.used {
            background-color: #e8f8ec;
            color: #128a3a;
        }

        /* 관리자 취소 */
        .invite-status.canceled {
            background-color: #f1f3f5;
            color: #6c757d;
        }

        /* 만료 */
        .invite-status.expired {
            background-color: #e9ecef;
            color: #495057;
        }

        /* 버튼 */
        .btn-primary {
            min-width: 110px;
            height: 42px;
            padding: 0 22px;
            border: none;
            border-radius: 8px;
            background-color: #4233c7;
            color: #fff;
            font-size: 15px;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #3528a8;
        }

        .btn-outline {
            min-width: 96px;
            height: 42px;
            padding: 0 22px;
            border: 1px solid #c9ccd6;
            border-radius: 8px;
            background-color: #fff;
            color: #4b5563;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-outline:hover {
            border-color: #4233c7;
            color: #4233c7;
        }

        .btn-outline.small,
        .btn-danger-outline.small {
            min-width: 82px;
            height: 34px;
            padding: 0 14px;
            font-size: 13px;
        }

        .btn-danger-outline {
            min-width: 82px;
            height: 36px;
            padding: 0 14px;
            border: 1px solid #ef4444;
            border-radius: 7px;
            background-color: #fff;
            color: #ef4444;
            font-size: 14px;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-danger-outline:hover {
            background-color: #fff1f1;
        }

    </style>
    <!-- 상담사 등록 콘텐츠 시작 -->
     
    <section class="counselor-invite-section">

        <!-- 페이지 제목 -->
        <div class="invite-title-area">
            <div>
                <h2>상담사 등록</h2>
                <p>상담사 이름과 이메일을 입력하면 가입 링크가 메일로 발송됩니다.</p>
            </div>
        </div>

        <!-- 상단 안내 카드 -->
        <div class="invite-guide-card">
            <div class="guide-icon">✉</div>

            <div class="guide-text">
                <h3>상담사 초대 메일 발송</h3>
                <p>
                    관리자가 입력한 이메일로만 상담사 가입이 가능합니다.
                    발송된 링크를 통해 상담사가 직접 회원가입을 완료합니다.
                </p>
            </div>
        </div>

        <!-- 폼 + 안내 2단 영역 -->
        <div class="invite-content-grid">

            <!-- 상담사 등록 폼 -->
            <div class="invite-form-card">
                <div class="card-title-area">
                    <h3>초대 정보 입력</h3>
                    <p>상담사 이름과 이메일 주소를 정확히 입력해주세요.</p>
                </div>

                <div class="form-group">
                    <label for="counselorName">이름</label>
                    <input type="text"
                        id="counselorName"
                        class="invite-input"
                        placeholder="상담사 이름 입력">
                </div>

                <div class="form-group">
                    <label for="counselorEmail">이메일 주소</label>
                    <input type="email"
                        id="counselorEmail"
                        class="invite-input"
                        placeholder="example@email.com">
                </div>

                <div class="form-button-area">
                    <button type="button" class="btn-primary" onclick="sendMail();">
                        초대메일 발송
                    </button>
                </div>
            </div>

            <!-- 처리 안내 카드 -->
            <div class="invite-info-card">
                <h3>처리 흐름</h3>

                <ol class="process-list">
                    <li>
                        <span class="process-number">1</span>
                        <div>
                            <strong>관리자 초대 등록</strong>
                            <p>이름과 이메일을 입력한 후, 초대 메일 발송 버튼을 눌러 주세요.</p>
                        </div>
                    </li>

                    <li>
                        <span class="process-number">2</span>
                        <div>
                            <strong>가입 링크 발송</strong>
                            <p>등록된 이메일로 상담사 전용 가입 링크가 발송됩니다.</p>
                        </div>
                    </li>

                    <li>
                        <span class="process-number">3</span>
                        <div>
                            <strong>상담사 가입 완료</strong>
                            <p>상담사가 가입 링크에 접속한 후, 추가 정보를 입력해 가입을 완료합니다.</p>
                        </div>
                    </li>
                </ol>

                <div class="security-note">
                    <strong>주의사항</strong>
                    <p>
                        이메일 주소는 중복될 수 없으며, <br>가입 링크는 발송 후 24시간이 지나면 만료됩니다.
                    </p>
                </div>
            </div>
        </div>

        <!-- 최근 초대 내역 -->
        <div class="invite-history-card">
            <div class="history-header">
                <div>
                    <h3>최근 초대 내역</h3>
                    <p>최근 2일간 발송된 상담사 초대 상태를 확인합니다.</p>
                </div>
            </div>

            <div class="table-wrap">
                <table class="invite-history-table">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>발송일</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody id="inviteTableBody">
                    </tbody>
                </table>
            </div>
        </div>

    </section>
    <!-- 상담사 등록 콘텐츠 끝 -->
     <script>
        const ctx = "${pageContext.request.contextPath}";

        $(function(){
            
            // console.log("조회함수진입");
            selectInviteList();
            // http://www.localhost:8002/know-how/admin/invite/list

        });

        function selectInviteList(){
            $.ajax({
                url : ctx+"/admin/invite/list",
                type : "get",
                dataType : "html",
                success : function(result){
                    // console.log("조회결과도착");
                    $('#inviteTableBody').html(result);
                    
                },
                error : function(){
                    console.log("목록 조회 시  ajax 통신 실패!");
                    if (xhr.status !== 401 && xhr.status !== 403) {
                        alert('목록을 불러오는데 실패했습니다.');
                    }
                }
            });
        }

        function sendMail(){

            const counselorName = $("#counselorName").val().trim();
            const email = $("#counselorEmail").val().trim();

            if(counselorName === ""){
                alert("상담사 이름을 입력해주세요.");
                $("#counselorName").focus();
                return;
            }

            if(email === ""){
                alert("이메일을 입력해주세요.");
                $("#counselorEmail").focus();
                return;
            }      

            $.ajax({
                url : ctx+"/admin/invite/mail",
                type : "post",
                data : {
                    counselorName : counselorName,
                    email : email
                },
                success : function(result){
                    alert(result.message);
                    if(result.status === "SUCCESS"){
                        $("#counselorName").val("");
                        $("#counselorEmail").val("");
                        
                        //목록재조회
                        selectInviteList();
                    }
                },
                error : function(xhr){
                    console.log("상담사 초대메일 발송 ajax 통신 실패!");
                    console.log("ctx =", "${ctx}");
                    console.log("ajax url =", "${ctx}/admin/invite/mail");
                    console.log("에러코드 :", xhr.status);

                    if (xhr.status !== 401 && xhr.status !== 403) {
                        alert("초대 처리 중 문제가 발생했습니다. 문제가 지속될 경우 관리자에게 문의해주세요.");
                    }
                }
            });
        }
        
        function cancelInvite(btn){
            
            const inviteNo = $(btn).closest('td').data('invite-no');

            console.log(inviteNo);

            $.ajax({
                url : ctx + "/admin/invite/delete",
                type : "post",
                data : { inviteNo : inviteNo },
                success : function(){
                    
                    selectInviteList();
                },
                error : function(xhr){
                    console.log("inviteNo : " + inviteNo);
                    console.log("초대 취소 ajax 통신 실패! cancelInvite");
                    console.log("에러코드 :", xhr.status);

                    if (xhr.status !== 401 && xhr.status !== 403) {
                        alert("초대링크 삭제 중 오류가 발생했습니다.");
                    }
                }
            });
        }




     </script>