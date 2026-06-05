<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.notice-section {
    width: 100%;
    padding: 0px 40px 80px;
    box-sizing: border-box;
}

/* 제목 영역 */
.notice-title-area {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 28px;
}

.notice-title-area h2 {
    margin: 0;
    font-size: 32px;
    font-weight: 800;
    color: #2c2f3f;
}

.notice-title-area p {
    margin: 10px 0 0;
    font-size: 15px;
    color: #6b7280;
}

/* 검색 카드 */
.notice-search-card {
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

.notice-search-input {
    height: 46px;
    padding: 0 14px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    background-color: #fff;
    color: #374151;
    font-size: 15px;
    outline: none;
}

.notice-search-input:focus {
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
.notice-list-card {
    padding: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

/* 테이블 */
.notice-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    font-size: 15px;
    text-align: center;
}

.notice-table thead th {
    height: 54px;
    padding: 0 18px;
    background-color: #fafafa;
    color: #2c2f3f;
    font-weight: 800;
    border-bottom: 1px solid #e5e7eb;
}

.notice-table tbody td {
    padding: 16px 18px;
    color: #374151;
    border-bottom: 1px solid #eef0f4;
    vertical-align: middle;
}

/* 상태 배지 */
.notice-status {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 26px;
    border-radius: 2px;
    font-size: 13px;
    font-weight: 500;
    background-color: #fff;
    cursor: pointer;
}

.notice-status.show {
    border: 1px solid #22c55e;
    color: #22c55e;
}

.notice-status.hide {
    border: 1px solid #a1a1aa;
    color: #a1a1aa;
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
    width: 48px;
    height: 30px;
    border: 1px solid #c9ccd6;
    border-radius: 2px;
    background-color: #fff;
    font-size: 13px;
    cursor: pointer;
    margin: 0 2px;
}

.btn-outline.edit {
    border: 1px solid #a1a1aa;
    color: #52525b;
}

.btn-outline.delete {
    border: 1px solid #ef4444;
    color: #ef4444;
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
</head>
<body>
	<section class="notice-section">

		<!-- 페이지 제목 -->
		<div class="notice-title-area">
			<div>
				<h2>공지사항 관리</h2>
				<p>공지사항을 등록, 수정, 삭제할 수 있습니다.</p>
			</div>

			<button type="button" class="btn-primary" onclick="go('/admin/notice/insert')">
				+ 새 공지 등록
			</button>
		</div>

		<!-- 검색 / 필터 카드 -->
		<div class="notice-search-card">
			<form action="/know-how/admin/notice/search" method="get">
				<div class="search-top-row">
					<div class="search-field">
						<input type="search"
							name="keyword"
							class="notice-search-input">
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
						<button type="button" onclick="go('/admin/notice/search')">×</button>
					</span>
				</div>
			</c:if>

		</div>

		<!-- 목록 카드 -->
		<div class="notice-list-card">

			<table class="notice-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>노출여부</th>
						<th>관리</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${ empty requestScope.list }">
							<tr>
								<th colspan="6">
									공지사항 정보가 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>	
							<c:forEach var="n" items="${ requestScope.list }">
								<tr>
									<td>${ n.postNo }</td>
									<td>${ n.title }</td>
									<td>${ n.postWriter }</td>
									<td>${ n.createdAt }</td>
									<td>
										<c:choose>
											<c:when test="${ n.status eq 'Y' }">
												<span class="notice-status show">노출</span>
											</c:when>
											<c:otherwise>
												<span class="notice-status hide">숨김</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<button type="button" class="btn-outline edit" onclick="go(/admin/notice/update/${ n.postNo })">수정</button>
										<button type="button" class="btn-outline delete" onclick="go(/admin/notice/delete/${ n.postNo })">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>	

			<!-- 페이징 -->
			<div class="pagination-area">
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq 1 }">
						<button type="button" disabled>&lt;</button>
					</c:when>
					<c:otherwise>
					
						<c:choose>
							<c:when test="${ empty requestScope.condition }">
								<button type="button" onclick="go('/know-how/admin/notice?cpage=${ requestScope.pi.currentPage - 1 }')">&lt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/know-how/admin/notice/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage - 1 }')">&lt;</button>
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
									<button type="button" onclick="go('/admin/notice?cpage=${ p }')">${ p }</button>
								</c:when>
								<c:otherwise>
									<button type="button" onclick="go('/admin/notice/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ p }')">${ p }</button>
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
								<button type="button" onclick="go('/admin/notice?cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/admin/notice/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</body>
</html>