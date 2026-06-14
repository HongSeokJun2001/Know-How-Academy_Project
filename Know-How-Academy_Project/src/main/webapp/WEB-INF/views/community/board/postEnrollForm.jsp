<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<style>
				/* 전체 레이아웃 */
				.outer {
					border: none;
				}

				table {
					width: 940px !important;
					margin: 10px auto;
					border-collapse: collapse;			
			
				}

				/* 헤더(th) 및 데이터(td) 공통 설정 */
				table th,
				table td {
					padding: 5px 10px;
					height: 40px; /* 높이를 통일하여 정렬 문제 해결 */
					vertical-align: middle;
					box-sizing: border-box;
				}
				
				table th {
					width: 100px;
					font-weight: 450;
					text-align: center;
					background-color: rgb(233, 233, 233);
				}

				/* 버튼 영역 */
				.btn-area {
					width: 940px;
					margin: 0 auto;
					display: flex;
					justify-content: flex-end;
					gap: 3px;
					/* 버튼 간격 조정 */
				}

				/* 입력창 공통 */
				input[type="text"],
				textarea {
					width: 100%;
					border: none;
					outline: none;
					box-sizing: border-box;
				}

				textarea {
					height: 300px;
					padding: 10px;
					resize: none;
					display: block;
				}

				input[type="text"] {
					height: 100%;
					padding: 0 10px;
				}

				/* 버튼 호버 효과 */
				.btn-hover:hover {
					background-color: blueviolet !important;
					color: white;
				}
			</style>
		</head>

		<body>
			<jsp:include page="../../common/menubar.jsp" />

			<div class="outer">
				<h2 align="center">자유게시판</h2>

				<form id="enrollForm" action="/know-how/community/board/${type}/insert" 
						method="post" enctype="multipart/form-data">

					<input type="hidden" name="writerNo" value="${sessionScope.loginUser.userNo}">					
					<input type="hidden" name="postType" value="${type}"">
				
					<div class="btn-area">
						<a id="listBtn" href="/know-how/community/board/post" class="btn btn-outline-secondary btn-hover">목록</a>
						<button type="submit" class="btn btn-outline-secondary btn-hover">등록</button>
					</div>

					<!--카테고리/ 제목/ 내용/ 첨부파일-->
					<table class="table">
						<tr>
							<th>제목</th>
							<td colspan="3"><input type="text" id="title" name="title" required></td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan="3"><textarea id="boardContent" name="content" required></textarea>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" name="originalFile" class="btn btn-outline-secondary btn-hover"
									style="border: none !important;"></td>
						</tr>
					</table>
					<br>
					<br>
				</form>
			</div>
		</body>

		</html>