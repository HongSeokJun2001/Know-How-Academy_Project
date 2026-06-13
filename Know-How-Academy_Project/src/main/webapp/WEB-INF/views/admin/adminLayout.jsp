<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KNOW-HOW ACADEMY 관리자 페이지</title>
<style>
    /* 1. 기본 초기화 (브라우저 기본 여백 제거) */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Pretendard', sans-serif;
    }

    html, body {
        width: 100%;
        height: 100%;
        background-color: #F8F9FA;                  /* 메인 배경: 옅은 회색 */
        color: #2C2A38;
        overflow: hidden;                             /* 브라우저 자체 스크롤 막고 내부 스크롤 유도 */
    }

    /* 2. 상단 고정 바 (GNB) */
    #fake-header {
        width: 100%;
        height: 60px;
        background-color: #4233C7;
        color: white;

        display: flex;
        align-items: center;

        padding: 0 24px;

        position: fixed;
        top: 0;
        left: 0;

        z-index: 1000;
    }

    .header-title {
        display: flex;
        align-items: center;
        gap: 8px;

        font-size: 18px;
        font-weight: 700;
    }

    .header-user-area {
        margin-left: auto;

        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logout-btn {
        height: 34px;
        padding: 0 14px;

        border: 1px solid rgba(255, 255, 255, 0.45);
        border-radius: 8px;

        background: rgba(255, 255, 255, 0.12);
        color: white;

        font-size: 13px;
        font-weight: 700;

        cursor: pointer;
    }

    .logout-btn:hover {
        background: rgba(255, 255, 255, 0.22);
    }

    /* 로고 */
    #fake-header img {
        width: 36px;
        height: 36px;
        object-fit: contain;
    }

    /* 3. 메인 컨테이너 (사이드바와 본문을 가로로 배치) */
    #main-container {
        display: flex;

        width: 100%;
        height: 100%;

        padding-top: 60px;                          /* 헤더 높이만큼 아래로 밀기 */
    }

    /* 4. 좌측 사이드바 (LNB) */
    #sidebar {
        width: 220px;                               /* 사이드바 고정 너비 */
        height: 100%;

        background-color: #FFFFFF;
        border-right: 1px solid #EAE9F5;

        padding: 24px 16px;

        display: flex;
        flex-direction: column;
        gap: 8px; /* 메뉴 아이템 간격 */
    }

    /* 사이드바 대분류 텍스트 (예: 관리페이지) */
    .sidebar-category {
        font-size: 12px;
        color: #9291A5;
        font-weight: 700;

        margin: 12px 0 4px 12px;
    }

    /* 사이드바 메뉴 아이템 공통 */
    .menu-item {
        width: 100%;
        height: 48px;

        display: flex;
        align-items: center;

        padding-left: 16px;
        
        border-radius: 8px;

        font-size: 15px;
        font-weight: 600;

        color: #5C5B6E;                     /* 기본 메뉴 글자색 */

        cursor: pointer;
        transition: all 0.2s ease;
    }

    /* 메뉴 호버 효과 */
    .menu-item:hover {
        background-color: #F8F7FF;
        color: #4233C7;
    }

    /* '선택된 메뉴' 상태 스타일 */
    .menu-item.active {
        background-color: #F3F1FF;          /* 은은한 라벤더 배경 */
        color: #4233C7;                     /* 우리 테마색 */
    }


    /* 5. 우측 메인 콘텐츠 영역 (여기에 대시보드 내용이 들어감) */
    #content-area {
        flex: 1;                            /* 사이드바가 차지하고 남은 공간을 통째로 다 쓰기 */
        height: 100%;

        padding: 32px;

        overflow-y: auto;                   /* 내용이 많아지면 이 영역만 스크롤 생김 */
    }

    /* 임시 본문 타이틀 스타일 */
    .page-title {
        font-size: 22px;
        font-weight: 700;

        margin-bottom: 24px;
    }

    /* 흰색 대시보드 카드 카드  */
    .dashboard-card {
        background: white;
        border-radius: 12px;

        padding: 24px;

        border: 1px solid #EAE9F5;

        box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.02);
    }


    .approval-banner {
        display: flex;
        align-items: center;
        justify-content: space-between;

        padding: 14px 20px;

        background: #FFFFFF;
        border: 1px solid #DDD8FF;
        border-radius: 16px;

        box-shadow: 0 4px 14px rgba(66, 51, 199, 0.06);
    }

    .approval-left {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .approval-icon {
        width: 64px;
        height: 64px;

        border-radius: 50%;
        background: #F3F1FF;
        color: #4233C7;

        display: flex;
        align-items: center;
        justify-content: center;

        font-size: 28px;
    }

    .approval-title {
        font-size: 22px;
        font-weight: 800;
        color: #2C2A38;
        margin-bottom: 8px;
    }

    .approval-desc {
        font-size: 15px;
        color: #6F6D80;
    }

    .approval-count {
        display: flex;
        align-items: center;
        gap: 28px;
    }

    .approval-count strong {
        font-size: 42px;
        color: #4233C7;
    }

    .approval-count span {
        font-size: 18px;
        font-weight: 700;
        color: #4233C7;
    }

        .primary-btn {
        height: 46px;
        padding: 0 22px;

        border: 1px solid #DDD8FF;
        border-radius: 10px;

        background: #FFFFFF;
        color: #4233C7;

        font-size: 15px;
        font-weight: 700;

        cursor: pointer;
    }

    .primary-btn:hover {
        background: #F3F1FF;
    }
    /* 테이블 잘림 방지 */
	.table-wrap {
		width: 100%;
		overflow-x: auto;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <!-- 
        http://localhost:8002/know-how/admin/
    -->

    <div id="fake-header">
        <div class="header-title">
            <img src="${pageContext.request.contextPath}/resources/image/로고색반전1.png"
                alt="know-how-academy 마크">
            <span>KNOW-HOW ACADEMY</span>
            <span>관리자 페이지</span>
        </div>

        <div class="header-user-area">
            <div class="admin-profile">${ sessionScope.loginUser.userName }</div>
            <span class="admin-name">관리자님</span>
            <button type="button" class="logout-btn" onclick="logoutAdmin()">
                로그아웃
            </button>
        </div>
    </div>

    <div id="main-container">
        <!-- 메뉴바 -->
        <div id="sidebar">
            <div class="menu-item" data-path="/admin/index" 
                onclick="go('/admin/index')">
                메인페이지
            </div>

            <div class="menu-item" data-path="/admin/counselorInvite" 
                onclick="go('/admin/counselorInvite')">
                상담사 등록
            </div>
            <div class="sidebar-category">
                관리페이지
            </div>
            <div class="menu-item ${page.contains('student') ? 'active' : ''}" data-path="/admin/studentList"
                 onclick="go('/admin/studentList')">
                학원생 관리
            </div>

            <div class="menu-item" data-path="/admin/counselorList"
                 onclick="go('/admin/counselorList')">
                상담사 관리
            </div>
            <div class="sidebar-category">
                설정
            </div>
            <div class="menu-item  ${page.contains('Notice') ? 'active' : ''}" data-path="/admin/notice"
                 onclick="go('/admin/notice')">
                공지사항 관리
            </div>
            <div class="menu-item  ${page.contains('academyNews') ? 'active' : ''}" data-path="/admin/academyNews"
                 onclick="go('/admin/academyNews')">
                학원소식 관리
            </div>
            <div class="menu-item" data-path="/admin/memberLocked"
                 onclick="go('/admin/memberLocked')">
                계정잠금 관리
            </div>
        </div>

        <div id="content-area">
            <div class="dashboard-card">
                <section class="approval-banner">
                    <div class="approval-left">
                        <div class="approval-icon">🔔</div>
                        <div>
                            <div class="approval-title">신규 가입 승인 대기</div>
                        </div>
                    </div>

                    <div class="approval-count">
                        <div>
                            <strong>${requestScope.alarmCount}</strong>
                            <span>건</span>
                        </div>
                        <button type="button" class="primary-btn" onclick="go('/admin/student/enroll')">
                            바로 확인하기
                        </button>
                    </div>
                </section>
            </div>

            <br>

            <jsp:include page="${page}.jsp" />
        </div>
    </div>
   
    

<script>

    const cp = "${pageContext.request.contextPath}";

    $(document).ajaxError(function(event, xhr, settings, thrownError) {
        if (xhr.status === 401) {
            alert("세션이 만료되어 로그인이 필요합니다.");
            location.href = "cp/admin/login"; 
        } else if (xhr.status === 403) {
            alert("관리자 권한이 없습니다. 정상적인 경로로 이용해주세요.");
            location.href = "cp/"; 
        }
    });
    

    function logoutAdmin() {
        if(confirm("로그아웃 하시겠습니까?")) {
            location.href = cp + "/admin/logout";
        }
    }

    function go(path) {
        location.href = cp + path;
    }

    window.onload = function () {

        const currentPath = location.pathname.replace(cp, "");

        document.querySelectorAll(".menu-item").forEach(item => {

            if(item.dataset.path === currentPath) {
                item.classList.add("active");
            }

        });

    };

    

</script>
</body>
</html>