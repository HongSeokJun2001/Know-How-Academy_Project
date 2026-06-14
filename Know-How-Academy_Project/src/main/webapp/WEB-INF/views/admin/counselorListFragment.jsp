<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>


    /* 3. 내 맘대로 가로 길이(비율) 조절 */
    .counselor-table th:nth-child(1) { width: 8%; }
    .counselor-table th:nth-child(2) { width: 13%; } /* 이메일 칸 */
    .counselor-table th:nth-child(3) { width: 13%; }
    .counselor-table th:nth-child(4) { width: 20%; }
    .counselor-table th:nth-child(5) { width: 8%; }
    .counselor-table th:nth-child(6) { width: 15%; }


</style>

    <!-- 리스트 카드 -->
    <div class="list-card">

        <div class="list-card-header">
            <strong>상담사 ${requestScope.list.pageInfo.listCount}명</strong>
            <span>동명이인 구분을 위해 이메일과 현재 담당 정보를 함께 표시합니다.</span>
        </div>
        <div class="table-wrap">
            <table class="counselor-table">
                <thead>
                    <tr>
                        <th>상담사명</th>
                        <th>이메일</th>
                        <th>현재 담당</th>
                        <th>담당 직무 변경</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${requestScope.list.pageInfo.listCount eq 0}">
                            <tr>
                                
                                <th colspan="6">
                                    상담사 정보가 없습니다.
                                </th>
                                
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${requestScope.list.counselorList}">
                                <tr>
                                    <td onclick="go('/admin/counselorProfile/${c.userNo}')">
                                        ${c.userName}
                                    </td>
                                    <td><div class="email-ellipsis" onclick="setOverflow(this);">${c.email}</div></td>
                                    <c:choose>

                                        <%-- 초대 대기중인 상담사 --%>
                                        <c:when test="${c.status eq 'PENDING'}">
                                            <td>미배정</td>
                                            <td>
                                                <select class="class-select" disabled>
                                                    <option>비활성화</option>
                                                </select>
                                            </td>
                                            <td>
                                                <span class="status-badge waiting">초대대기</span>
                                            </td>
                                            <td>
                                                <div class="action-group">
                                                    <button type="button" class="btn-danger-outline"
                                                            onclick="deleteInvite(${c.inviteNo})">초대삭제</button>
                                                </div>
                                            </td>
                                        </c:when>

                                        <%-- 재직중인 상담사 --%>
                                        <c:when test="${c.status eq 'ACTIVE'}">
                                            <td>
                                                ${not empty c.className ? c.className
                                                 : not empty c.categoryName ? c.categoryName += '상담사'
                                                    : "미배정"}
                                            </td>
                                            <td>
                                                <select class="class-select" id="classSelect-${c.userNo}">
                                                    <option selected disabled>
                                                        <c:choose>
                                                            <c:when test="${not empty c.className}">
                                                                ${c.className}
                                                            </c:when>
                                                            <c:when test="${3 eq c.categoryNo}">
                                                                수강상담사 · CLASS 미지정
                                                            </c:when>
                                                            <c:when test="${not empty c.categoryName}">
                                                                ${c.categoryName}상담사
                                                            </c:when>
                                                            <c:otherwise>
                                                                미지정
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </option>

                                                    <%-- 담임(학습 상담사): 반 변경 또는 미지정 가능 --%>
                                                    <c:if test="${3 eq c.categoryNo}">
                                                        <c:if test="${not empty c.classNo}">
                                                            <option data-change-type="CLASS" data-change-no="">
                                                                CLASS 미지정
                                                            </option>
                                                        </c:if>
                                                        <c:forEach var="cl" items="${requestScope.list.classList}">
                                                            <option data-change-type="CLASS" data-change-no="${cl.classNo}">
                                                                ${cl.className}
                                                            </option>
                                                        </c:forEach>
                                                    </c:if>

                                                    <%-- 일반 상담사 또는 반이 미지정된 담임(학습 상담사): 카테고리 변경 가능 --%>
                                                    <c:if test="${empty c.classNo}">
                                                        <c:forEach var="category" items="${requestScope.list.categoryList}">
                                                            <c:if test="${category.categoryNo ne c.categoryNo and c.categoryNo ne category.categoryNo}">
                                                                <option data-change-type="CATEGORY" data-change-no="${category.categoryNo}">
                                                                    ${category.categoryName}상담사
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>

                                                </select>
                                            </td>
                                            <td>
                                                <span class="status-badge active">활성</span>
                                            </td>
                                            <td>
                                                <div class="action-group">
                                                    <button type="button" class="btn-primary small"
                                                            onclick="updateClass(${c.userNo});">저장</button>
                                                    <button type="button" class="btn-outline"
                                                            onclick="go('/admin/counselorProfile/${c.userNo}')">상세보기</button>
                                                </div>
                                            </td>
                                        </c:when>
                                        <c:when test="${c.status eq 'INACTIVE'}">
                                            <td>미배정</td>
                                            <td>
                                                <select class="class-select" disabled>
                                                    <option>비활성화</option>
                                                </select>
                                            </td>
                                            <td>
                                                <span class="status-badge inactive">비활성화</span>
                                            </td>
                                            <td>
                                                <div class="action-group">
                                                    <button type="button" class="btn-outline"
                                                            onclick="go('/admin/counselorProfile/${c.userNo}')">상세보기</button>
                                                </div>
                                            </td>
                                        </c:when>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>	

        <!-- 페이징 -->
        <div class="pagination-area">
            <!-- 이전 버튼 -->
            <c:choose>
                <c:when test="${requestScope.list.pageInfo.currentPage eq 1}">
                    <button type="button" disabled>&lt;</button>
                </c:when>

                <c:otherwise>
                    <button type="button"
                        onclick="reloadCounselorList(${requestScope.list.pageInfo.currentPage - 1})">
                        &lt;
                    </button>
                </c:otherwise>
            </c:choose>


            <!-- 페이지 번호 -->
            <c:forEach var="p"
                begin="${requestScope.list.pageInfo.startPage}"
                end="${requestScope.list.pageInfo.endPage}">

                <c:choose>
                    <c:when test="${requestScope.list.pageInfo.currentPage eq p}">
                        <button type="button" class="active">${p}</button>
                    </c:when>

                    <c:otherwise>
                        <button type="button"
                            onclick="reloadCounselorList(${p})">
                            ${p}
                        </button>
                    </c:otherwise>
                </c:choose>

            </c:forEach>


            <!-- 다음 버튼 -->
            <c:choose>
                <c:when test="${requestScope.list.pageInfo.currentPage eq requestScope.list.pageInfo.maxPage 
                                or empty requestScope.list.counselorList}">
                    <button type="button" disabled>&gt;</button>
                </c:when>

                <c:otherwise>
                    <button type="button"
                            onclick="reloadCounselorList(${requestScope.list.pageInfo.currentPage + 1})">
                        &gt;
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <input type="hidden" id="currentCounselorPage" value="${requestScope.list.pageInfo.currentPage}">

    <script>
        function setOverflow(element) {
            element.classList.toggle("show-all");
        }
    </script>