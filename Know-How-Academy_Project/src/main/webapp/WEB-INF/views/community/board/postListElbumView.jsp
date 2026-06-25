<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				.outer {
					text-align: center; /*텍스트 중앙정렬*/
					width: 1080px !important;
					border: none !important;
				}


			</style>
		</head>

		<body>
			<jsp:include page="../../common/menubar.jsp" />

			<div class="outer">
				<h2>자유게시판</h2>
				<br>
				<hr>

				<!--검색창-->
				<div id="search-area">

					<form id="search-container" action="/know-how/community/board/${type}/search" method="get">

						<select name="condition1" class="form-control mr-sm-2">
							<option value="all" ${condition1 eq 'all' ? 'selected' : '' }>전체</option>
							<option value="writer" ${condition1 eq 'writer' ? 'selected' : '' }>작성자</option>
							<option value="title" ${condition1 eq 'title' ? 'selected' : '' }>제목</option>
							<option value="content" ${condition1 eq 'content' ? 'selected' : '' }>내용</option>
						</select>


						<input type="search" name="keyword" value="${keyword}" class="form-control mr-sm-2"
							placeholder="검색어를 입력하세요">
						<button type="submit" class="btn btn-outline-secondary btn-hover">검색</button>
						<br> <br>
					</form>

					<c:if test="${!empty condition1}">
						<script>
							$(function () {
								$("#search-area option[value=${condition1}]").prop("selected", true);

							});
						</script>
					</c:if>
				</div>

				<!--글쓰기버튼 영역-->
				<c:if test="${not empty loginUser}">
					<div class="write-btn-area" align="right">
						<a href="/know-how/community/board/${type}/enrollForm" type="button"
							class="btn btn-outline-secondary btn-hover">글쓰기</a>
					</div>
				</c:if>

				<!--게시글 목록-->
				<table>
					<div class="row row-cols-1 row-cols-md-3 g-4">
						<c:choose>
							<c:when test="${empty list}">
								<div class="col-12">조회된 글이 없습니다.</div>						
							</c:when>
							<c:otherwise>
								<c:foreach var="b" items="${list}">
									<div class="col">
										<div class="card h-100 album-item" 
												onclick="location.href
													='/know-how/community/board/${type}/detail/${b.postNo}'">
											<div class="img-wrapper">
												<c:choose>
													<c:when test="${not empty b.thumbnail}">
														<img src="${b.thumbnail}" alt="썸네일">
													</c:when>
													<c:otherwise>
														<img src="/know-how/resources/images/no-image.png" alt="이미지 없음">
													</c:otherwise>
												</c:choose>
											</div>

											<div class="card-body" style="text-align: left;">
												<h5 class="card-title-custom">${b.title}</h5>
												<p class="card-text-custom">${b.content}</p>
											</div>

											<div class="card-footer bg-transparent d-flex justify-content-between">
												<small class="text-muted">${b.userName}</small>
												<small calss="text-muted">${b.createdAt}</small>
											</div>
										</div>
									</div>
								</c:foreach>
							</c:otherwise>
						</c:choose>
					</div>
				</table>
				

				<!--페이징바 영역-->
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
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage - 1}&condition1=${condition1}&keyword=${keyword}">
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
													href="/know-how/community/board/${type}/search?condition1=${condition1}&keyword=${keyword}&cpage=${p}">${p}</a>
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
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage + 1}&condition1=${condition1}&keyword=${keyword}">Next</a>
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