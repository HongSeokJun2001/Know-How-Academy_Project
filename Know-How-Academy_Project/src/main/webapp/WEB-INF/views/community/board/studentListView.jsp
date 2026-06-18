<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				.outer {
					width: 940px !important;
					text-align: center;
					border: none !important;
				}

				.table tbody tr.post-row {
					cursor: pointer;
				}

				#search-container {
					display: flex !important;
					justify-content: center;
					/*가운데 정렬*/
					align-items: center;
					/*세로축 기준 중앙 정렬*/
					gap: 6px;
					/*박스간격*/
					margin: 20px 0;
				}

				/* 선택창(select)과 검색창(input) 디자인 일체감 주기 */
				#search-area select.form-control {
					width: 110px !important;
					display: inline-block;
					border-radius: 4px;
				}

				/* 검색 텍스트창의 너비 따로 조절 */
				#search-area input[type="search"] {
					width: 300px !important;
				}

				/* 글쓰기 버튼 영역 여백 */
				.write-btn-area {
					margin-bottom: 15px;
				}

				#search-area .btn,
				.outer .btn {
					border-color: #ced4da;
				}

				.paging-area {
					display: flex !important;
					justify-content: center;
					/* 가로축 기준 정중앙 정렬 */
					align-items: center;
					/* 세로축 기준 정중앙 정렬 */
					margin: 30px 0;
					/* 테이블과의 위아래 간격 */
				}

				.page-link {
					color: #606163 !important;
				}

				.pagination .page-item.active .page-link {
					background-color: #6f42c1 !important;
					border-color: #6f42c1 !important;
					color: white !important;
				}

				.btn-hover:hover {
					background-color: blueviolet !important;
				}
			</style>
		</head>

		<body>
			<jsp:include page="../../common/menubar.jsp" />

			<div class="outer">
				<h2>수강생 게시판</h2>
				<br>
				<hr>

				<!--검색창-->
				<div id="search-area">

					<form id="search-container" action="/know-how/community/board/${type}/search" method="get">
						<select name="condition1" class="form-control mr-sm-2">
							<!-- 검색후에도 조건초기화X-->
							<option value="all" ${condition1 eq 'all' ? 'selected' : '' }>
								전체
							</option>

							<option value="writer" ${condition1 eq 'writer' ? 'selected' : '' }>
								작성자
							</option>

							<option value="title" ${condition1 eq 'title' ? 'selected' : '' }>
								제목
							</option>

							<option value="content" ${condition1 eq 'content' ? 'selected' : '' }>
								내용
							</option>
						</select>

						<c:if test="${type eq 'student'}">
							<select name="condition2" class="form-control mr-sm-2" onchange="this.form.submit">

								<option value="all" ${condition2 eq 'all' ? 'selected' : '' }>
									전체
								</option>
								<option value="admission" ${condition2 eq 'admission' ? 'selected' : '' }>
									입학상담
								</option>
								<option value="employment" ${condition2 eq 'employment' ? 'selected' : '' }>
									취업상담
								</option>
							</select>
						</c:if>

						<input type="search" name="keyword" value="${keyword}" class="form-control mr-sm-2"
							placeholder="검색어를 입력하세요">
						<button type="submit" class="btn btn-outline-secondary btn-hover">검색</button>



						<br><br>
					</form>

					<c:if test="${!empty condition1}">
						<script>
							$(function () {
								$("#search-area option[value=${condition1}]").prop("selected", true);
								$("#search-area option[value=${condition2}]").prop("selected", true);

							});
						</script>
					</c:if>
				</div>
				<!-- 수강생만 글쓰기 가능-->
				<c:if test="${(not empty loginUser) and (loginUser.userNo >= 7 ) and  (loginUser.userNo <= 11) }">
					<div class="write-btn-area" align="right">
						<a href="/know-how/community/board/${type}/enrollForm" type="button"
							class="btn btn-outline-secondary btn-hover">글쓰기</a>
					</div>
				</c:if>

				<!--게시글 목록-->
				<table class="table table-hover">
					<thead>
						<tr>
							<th>글번호</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<!--게시글 목록-->
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="6">조회된 게시글이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="b" items="${list}">
									<tr class="post-row">
										<td>${b.postNo}</td>
										<td>
											<c:choose>
												<c:when test="${b.category == 'admission'}">입학상담</c:when>
												<c:when test="${b.category == 'employment'}">취업상담</c:when>
											</c:choose>
										</td>
										<td>${b.title}</td>
										<td>${b.userName}</td>
										<td>${b.viewCount}</td>
										<td>${b.createdAt}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<script>
							$(function () {
								$(".table>tbody>tr.post-row").click(function () {
									let postNo = $(this).children().eq(0).text();
									location.href = "/know-how/community/board/${type}/detail/" + postNo;
								})
							})
						</script>
					</tbody>
				</table>
				<div style="background: yellow;">
				</div>

				<div class="paging-area">
					<ul class="pagination page-item ">
						<c:choose>
							<%--'<' 버튼의 페이징 및 이동--%>
								<c:when test="${pi.currentPage eq 1}">
									<li class="page-item disabled">
										<a class="page-link">Prev</a>
									</li>
								</c:when>
								<c:otherwise>
									<c:choose>
										<%--검색어 미입력 조회 일경우--%>
											<c:when test="${empty keyword}">
												<li class="page-item">
													<a class="page-link"
														href="/know-how/community/board/${type}?cpage=${pi.currentPage - 1}">
														Prev</a>
												</li>
											</c:when>
											<%--검색어 입력 조회 일경우--%>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link"
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage - 1}&condition1=${condition1}&condition2=${condition2}&keyword=${keyword}">
															Prev</a>
													</li>
												</c:otherwise>
									</c:choose>
								</c:otherwise>
						</c:choose>

						<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
							<c:choose>
								<c:when test="${pi.currentPage eq p}">
									<li class="page-item active">
										<a class="page-link">${p}</a>
									</li>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${ empty keyword}">
											<li class="page-item">
												<a class="page-link"
													href="/know-how/community/board/${type}?cpage=${p}">${p}</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a class="page-link"
													href="/know-how/community/board/${type}/search?condition1=${condition1}&condition2=${condition2}&keyword=${keyword}&cpage=${p}">${p}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<%--'>'버튼의 페이징 및 이동--%>
							<c:choose>
								<c:when test="${pi.currentPage eq pi.maxPage}">
									<li class="page-item disabled">
										<a class="page-link">Next</a>
									</li>
								</c:when>
								<c:otherwise>
									<c:choose>
										<%--검색어 미입력 조회 일경우--%>
											<c:when test="${empty keyword}">
												<li class="page-item">
													<a class="page-link"
														href="/know-how/community/board/${type}?cpage=${pi.currentPage + 1}">Next</a>
												</li>
											</c:when>
											<%--검색어 입력 조회 일경우--%>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link"
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage + 1}&condition1=${condition1}&condition2=${condition2}&keyword=${keyword}">Next</a>
													</li>
												</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					</ul>
				</div>
			</div>
		</body>

		</html>