<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .admin-main {
        display: flex;
        flex-direction: column;
        gap: 28px;
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

    /* 상담 카테고리별 버튼색 지정 */
    .type-badge {
        display: inline-block;

        padding: 5px 10px;
        border-radius: 8px;

        font-size: 13px;
        font-weight: 800;
    }

    .category-1 {
        background: #EEF3FF;
        color: #2F5FE3;
    }

    .category-2 {
        background: #E9F8EF;
        color: #12A150;
    }

    .category-3 {
        background: #FFF4E5;
        color: #F59E0B;
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

    /* 그래프 css */
    .chart-section {
        width: 100%;
    }

    .chart-card {
        min-height: 260px;
    }

    .bar-chart {
        display: flex;
        flex-direction: column;
        gap: 26px;

        margin-top: 28px;
    }

    .bar-row {
        display: grid;
        grid-template-columns: 100px 1fr;
        align-items: center;
        gap: 18px;
    }

    .bar-label {
        font-size: 15px;
        font-weight: 800;
        color: #2C2A38;
    }

    .bar-track {
        width: 100%;
        height: 34px;

        background: #F3F1FF;
        border-radius: 999px;

        overflow: hidden;
    }

    .bar-fill {
        height: 100%;

        display: flex;
        align-items: center;
        justify-content: flex-end;

        padding-right: 14px;

        border-radius: 999px;

        font-size: 14px;
        font-weight: 800;
        color: #FFFFFF;

        transition: width 0.3s ease;
    }

    .bar-fill.category-1 {
        background: #4233C7;
    }

    .bar-fill.category-2 {
        background: #12A150;
    }

    .bar-fill.category-3 {
        background: #F59E0B;
    }

    .bar-fill span {
        white-space: nowrap;
    }

    .chart-summary{
        margin-top:24px;

        font-size:14px;
        color:#6F6D80;
    }

    .chart-summary .up{
        color:#12A150;
    }

    .chart-summary .down{
        color:#F04452;
    }

    .bar-row {
        cursor: pointer;
    }

    .chart-footer{
        display:flex;
        gap:12px;
        margin-top:16px;
    }

    .info-card{
        flex:1;
        padding:12px;
        border-radius:12px;
        background:#F8F9FA;
    }

    .info-title{
        font-size:14px;
        font-weight:700;
        margin-bottom:8px;
    }

    .info-row{
        display:flex;
        justify-content:space-between;
        align-items:center;
    }

    .up{
        color:#12A150;
        font-weight:700;
    }

    .down{
        color:#E74C3C;
        font-weight:700;
    }

    .table-scroll {
        max-height: 350px;
        overflow-y: auto;
    }

    .admin-table tbody tr:hover {
        background-color: #fafaff;
    }
</style>

<div class="admin-main">

    <!-- 업무 영역 -->
    <section class="work-section">

        <!-- 상담 신청 대기 목록 -->
        <div class="section-card">
            <div class="section-header">
                <div class="section-title-wrap">
                    <span class="section-icon">👥</span>
                    <h3 class="section-title">상담 신청 대기 목록</h3>
                    <span class="count-badge">${CounselWaitingCount}건</span>
                </div>
            </div>

            <div class="table-scroll">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>신청일</th>
                            <th>이름</th>
                            <th>상담 종류</th>
                            <th>클래스</th>
                            <th>상담사</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:if test="${empty requestScope.waitingList}">
                            <tr>
                                <td colspan="5">
                                    <span>조회된 정보가 없습니다.</span>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="w" items="${requestScope.waitingList}">
                            <tr>
                                <td class="${w.elapsedDays gt 3 ? 'text-danger' : ''}">
                                    ${w.createdAt}
                                </td>
                                <td>${w.studentName}</td>
                                <td>
                                    <span class="type-badge category-${w.categoryNo}">
                                        ${w.categoryName}상담
                                    </span>
                                </td>
                                <td>${w.className}</td>
                                <td>${w.counselorName}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- 금일 상담 일정 -->
        <div class="section-card">
            <div class="section-header">
                <div class="section-title-wrap">
                    <span class="section-icon">📅</span>
                    <h3 class="section-title">금일 상담 일정</h3>
                    <span class="count-badge">${todayReservatioCount}건</span>
                </div>
            </div>

            <div class="table-scroll">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>시간</th>
                            <th>상담 종류</th>
                            <th>이름</th>
                            <th>상담사</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:if test="${empty requestScope.reservationList}">
                            <tr>
                                <td colspan="4">
                                    <span>조회된 정보가 없습니다.</span>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="t" items="${requestScope.reservationList}">
                            <tr>
                                <td>${t.reservationTime}</td>
                                <td>
                                    <span class="type-badge category-${t.categoryNo}">
                                        ${t.categoryName}상담
                                    </span>
                                </td>
                                <td>${t.studentName}</td>
                                <td>${t.counselorName}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

    </section>


    <!-- 월간 통계  -->
    <section>
        <div class="section-card chart-card">

            <div class="section-header">
                <div class="section-title-wrap">
                    <span class="section-icon">📊</span>
                    <h3 class="section-title">월간 상담 유형별 신청 현황</h3>
                </div>
            </div>
            
            <div class="bar-chart">
                <c:if test="${empty requestScope.dashboard}">
                        <span>조회된 정보가 없습니다.</span>
                        <c:forEach var="cl" items="${requestScope.counselCategory}">
                            <div class="bar-row">
                                <div class="bar-label">${cl.categoryName}상담</div>
                                <div class="bar-track">
                                    <div class="bar-fill category-${cl.categoryName}" style="width: 0%;">
                                        <span>0건</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                <c:forEach var="d" items="${requestScope.dashboard}">
                    <div class="bar-row">
                        <div class="bar-label">${d.categoryName}상담</div>
                        <div class="bar-track">
                            <div class="bar-fill category-${d.categoryNo}" style="width: ${d.rate}%;">
                                <span>${d.currCount}건</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
<br>
            <div class="chart-footer">

                <div class="info-card trend-card">
                    <div class="info-title">🔥 전월 대비</div>
                    <c:if test="${empty requestScope.dashboard}">
                        <span>조회된 정보가 없습니다.</span>
                    </c:if>
                    <c:forEach var="d" items="${requestScope.dashboard}">
                        <c:choose>
                            <c:when test="${d.currCount - d.prevCount gt 0 }">
                                <div class="info-row">
                                    <span>${d.categoryName}상담</span>
                                    <span class="up">+${d.currCount}건</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="info-row">
                                    <span>${d.categoryName}상담</span>
                                    <span class="down">-${d.currCount}건</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

                <div class="info-card rate-card">
                    <div class="info-title">✅ 신청률</div>
                    <c:if test="${empty requestScope.dashboard}">
                        <span>조회된 정보가 없습니다.</span>
                    </c:if>
                    <c:forEach var="d" items="${requestScope.dashboard}">
                        <div class="info-row">
                            <span>${d.categoryName}상담</span>
                            <span>${d.rate}%</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>

</div>



