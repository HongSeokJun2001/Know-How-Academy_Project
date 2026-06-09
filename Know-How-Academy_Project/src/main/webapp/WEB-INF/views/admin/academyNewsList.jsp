<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.news-section {
    width: 100%;
    padding: 0px 40px 80px;
    box-sizing: border-box;
}

/* 제목 영역 */
.news-title-area {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 28px;
}

.news-title-area h2 {
    margin: 0;
    font-size: 32px;
    font-weight: 800;
    color: #2c2f3f;
}

.news-title-area p {
    margin: 10px 0 0;
    font-size: 15px;
    color: #6b7280;
}

/* 검색 카드 */
.news-search-card {
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

.news-search-input {
    height: 46px;
    padding: 0 14px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    background-color: #fff;
    color: #374151;
    font-size: 15px;
    outline: none;
}

.news-search-input:focus {
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
.news-card {
    padding: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

/* 테이블 */
.news-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    font-size: 15px;
    text-align: center;
}

.news-table thead th {
    height: 54px;
    padding: 0 18px;
    background-color: #fafafa;
    font-weight: 800;
    border-bottom: 1px solid #e5e7eb;
}

.news-table tbody td {
    padding: 16px 18px;
    border-bottom: 1px solid #eef0f4;
    vertical-align: middle;
}

.news-table tbody tr:last-child td {
    border-bottom: none;
}

.news-table tbody tr:hover {
    background-color: #fafaff;
}

.news-title-link {
    color: #4233c7;
    font-weight: 800;
    text-decoration: underline;
    text-underline-offset: 3px;
}

.news-title-link:hover {
    color: #2f2499;
}

/* 상태 배지 */
.news-status {
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

.news-status.show {
    border: 1px solid #22c55e;
    color: #22c55e;
}

.news-status.hide {
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
	<section class="news-section">

		<!-- 페이지 제목 -->
		<div class="news-title-area">
			<div>
				<h2>학원소식 관리</h2>
				<p>학원소식을 등록, 수정, 삭제할 수 있습니다.</p>
			</div>

			<button type="button" class="btn-primary" onclick="go('/admin/academyNews/enrollForm')">
				+ 새 소식 등록
			</button>
		</div>

		<!-- 검색 / 필터 카드 -->
		<div class="news-search-card">
			<form action="/know-how/admin/academyNews/search" method="get">
				<div class="search-top-row">
					<div class="search-field">
						<input type="search"
							name="keyword"
							class="news-search-input"
							placeholder="제목을 입력해주세요.">
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
						<button type="button" onclick="go('/admin/academyNews')">×</button>
					</span>
				</div>
			</c:if>

		</div>

		<!-- 목록 카드 -->
		<div class="news-card">

			<table class="news-table">
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
									학원소식 정보가 없습니다.
								</th>
							</tr>
						</c:when>
						<c:otherwise>	
							<c:forEach var="n" items="${ requestScope.list }">
								<tr>
									<td>${ n.rowNum }</td>
									<td><a href="/know-how/admin/academyNews/detail/${ n.postNo }" class="news-title-link">${ n.title }</a></td>
									<td>${ n.postWriter }</td>
									<td>${ n.createdAt }</td>
									<td>
										<c:choose>
											<c:when test="${ n.status eq 'Y' }">
												<span class="news-status show" onclick="visible('${ n.status }', ${ n.postNo })">노출</span>
											</c:when>
											<c:otherwise>
												<span class="news-status hide" onclick="visible('${ n.status }', ${ n.postNo })">숨김</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<button type="button" class="btn-outline edit" onclick="updateNews(${ n.postNo })">수정</button>
										<button type="button" class="btn-outline delete" onclick="deleteNews(${ n.postNo })">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>	
			<form id="postForm" action="/know-how/admin/academyNews/updateForm" method="POST">
				<input type="hidden" id="targetPostNo" name="postNo" value="${ n.postNo }">
			</form>	
			<script>
				function visible(status, postNo) {
					if(status == 'Y') {
						status = 'N';
					} else {
						status = 'Y';
					} 
					console.log(postNo);
					$.ajax({
						url : "/know-how/admin/academyNews/visible",
						type : "post",
						data : {
							status : status,
							postNo : postNo
						},
						success(result) {
							if(result == "success") {
								
								location.reload();
								
							} else {
								
								alert("상태 변경에 실패했습니다.");
								
							}
						},
						error() {
							console.log("상태 변경용 ajax 통신 실패!");
						}
					});
				}
				
				function updateNews(postNo) {
					
					$("#targetPostNo").val(postNo);
					
					$("#postForm").submit();
				}
				
				function deleteNews(postNo) {
					if(confirm("해당 학원소식을 삭제하시겠습니까?")) {
						$.ajax({
							url : "/know-how/admin/academyNews/delete",
							type : "post",
							data : {
								postNo : postNo
							},
							success(result) {
								if(result == "success") {
									alert("삭제가 완료되었습니다.");
									location.reload();
									
								} else {
									
									alert("삭제가 실패했습니다.");
									
								}
							},
							error() {
								console.log("학원소식 삭제용 ajax 통신 실패!");
							}
						});
					}
				}
			</script>
			
			<!-- 페이징 -->
			<div class="pagination-area">
				<c:choose>
					<c:when test="${ requestScope.pi.currentPage eq 1 }">
						<button type="button" disabled>&lt;</button>
					</c:when>
					<c:otherwise>
					
						<c:choose>
							<c:when test="${ empty requestScope.condition }">
								<button type="button" onclick="go('/admin/academyNews?cpage=${ requestScope.pi.currentPage - 1 }');">&lt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/admin/academyNews/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage - 1 }');">&lt;</button>
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
									<button type="button" onclick="go('/admin/academyNews?cpage=${ p }');">${ p }</button>
								</c:when>
								<c:otherwise>
									<button type="button" onclick="go('/admin/academyNews/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ p }');">${ p }</button>
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
								<button type="button" onclick="go('/admin/academyNews?cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:when>
							<c:otherwise>
								<button type="button" onclick="go('/admin/academyNews/search?status=${ requestScope.status }&keyword=${ requestScope.keyword }&cpage=${ requestScope.pi.currentPage + 1 }')">&gt;</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</body>
</html>