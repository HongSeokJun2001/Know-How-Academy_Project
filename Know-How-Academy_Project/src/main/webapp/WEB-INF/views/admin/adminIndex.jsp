<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    .admin-main {
        display: flex;
        flex-direction: column;
        gap: 28px;
    }

    .approval-banner {
        display: flex;
        align-items: center;
        justify-content: space-between;

        padding: 28px 32px;

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

    .work-section {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
    }

    .section-card {
        background: #FFFFFF;
        border: 1px solid #EAE9F5;
        border-radius: 16px;

        padding: 24px;

        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.025);
        min-height: 330px;
    }

    .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;

        margin-bottom: 22px;
    }

    .section-title-wrap {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .section-icon {
        color: #4233C7;
        font-size: 22px;
    }

    .section-title {
        font-size: 20px;
        font-weight: 800;
        color: #2C2A38;
    }

    .count-badge {
        padding: 4px 10px;

        border-radius: 999px;
        background: #F3F1FF;
        color: #4233C7;

        font-size: 13px;
        font-weight: 800;
    }

    .more-link {
        color: #6F6D80;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
    }

    .more-link:hover {
        color: #4233C7;
    }

    .admin-table {
        width: 100%;
        border-collapse: collapse;
    }

    .admin-table th {
        padding: 14px 10px;

        border-bottom: 1px solid #EAE9F5;

        color: #2C2A38;
        font-size: 14px;
        font-weight: 800;
        text-align: center;
    }

    .admin-table td {
        padding: 16px 10px;

        color: #3B3948;
        font-size: 14px;
        text-align: center;
    }

    .text-danger {
        color: #F04452 !important;
        font-weight: 700;
    }

    .text-success {
        color: #12A150 !important;
        font-weight: 800;
    }

    .type-badge {
        display: inline-block;

        padding: 5px 10px;
        border-radius: 8px;

        font-size: 13px;
        font-weight: 800;
    }

    .type-job {
        background: #FFECEF;
        color: #F04452;
    }

    .type-enter {
        background: #EEF3FF;
        color: #2F5FE3;
    }

    .type-green {
        background: #E9F8EF;
        color: #12A150;
    }

    .stats-title {
        font-size: 18px;
        font-weight: 800;
        color: #2C2A38;
        margin-bottom: 16px;
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
    }

    .stat-card {
        background: #FFFFFF;
        border: 1px solid #EAE9F5;
        border-top: 4px solid #4233C7;
        border-radius: 14px;

        padding: 24px;

        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.025);
    }

    .stat-top {
        display: flex;
        align-items: center;
        gap: 14px;

        margin-bottom: 16px;
    }

    .stat-icon {
        width: 46px;
        height: 46px;

        border-radius: 50%;
        background: #F3F1FF;
        color: #4233C7;

        display: flex;
        align-items: center;
        justify-content: center;

        font-size: 22px;
    }

    .stat-label {
        font-size: 15px;
        font-weight: 700;
        color: #5C5B6E;
    }

    .stat-number {
        font-size: 34px;
        font-weight: 900;
        color: #2C2A38;
        margin-bottom: 10px;
    }

    .stat-number span {
        font-size: 16px;
        font-weight: 700;
    }

    .stat-sub {
        font-size: 14px;
        color: #6F6D80;
    }

    .stat-sub strong {
        color: #4233C7;
    }
</style>

<div class="admin-main">

    <!-- 신규 가입 승인 배너 -->
    <section class="approval-banner">
        <div class="approval-left">
            <div class="approval-icon">🔔</div>

            <div>
                <div class="approval-title">신규 가입 승인 대기</div>
                <div class="approval-desc">승인 대기 중인 신규 가입 신청이 1건 있습니다.</div>
            </div>
        </div>

        <div class="approval-count">
            <div>
                <strong>1</strong>
                <span>건</span>
            </div>

            <button type="button" class="primary-btn" onclick="go('/admin/student/enroll')">
                바로 확인하기
            </button>
        </div>
    </section>


    <!-- 업무 영역 -->
    <section class="work-section">

        <!-- 상담 신청 대기 목록 -->
        <div class="section-card">
            <div class="section-header">
                <div class="section-title-wrap">
                    <span class="section-icon">👥</span>
                    <h3 class="section-title">상담 신청 대기 목록</h3>
                    <span class="count-badge">4건</span>
                </div>

                <a href="javascript:void(0);" class="more-link" onclick="go('/admin/counsel')">
                    전체 보기 &gt;
                </a>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>신청일</th>
                        <th>이름</th>
                        <th>상담 종류</th>
                        <th>클래스</th>
                        <th>상담사</th>
                        <th>경과일</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td class="text-danger">3일전</td>
                        <td>진달래</td>
                        <td><span class="type-badge type-job">취업상담</span></td>
                        <td>H반</td>
                        <td>김사람</td>
                        <td class="text-danger">3일</td>
                    </tr>

                    <tr>
                        <td>3시간전</td>
                        <td>홍길동</td>
                        <td><span class="type-badge type-enter">입학상담</span></td>
                        <td>G반</td>
                        <td>이사람</td>
                        <td>0일</td>
                    </tr>

                    <tr>
                        <td>3시간전</td>
                        <td>김춘자</td>
                        <td><span class="type-badge type-enter">입학상담</span></td>
                        <td>V반</td>
                        <td>정사람</td>
                        <td>0일</td>
                    </tr>

                    <tr>
                        <td class="text-success">NEW</td>
                        <td>지피티</td>
                        <td><span class="type-badge type-enter">입학상담</span></td>
                        <td>G반</td>
                        <td>이사람</td>
                        <td>0일</td>
                    </tr>
                </tbody>
            </table>
        </div>


        <!-- 금일 상담 일정 -->
        <div class="section-card">
            <div class="section-header">
                <div class="section-title-wrap">
                    <span class="section-icon">📅</span>
                    <h3 class="section-title">금일 상담 일정</h3>
                    <span class="count-badge">1건</span>
                </div>

                <a href="javascript:void(0);" class="more-link" onclick="go('/admin/schedule')">
                    전체 일정 보기 &gt;
                </a>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>시간</th>
                        <th>상담 종류</th>
                        <th>이름</th>
                        <th>상담사</th>
                        <th>장소</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td>11:00</td>
                        <td><span class="type-badge type-green">입학상담</span></td>
                        <td>일론머스크</td>
                        <td>김사람</td>
                        <td>상담실 1</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </section>


    <!-- 주요 통계 -->
    <section>
        <div class="stats-title">주요 통계</div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon">👥</div>
                    <div class="stat-label">전체 재원생</div>
                </div>

                <div class="stat-number">133<span>명</span></div>
                <div class="stat-sub">전월 대비 <strong>▲ 7명</strong></div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon">➕</div>
                    <div class="stat-label">이번달 신규 등록</div>
                </div>

                <div class="stat-number">18<span>명</span></div>
                <div class="stat-sub">전월 대비 <strong>▲ 4명</strong></div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon">📅</div>
                    <div class="stat-label">금일 상담 건수</div>
                </div>

                <div class="stat-number">13<span>건</span></div>
                <div class="stat-sub">오전 5건 / 오후 8건</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div class="stat-icon">⚠️</div>
                    <div class="stat-label">미처리 상담 건수</div>
                </div>

                <div class="stat-number">13<span>건</span></div>
                <div class="stat-sub">최장 대기 <strong class="text-danger">3일</strong></div>
            </div>
        </div>
    </section>

</div>