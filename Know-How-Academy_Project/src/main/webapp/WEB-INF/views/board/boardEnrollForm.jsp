<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.outer {
	border: none !important;
}

table#boardContent {
	width: 940px;
	margin: 10px auto;
}

table#boardContent th {
	width: 100px;
	font-weight: 450;
	padding: 10px;
	height: 45px;
	vertical-align: middle;
	text-align: center;
	background-color: rgb(233, 233, 233);
}

table#boardContent td {
	vertical-align: middle;
}

.btn-area {
	width: 940px;
	margin: 0 auto;
	display: flex;
	justify-content: end;
}

#listBtn {
	margin-right: 3px;
}

#drop {
	border: none !important;
}

#boardContent textarea {
	width: 100%;
	height: 300px;
	border: none;
	padding: 10px;
	outline: none;
	resize: none;
	box-sizing: border-box;
	display: block;
}

#boardContent input[type="text"], #boardContent select {
	width: 100%;
	height: 100%;
	border: none;
	padding: 0 10px;
	/* 입력창 테두리를 없애야 표 선과 하나로 보임 */
	outline: none;
	/* 클릭 시 나타나는 파란 테두리 제거 */
	box-sizing: border-box;
}

.btn-hover:hover {
	background-color: blueviolet !important;
}
</style>
</head>

<body>
	<jsp:include page="../common/menubar.jsp" />

	<div class="outer">
		<h2 align="center">일반게시글</h2>

		<form id="enrollForm" action="/know-how/board/insert" method="post"
			enctype="multipart/form-data">
			<!--로그인기능 탑재후 재설정 
			<input type="hidden" name="writerNo"
								 value="${sessionScope.loginUser.writerNo}">-->
			<div class="btn-area">
				<a id="listBtn" href="/know-how/board/list"
					class="btn btn-outline-secondary btn-hover">목록</a>
				<button type="submit" class="btn btn-outline-secondary btn-hover">등록</button>
			</div>

			<!--카테고리/ 제목/ 내용/ 첨부파일-->
			<table class="table" id="content">

				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" id="title" name="title"
						required></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea id="boardContent" name="content" required></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="originalFile"></td>
				</tr>
			</table>
			<br>
			<br>
			<br>

		</form>
	</div>
</body>

</html>