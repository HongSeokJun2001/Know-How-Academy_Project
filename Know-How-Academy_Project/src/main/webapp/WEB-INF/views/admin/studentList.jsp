<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.student-section {
    width: 100%;
    padding: 40px 52px 80px;
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
    overflow: hidden;
    font-size: 15px;
}

.student-table thead th {
    height: 54px;
    padding: 0 18px;
    background-color: #fafafa;
    color: #2c2f3f;
    font-weight: 800;
    text-align: left;
    border-bottom: 1px solid #e5e7eb;
}

.student-table tbody td {
    padding: 16px 18px;
    color: #374151;
    border-bottom: 1px solid #eef0f4;
    vertical-align: middle;
}

.student-table tbody tr:last-child td {
    border-bottom: none;
}

.student-table tbody tr:hover {
    background-color: #fafaff;
}

.student-name-link {
    color: #4233c7;
    font-weight: 800;
    text-decoration: underline;
    text-underline-offset: 3px;
}

.student-name-link:hover {
    color: #2f2499;
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
	<!-- 학원생 목록조회 콘텐츠 시작 -->
	<section class="student-section">

		<!-- 페이지 제목 -->
		<div class="student-title-area">
			<div>
				<h2>학원생 관리</h2>
				<p>재원중, 휴원 상태의 학원생 정보를 조회하고 관리합니다.</p>
			</div>

			<button type="button" class="btn-primary">
				가입 승인 관리
			</button>
		</div>

		<!-- 검색 / 필터 카드 -->
		<div class="student-search-card">

			<div class="search-top-row">
				<div class="search-field">
					<label for="studentKeyword">검색어</label>
					<input type="text"
						id="studentKeyword"
						name="keyword"
						class="student-search-input"
						placeholder="이름 또는 연락처 검색">
				</div>

				<div class="search-field small">
					<label for="studentStatus">상태</label>
					<select id="studentStatus" name="status" class="student-select">
						<option value="">전체</option>
						<option value="ACTIVE">재원</option>
						<option value="REST">휴원</option>
					</select>
				</div>

				<button type="button" class="btn-primary search-btn">
					검색
				</button>
			</div>

			<!-- 검색어 재출력 자리 -->
			<div class="search-keyword-area">
				<span class="keyword-chip">
					검색어: <strong>김</strong>
					<button type="button">×</button>
				</span>
			</div>
		</div>

		<!-- 목록 카드 -->
		<div class="student-list-card">

			<div class="list-header">
				<div>
					<strong>총 24명</strong>
					<span>재원중 / 휴원 상태의 학원생만 표시됩니다.</span>
				</div>

				<label class="hide-rest-check">
					<input type="checkbox">
					휴원생 숨기기
				</label>
			</div>

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
					<tr>
						<td>
							<a href="#" class="student-name-link">김민지</a>
						</td>
						<td>010-1234-5678</td>
						<td>김철수</td>
						<td>2026-06-01</td>
						<td>
							<span class="student-status active">재원</span>
						</td>
						<td>
							<button type="button" class="btn-outline small">상세보기</button>
						</td>
					</tr>

					<tr>
						<td>
							<a href="#" class="student-name-link">이도윤</a>
						</td>
						<td>010-5555-1111</td>
						<td>미배정</td>
						<td>2026-05-28</td>
						<td>
							<span class="student-status rest">휴원</span>
						</td>
						<td>
							<button type="button" class="btn-outline small">상세보기</button>
						</td>
					</tr>

					<tr>
						<td>
							<a href="#" class="student-name-link">박서연</a>
						</td>
						<td>010-7777-2222</td>
						<td>박민지</td>
						<td>2026-05-20</td>
						<td>
							<span class="student-status active">재원</span>
						</td>
						<td>
							<button type="button" class="btn-outline small">상세보기</button>
						</td>
					</tr>

					<tr>
						<td>
							<a href="#" class="student-name-link">최현우</a>
						</td>
						<td>010-9999-3333</td>
						<td>이도윤</td>
						<td>2026-05-12</td>
						<td>
							<span class="student-status active">재원</span>
						</td>
						<td>
							<button type="button" class="btn-outline small">상세보기</button>
						</td>
					</tr>
				</tbody>
			</table>

			<!-- 페이징 -->
			<div class="pagination-area">
				<button type="button">&lt;</button>
				<button type="button" class="active">1</button>
				<button type="button">2</button>
				<button type="button">3</button>
				<button type="button">4</button>
				<button type="button">&gt;</button>
			</div>
		</div>
	</section>
	<!-- 학원생 목록조회 콘텐츠 끝 -->