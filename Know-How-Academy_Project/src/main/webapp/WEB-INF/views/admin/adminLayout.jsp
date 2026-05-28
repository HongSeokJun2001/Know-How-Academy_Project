<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        background-color: #4233C7;                  /* 팀 테마색 */
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

    /* 알림 카드 */
    .alarm-card {
        padding: 15px;
    }

    .alarm-icon {
        width: 25px;
        height: 25px;
        vertical-align: middle;
    }
</style>
</head>
<body>

    <div id="fake-header">
        <img src="${pageContext.request.contextPath}/resources/image/로고색반전1.png"
             alt="know-how-academy 마크">
        &thinsp;
        KNOW-HOW ACADEMY &thinsp; 관리자 페이지
    </div>

    <div id="main-container">
        
        <div id="sidebar">
            <div class="menu-item" data-path="/admin/index" onclick="go('/admin/index')">메인페이지</div>
            <div class="menu-item" data-path="/admin/counselor/enroll" onclick="go('/admin/counselor/enroll')">
                상담사 등록
            </div>

            <div class="sidebar-category">
                관리페이지
            </div>

            <div class="menu-item"
                 data-path="/admin/student"
                 onclick="go('/admin/student')">
                학원생 관리
            </div>

            <div class="menu-item"
                 data-path="/admin/counselor"
                 onclick="go('/admin/counselor')">
                상담사 관리
            </div>

            <div class="sidebar-category">
                설정
            </div>

            <div class="menu-item"
                 data-path="/admin/notice"
                 onclick="go('/admin/notice')">
                공지사항 관리
            </div>
        </div>
        <!-- 
            http://localhost:8002/know-how/admin/alarm/count
        -->
        <form action="/know-how/admin/alarm/count" method="get">
            <div id="content-area">
                <div class="dashboard-card alarm-card">
                    <img src="${pageContext.request.contextPath}/resources/image/종.png" alt="알림표시" class="alarm-icon">
                </div>

                <br><br>

                <jsp:include page="${page}.jsp" />
            </div>
        </form>
    </div>
    
<script>

    const cp = "${pageContext.request.contextPath}";

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