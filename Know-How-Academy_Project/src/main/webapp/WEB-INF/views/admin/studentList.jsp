<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
.student-section {
    width: 100%;
    padding: 0px 40px 80px;
    box-sizing: border-box;
}

/* 제목 영역 */
.student-title-area {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 28px;
}

.student-title-area h2 {
    margin: 0;
    font-size: 32px;
    font-weight: 800;
    color: #2c2f3f;
}

.student-title-area p {
    margin: 10px 0 0;
    font-size: 15px;
    color: #6b7280;
}

/* 검색 카드 */
.student-search-card {
    padding: 24px 28px;
    margin-bottom: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

.search-top-row {
    display: flex;
    align-items: flex-end;
    gap: 16px;
}

.search-field {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.search-field.small {
    flex: 0 0 180px;
}

.search-field label {
    font-size: 15px;
    font-weight: 800;
    color: #2c2f3f;
}

.student-search-input,
.student-select {
    height: 46px;
    padding: 0 14px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    background-color: #fff;
    color: #374151;
    font-size: 15px;
    outline: none;
}

.student-search-input:focus,
.student-select:focus {
    border-color: #4233c7;
    box-shadow: 0 0 0 3px rgba(66, 51, 199, 0.12);
}

.search-btn {
    height: 46px;
}

/* 검색어 칩 */
.search-keyword-area {
    display: flex;
    gap: 8px;
    margin-top: 14px;
}

.keyword-chip {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 7px 12px;
    border-radius: 8px;
    background-color: #f2f0ff;
    color: #4233c7;
    font-size: 14px;
    font-weight: 600;
}

.keyword-chip button {
    border: none;
    background: none;
    color: #6b5ce7;
    font-size: 16px;
    cursor: pointer;
}

/* 목록 카드 */
.student-list-card {
    padding: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

.list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.list-header strong {
    margin-right: 10px;
    font-size: 17px;
    font-weight: 800;
    color: #2c2f3f;
}

.list-header span {
    font-size: 14px;
    color: #6b7280;
}

.hide-rest-check {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #4b5563;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
}

.hide-rest-check input {
    width: 16px;
    height: 16px;
    accent-color: #4233c7;
}

/* 테이블 */
.student-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    font-size: 15px;
	min-width: 1100px;
}

.student-table thead th {
    height: 54px;
    padding: 0 18px;
    background-color: #fafafa;
    font-weight: 800;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
}

.student-table tbody td {
    padding: 16px 18px;
    border-bottom: 1px solid #eef0f4;
    vertical-align: middle;
}

.student-table tbody tr:last-child td {
    border-bottom: none;
}

.student-table tbody tr:hover {
    background-color: #fafaff;
}

/* 상태 배지 */
.student-status {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 58px;
    height: 28px;
    padding: 0 12px;
    border-radius: 999px;
    font-size: 13px;
    font-weight: 800;
}

.student-status.active {
    background-color: #e8f8ec;
    color: #128a3a;
}

.student-status.rest {
    background-color: #fff5d6;
    color: #c47a00;
}

/* 버튼 */
.btn-primary {
    min-width: 96px;
    height: 42px;
    padding: 0 22px;
    border: none;
    border-radius: 8px;
    background-color: #4233c7;
    color: #fff;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
}

.btn-primary:hover {
    background-color: #3528a8;
}

.btn-outline {
    min-width: 90px;
    height: 38px;
    padding: 0 16px;
    border: 1px solid #c9ccd6;
    border-radius: 8px;
    background-color: #fff;
    color: #4b5563;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
}

.btn-outline:hover {
    border-color: #4233c7;
    color: #4233c7;
}

.btn-outline.small {
    min-width: 82px;
    height: 36px;
}

/* 페이징 */
.pagination-area {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-top: 24px;
}

.pagination-area button {
    width: 36px;
    height: 36px;
    border: none;
    border-radius: 8px;
    background-color: #fff;
    color: #374151;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
}

.pagination-area button:hover {
    background-color: #f2f0ff;
    color: #4233c7;
}

.pagination-area button.active {
    background-color: #4233c7;
    color: #fff;
}
</style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- 학원생 목록조회 콘텐츠 시작 -->
	<section class="student-section">

		<!-- 페이지 제목 -->
		<div class="student-title-area">
			<div>
				<h2>학원생 관리</h2>
				<p>재원중, 휴원 상태의 학원생 정보를 조회하고 관리합니다.</p>
			</div>

			<button type="button" class="btn-primary" onclick="go('/admin/student/enroll')">
				가입 승인 관리
			</button>
		</div>

		<!-- 검색 / 필터 카드 -->
		<div class="student-search-card">
			<form action="/know-how/admin/studentList/search" method="get">
				<div class="search-top-row">
					<div class="search-field">
						<label for="studentKeyword">검색어</label>
						<input type="search"
							id="studentKeyword"
							name="keyword"
							class="student-search-input"
							placeholder="이름 또는 연락처 검색">
					</div>
	
					<div class="search-field small">
						<label for="studentStatus">상태</label>
						<select id="studentStatus" name="status" class="student-select">
							<option value="">전체</option>
							<option value="ACTIVE">재학</option>
							<option value="REST">휴학</option>
						</select>
					</div>
	
					<button type="submit" class="btn-primary search-btn">
						검색
					</button>
				</div>
			</form>
			<!-- 검색어 재출력 자리 -->
			<c:if test="${ not empty requestScope.keyword }">
				<div class="search-keyword-area">
					<span class="keyword-chip">
						검색어: <strong>${ requestScope.keyword }</strong>
						<button type="button" onclick="go('/admin/studentList')">×</button>
					</span>
				</div>
			</c:if>

		</div>

		<!-- 목록 카드 -->
		<div class="student-list-card">

			<div class="list-header">
				<div>
					<strong>총 ${ requestScope.pi.listCount }명</strong>
					<span>재원중 / 휴원 상태의 학원생만 표시됩니다.</span>
				</div>

				<label class="hide-rest-check">
					<input type="checkbox">
					휴학생 숨기기
				</label>
			</div>
			<script>
				$('.hide-rest-check>input').on('change', function() {
					if($(this).is(':checked')) {
						$('.student-table>tbody tr').each(function() {
							if ($(this).find('span').text().trim() === '휴학') {
								$(this).hide();
								if ($('.student-table>tbody tr:visible').length === 0) {
						            $('#emptyRow').show();
						        }
							} 
						});
					} else {
						$('.student-table>tbody tr').show();
						$('#emptyRow').hide();
					}
				});
			</script>
			<div class="table-wrap">
				<table class="student-table">
					<thead>
						<tr>
							<th>이름</th>
							<th>연락처</th>
							<th>담당 상담사</th>
							<th>등록일</th>
							<th>현재 상태</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<c:choose>
							<c:when test="${ empty requestScope.list }">
								<tr>
									<th colspan="6">
										학생 정보가 없습니다.
									</th>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="emptyRow" style="display: none;">
									<th colspan="6">
										학생 정보가 없습니다.
									</th>
								</tr>	
								<c:forEach var="s" items="${ requestScope.list }">
									<tr>
										<td>${ s.studentName }</td>
										<td>${ s.phone }</td>
										<td>${ s.counselorName }</td>
										<td>${ s.createdAt }</td>
										<td>
											<c:choose>
												<c:when test="${ s.status eq 'ATTENDING' }">
													<span class="student-status active">재학</span>
												</c:when>
												<c:otherwise>
													<span class="student-status rest">휴학</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<button type="button" class="btn-outline small" onclick="go('/admin/studentDetails/${ s.studentNo }')">상세보기</button>
											<input type="hidden" value="${ s.studentNo }">
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>	

			<!-- 페이징 -->
			<div class="pagination-area">
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq 1 }">
						<button type="button" disabled>&lt;</button>
					</c:when>
					<c:otherwise>
					
						<c:choose>
							<c:when test="${ empty requestScope.condition }">
								<button type="button" onclick="go('/admin/studentList?cpage=${ requestScope.pi.currentPage - 1 }')">&lt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/admin/studentList/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage - 1 }')">&lt;</button>
							</c:otherwise>
							
						</c:choose>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${ requestScope.pi.startPage }" end="${ requestScope.pi.endPage }" step="1">
					
					<c:choose>
						<c:when test="${ requestScope.pi.currentPage eq p }">
							<button type="button" class="active">${ p }</button>
						</c:when>
						<c:otherwise>
						
							<c:choose>
								<c:when test="${ empty requestScope.status }">
									<button type="button" onclick="go('/admin/studentList?cpage=${ p }')">${ p }</button>
								</c:when>
								<c:otherwise>
									<button type="button" onclick="go('/admin/studentList/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ p }')">${ p }</button>
								</c:otherwise>
							</c:choose>
							
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
				
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage or empty requestScope.list }">
						<button type="button" disabled>&gt;</button>
					</c:when>
					<c:otherwise>
					
						<c:choose>
							<c:when test="${ empty requestScope.status }">
								<button type="button" onclick="go('/admin/studentList?cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/admin/studentList/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<!-- 학원생 목록조회 콘텐츠 끝 -->