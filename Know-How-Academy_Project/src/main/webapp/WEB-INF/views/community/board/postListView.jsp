<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				.outer {
					text-align: center;
					width: 1080px !important;
					border: none !important;
				}

				.table {
					table-layout: fixed !important;
				}

				.table td,
				.table th {
					white-space: nowrap;
					/*줄바꿈 방지*/
					overflow: hidden;
					/*할당된 영역 넘어가면 부분숨김*/
					text-overflow: ellipsis;
					/*부분 숨김 부분 (...)처리*/
				}

				.table tbody {
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
					width: 100px !important;
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

				.btn-outline-secondary:hover,
				.btn-hover:hover {
					background-color: blueviolet !important;
				}

				.paging-area {
					color: #606163;

				}

				.img-wrapper {
					width: 100%;
					height: 200px;
					/* 원하는 높이로 조절 가능 */
					overflow: hidden;
					display: flex;
					justify-content: center;
					align-items: center;
					background-color: #f8f9fa;
					/* 이미지가 없을 때를 대비한 배경색 */
				}

				.img-wrapper img {
					width: 100%;
					height: 100%;
					object-fit: cover;
					/* 이미지를 찌그러지지 않게 꽉 채움 */
				}

				.layoutBtn {
					background: none;
					/* 배경 제거 */
					border: none;
					/* 테두리 제거 */
					padding: 5px;
					/* 여백 조절 */
					cursor: pointer;
				}

				/* 이미지 크기 조절 (원하는 사이즈로 수정) */
				.layoutBtn img {
					width: 25px;
					height: 25px;
					transition: transform 0.2s;
					/* 살짝 커지는 효과 */
					opacity: 0.5;

				}

				.layoutBtn button {
					padding: 6px 8px;
				}

				.layoutBtn .btn:hover {
					opacity: 1.0;
				}

				.card-body {
					/*타이틀 여백정리*/
					width: 100%;
					padding: 13px 19px !important;
				}

				.card-title-custom {
					margin: auto;

					/*넘쳐나는 글씨 처리에 필요한 코드세트*/
					white-space: nowrap;
					/*강제 한줄처리*/
					overflow: hidden;
					/*상자 밖으로 넘어온 글자 숨기기*/
					text-overflow: ellipsis;
					/*overflow로 넘어간 경계선에 '...'처리*/
				}

				.dropdown-menu.p-3.show {
					width: 320px !important;
					padding: 8px !important;
				}

				.dropdown-divider {
					margin: 5px;
				}

				#startDate,
				#endDate {
					width: 110px;
					padding: 0px 0px 0px 7px;
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
					<!--
					<form id="search-container" action="/know-how/community/board/${type}/search" method="get">
						ajax로 전환하면서 필요없어진 form 대신 div로 형태만 묵어두기
						-->
					<div id="search-container">
						<div class="dateDropBox">
							<button id="dateDropDownBtn" class="btn btn-outline-secondary dropdown-toggle" type="button"
								data-bs-toggle="dropdown" style="width: 100px;">
								전체기간
							</button>
							<!--기간 입력 부분-->
							<ul class="dropdown-menu p-3">
								<li><a href="#" class="dropdown-item" onclick="setDate('all');">전체기간</a></li>
								<li><a href="#" class="dropdown-item" onclick="setDate('1d');" data-days="1">1일</a></li>
								<li><a href="#" class="dropdown-item" onclick="setDate('1w');" data-days="7">1주</a></li>
								<li><a href="#" class="dropdown-item" onclick="setDate('1m');" data-days="30">1개월</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>

								<!--날짜 상세 입력 부분-->
								<li>
									<div id="dateBox" class="d-flex align-items-center gap-2"
										onclick="event.stopPropagation();">
										<input type="date" id="startDate" class="form-control form-control-sm">
										<span>~</span>
										<input type="date" id="endDate" class="form-control form-control-sm">
										<button id="settingBtn" class="btn btn-sm btn-primary "
											onclick="searchByDate();">설정</button>
									</div>
								</li>
							</ul>
						</div>

						<select name="condition1" id="commonDrop" class="form-control mr-sm-2">
							<option value="all" ${condition1 eq 'all' ? 'selected' : '' }>전체</option>
							<option value="writer" ${condition1 eq 'writer' ? 'selected' : '' }>작성자</option>
							<option value="title" ${condition1 eq 'title' ? 'selected' : '' }>제목</option>
							<option value="content" ${condition1 eq 'content' ? 'selected' : '' }>내용</option>
						</select>


						<input type="search" name="keyword" value="${keyword}" class="form-control mr-sm-2"
							placeholder="검색어를 입력하세요">
						<button type="button" id="searchBtn" class="btn btn-outline-secondary btn-hover"
							onclick="ajaxsearch()">검색</button>

						<br> <br>

						<div class="layoutBtn">
							<button type="button" id="listLayout" class="btn btn-outline-secondary btn-hover">
								<img src="${pageContext.request.contextPath}/resources/image/list.png" alt="리스트형">
							</button>
							<button type="button" id="albumLayout" class="btn btn-outline-secondary btn-hover">
								<img src="${pageContext.request.contextPath}/resources/image/album.png" alt="앨범형">
							</button>
						</div>
					</div>


					<c:if test="${!empty condition1}">
						<script>
							$(function () {
								$("#search-area option[value=${condition1}]").prop("selected", true);

							});
						</script>
					</c:if>
				</div>

				<!--글쓰기버튼 영역-->
				<!--로그인 이나 로그아웃 중에도 글쓰기 버튼 여백 유지 style 적용-->
				<div class="write-btn-area" align="right" style="min-height: 40px;">
					<c:if test="${not empty loginUser}">
						<a href="/know-how/community/board/${type}/enrollForm" type="button"
							class="btn btn-outline-secondary btn-hover">글쓰기</a>
					</c:if>
				</div>


				<div id="board-box"></div>

				<!--게시글 리스트, 앨범, 페이징바-->
				<script>
					/*
					실력부족으로 미적용
					@@페이지 로드 방식 코드
					//새로고침으로 입장했는지, 다른 경로로 들어온건지
					const navEntries = performence.getEntriesByType("navigation");
					let isReload = false;
					
					if(navEntries.length > 0 && navEntries[0].type === 'reload'){
						isReload = true;
					}
	
					let currentView;
					
					//로드방식에 따른 분기점
					if(isReload){
					//새로고침일 경우 
						currentView = sessionStroage.getItem(storageKey) || "{viewType}" || "list";
					}else{
						//다른 경로를 통해 들어온 경우 
						currentView = "${viewType}" || "list";
						//선택사항 이동 해올 때마다 스토리지도 초기화하려면 아래 주석해제
						//sessionStorage.removeItem(storageKey);
					}
						//이후 변수
					let currentViewType = currentView;
	
					*sessionStroage 는 현재 브라우저 탭 의 데이터보관소(페이징바, 게시글, 검색 등)
					*/


					// 다른 게시판으로 이동후 다시 돌아와도 list형으로 초기화되게 설정
					//@@페이지 로드 방식 적용

					const boardType = "${type}";
					const storageKey = boardType + "_viewMode";

					//@@페이지 로드 방식 코드
					let currentView = "${viewType}" || "list";

					let currentViewType = currentView;

					let currentBoardData = [];

					function ajaxsearch() {
						//검색 데이터를 drawBoard에 담아 보내거나 drawBoard 함수 내부에서 값을 읽은 후 페이지 그려내기
						drawBoard(1);
					}

					$(document).ready(function () {

						//페이지 로드시 sessionStorage 우선확인(예: 리스트형인지 앨범 형인지)
						let loadView = sessionStorage.getItem(storageKey);

						//sessionStorage에 값이 있을시(list/album)  없으면 "list" 사용
						currentView = loadView || "${viewType}" || "list";
						//위 코드에서 얻어낸 값 대입
						currentViewType = currentView;

						//값 넣을 통 세팅(defaultValue)
						//${pi.currentPage} ? ... : ...; (브라우저) 에서 받은 요청을 삼항연산자로 판단
						// ? ${pi.currentPage}"(참) : 1(거짓);

						//거짓의 기준 @@(false/ 모든 0/ ""/ null/ undifind/ NaN ===7개)@@

						//하지만 "${pi.currentPage}"에 따옴표가 있기때문에 에외상황으로 false가 들어갈수 있기때문에

						/*해당 코드는주석 처리
						let defaultValue = "${pi.currentPage}" ? parseInt("${pi.currentPage}") : 1;
						drawBoard(defaultValue);
						*/

						//전제조건으로 false에 해당하는 7개를 기준으로 삼항연산자 사용
						//요청받은 페이지를 담고(예: 0 or 2)
						let rawValue = "${pi.currentPage}";

						//담긴 요청페이지를 강제로 정수변환(parseInt)
						let pageNum = parseInt(rawValue);

						//정수로 변한 요청페이지가 위 7가지@@(...)@@ 에 해당하면 참으로 1페이지 표시(0)
						//반대 일시 해당 페이지 호출(2)
						let defaultPage = (isNaN(pageNum) || pageNum <= 0) ? 1 : pageNum;

						drawBoard(defaultPage);

						// 리스트 클릭시
						$("#listLayout").click(function () {
							currentView = "list";
							currentViewType = "list";
							sessionStorage.setItem(storageKey, "list");

							drawBoard(1);
						});

						// 앨범 클릭시
						$("#albumLayout").click(function () {
							currentView = "album";
							currentViewType = "album"
							sessionStorage.setItem(storageKey, "album");
							drawBoard(1);
						});

						//날짜 상세버튼 클릭시
						$("#settingBtn", "#searchBtn").click(function () {
							drawBoard(1);

						})
					});
					function closeDropdown() {
						$(".dropdown-menu").removeClass("show");
						$(".dropdown-toggle").removeClass("show").attr("aria-expanded", "false");
						$("#dateBox").closest(".dropdown").removeClass("show");
					}
					// 목록에 띄울 데이터 요청함수 (AJAX 유지)
					function drawBoard(cpage) {

						//조건검색과 입력된 검색어 가져오기
						let condition1 = $("select[name='condition1']").val();
						let keyword = $("input[name='keyword']").val();

						let startDate = $("#startDate").val();
						let endDate = $("#endDate").val();

						console.log("선택된 날짜 확인 -> 시작일:", startDate, "/ 종료일:", endDate);

						let requestData = {
							type: "${type}",
							cpage: cpage,
							viewType: currentViewType || "list",
							condition1: condition1,
							keyword: keyword,
							boardLimit: 10
						}

						//날짜가 입력된 경우에만 서버로 보냄
						if (startDate && endDate) {
							requestData.startDate = startDate;
							requestData.endDate = endDate;
						}


						$.ajax({
							url: "/know-how/community/board/ajaxList",
							type: "get",
							data: requestData,
							dataType: "json",
							success: function (data) {
								currentBoardData = data.list;
								renderBoard(currentBoardData);
								renderPagination(data.pi);
							},
							error: function () {
								console.log("로딩 실패");
							}
						});
					}

					// 3. DB에서 가져온 데이터 화면에 띄우기
					function renderBoard(boardList) {
						var $boardBox = $("#board-box");
						$boardBox.empty();

						if (!boardList || typeof boardList === 'undefined' || boardList.length === 0) {
							$boardBox.html("<p class='text-center py-5'>조회 된 게시글이 없습니다.</p>");
							return;
						}

						if (currentView === "list") {
							var html = '<table class="table table-hover">' +
								'<thead>' +
								'<tr>' +
								'<th style="width: 100px;">글번호</th>' +
								'<th style="width: 500px;">제목</th>' +
								'<th style="width: 200px;">작성자명</th>' +
								'<th style="width: 150px;">조회수</th>' +
								'<th style="width: 150px;">날짜</th>' +
								'</tr>' +
								'</thead>' +
								'<tbody>';

							for (var i = 0; i < boardList.length; i++) {
								// 1. 글번호 (소문자 n)
								var b = boardList[i];

								var detailUrl = "/know-how/community/board/" + "${type}" + "/detail/" + b.postNo;
								var writer = b.userName || b.boardWriter || b.writerName || b.writer || "작성자";
								var views = (b.viewCount !== undefined) ? b.viewCount : ((b.count !== undefined) ? b.count : 0);

								var rawDate = b.createDate || b.enrollDate || b.createdAt || ' ';
								var displayDate = '';

								if (rawDate) {
									var dateObj = new Date(rawDate);
									var today = new Date();

									//날짜만 비교
									var dateStr = dateObj.toISOString().split('T')[0];
									var todayStr = today.toISOString().split('T')[0];

									if (dateStr === todayStr) {
										//당일이면 시간만(hh:mm:ss)
										displayDate = dateObj.toTimeString().split(' ')[0];
									} else {
										//당일이 아닐시 날짜만 (yyyy-mm-dd)
										displayDate = dateStr;
									}
								} else {
									displayDate = '날짜';
								}

								html += '<tr onclick="location.href=\'' + detailUrl + '\'" style="cursor:pointer;">' +
									"<td>" + b.postNo + "</td>" +
									"<td>" + b.title + "</td>" +
									"<td>" + writer + "</td>" +
									"<td>" + views + "</td>" +
									"<td>" + displayDate + "</td>" +
									"</tr>";
							}
							html += "</tbody></table>";
							$boardBox.html(html);

						} else {
							// 2. 앨범 틀 만들기
							var html = '<div class="row row-cols-1 row-cols-md-3 g-4">';

							for (var i = 0; i < boardList.length; i++) {

								var b = boardList[i];
								var detailUrl = "/know-how/community/board/${type}/detail/" + b.postNo;

								html += '<div class="col">' +
									'<div class="card h-100 album-item" onclick="location.href=\'' + detailUrl + '\';" style="cursor:pointer;">';

								//사진이 있는 경우에만 이미지태그를 생성합니다.
								if (b.titleImg) {
									var imgpath = "/know-how" + b.titleImg;

									html += '<div class="img-wrapper">' +
										'<img src="' + imgpath + '" class="card-img-top">' +
										'</div>';
								} else {
									//사진이 없는경우 
									html += '<div class="img-wrapper"><span class="text-muted">이미지 없음</span></div>';
								}

								html += '<div class="card-body">' +
									'<h5 class="card-title-custom elipsis-cell">' + b.title + '</h5>' +
									'</div>' +
									'<div class="card-footer bg-transparent d-flex justify-content-between">' +
									'<small class="text-muted">' + (b.userName || ' 작성자') + '</small>' +
									'<small class="text-muted">' + (b.createdAt || '') + '</small>' +
									'</div>' +
									'</div>' +
									'</div>';

							}
							html += '</div>';
							$boardBox.html(html);
						}
					}
					function renderPagination(pi) {

						//페이징바를 그려넣을 div 영역 정하기
						let $pagingArea = $("#paging-area");

						//새로운 페이지의 새 페이징바를 넣기위한 사전작업
						$pagingArea.empty();

						//버튼들에 적용할 부트스트랩
						let html = '<div class="btn-group" role="group">';

						//1. 이전 버튼 로직
						if (pi.currentPage > 1) {
							html += '<button class="btn btn-outline-secondary" onclick="drawBoard(' + (pi.currentPage - 1) + ')">PREV</button>';
						}

						//2. 보여질 페이지 번호 만큼 버튼 생성 (예: 10)
						for (let i = pi.startPage; i <= pi.endPage; i++) {

							//만약 반복중인 숫자 중 하나가 현재 페이지라면
							if (i == pi.currentPage) {
								//클릭 요소가 필요없으므로 active로 만들고 disibled 비활성화 함
								html += '<button class="btn btn-outline-secondary" disabled>' + i + '</button>';
							} else {
								//현재 페이지면 클릭 요소에 해당 페이지 호출로 함
								html += '<button class="btn btn-outline-secondary" onclick="drawBoard(' + i + ')">' + i + '</button>';
							}
						}

						//3. 다음 버튼 로직
						if (pi.currentPage < pi.maxPage) {
							//클릭시 현재 페이지 +1 로 호출함.
							html += '<button class="btn btn-outline-secondary" onclick="drawBoard(' + (pi.currentPage + 1) + ')">NEXT</button>';
						}

						//div 닫기 태그
						html += '</div>';

						$pagingArea.html(html);
					}

					//날짜 필터 함수
					function setDate(type) {
						let end = new Date();//오늘
						let start = new Date();

						let dropdownBtn = document.getElementById('dateDropDownBtn');

						if (type === 'all') {
							document.getElementById('startDate').value = '';
							document.getElementById('endDate').value = '';
							dropdownBtn.innerText = '전체기간';
							drawBoard(1);//전체 조회시 즉시 반영
							return;
						}

						//onclick 속성으로   조건에 맞는 type이 들어올경우.
						if (type === '1d') {
							start.setDate(end.getDate() - 1);
							dropdownBtn.innerText = '1일';
						}
						else if (type === '1w') {
							start.setDate(end.getDate() - 7);
							dropdownBtn.innerText = '1주';
						}
						else if (type === '1m') {
							start.setMonth(end.getMonth() - 1);
							dropdownBtn.innerText = '1개월';
						}
						//날짜 형식세팅
						document.getElementById('startDate').value = start.toISOString().split('T')[0];
						document.getElementById('endDate').value = end.toISOString().split('T')[0];

						drawBoard(1);
					}

					//날짜
					function searchByDate() {

						//달력 입력창에서 시작일과 종료일 가져오기0
						let startDate = $('#startDate').val()
						let endDate = $('#endDate').val();

						if (!startDate || !endDate) {
							return alert('시작일과 종료일을 모두 선택해주세요.');
						}

						let $box = $("#settingBtn").closest(".dateDropBox");

						$box.find(".dropdown-toggle")
							.text("기간설정")
							.removeClass("show")
							.attr("aria-expanded", "false");
							
						$box.find(".dropdown-menu")
							.removeClass("show");

						drawBoard(1);
					}

				</script>

				<!--페이징 바 영역 -->

				<div id="paging-area" class="paging-area">
				</div>
				<!--ajax 작업으로 인한 구 코드주석처리
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
														href="/know-how/community/board/${type}?cpage=${pi.currentPage - 1}&viewType=${viewType}">
														Prev</a>
												</li>
											</c:when>
											<%--검색어 입력 조회 일경우--%>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link"
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage - 1}&condition1=${condition1}&keyword=${keyword}&viewType=${viewType}">
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
													href="/know-how/community/board/${type}?cpage=${p}&viewType=${viewType}">${p}</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a class="page-link"
													href="/know-how/community/board/${type}/search?condition1=${condition1}&keyword=${keyword}&cpage=${p}&viewType=${viewType}">${p}</a>
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
														href="/know-how/community/board/${type}?cpage=${pi.currentPage + 1}&viewType=${viewType}">Next</a>
												</li>
											</c:when>
											<%--검색어 입력 조회 일경우--%>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link"
															href="/know-how/community/board/${type}/search?cpage=${pi.currentPage + 1}&condition1=${condition1}&keyword=${keyword}&viewType=${viewType}">Next</a>
													</li>
												</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					</ul>-->

			</div>
		</body>

		</html>