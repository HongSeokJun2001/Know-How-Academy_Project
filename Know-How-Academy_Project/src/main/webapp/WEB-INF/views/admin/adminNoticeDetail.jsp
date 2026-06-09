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
	    width : 100%;
	    padding : 0px 40px 80px;
	    box-sizing : border-box;
	}
	.notice-title-area {
		display : flex;
		justify-content : space-between;
		align-items: flex-end;
		margin-bottom : 28px;
	}
	
	.notice-card {
		padding : 28px;
		background-color : #fff;
		border : 1px solid #e5e7ed;
		border-radius : 14px;
		box-shadow : 0 4px 14px rgba(17, 12, 39, 0.06); 
	}
	
	.notice-table {
		width: 100%;
		border-collapse: collapse;
		border : 1px solid #e5e7eb;
		font-size : 18px;
	}
	
	.notice-table th {
		background-color : #fafafa;
		width : 10%;
		text-align: center;
		vertical-align: middle !important;
	}
	
	.btn-update {
		min-width : 96px;
		height : 42px;
		padding : 0 22px;
		border: none;
		border-radius: 8px;
		background-color: yellow;
		font-size: 15px;
		font-weight: 700;
		cursor: pointer;
	}
	.btn-delete {
		min-width : 96px;
		height : 42px;
		padding : 0 22px;
		color: #fff;
		border: none;
		border-radius: 8px;
		background-color: red;
		font-size: 15px;
		font-weight: 700;
		cursor: pointer;
	}
	
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<form class="notice-session" id="postForm" action="/know-how/admin/notice/updateForm" method="POST">
	
		<input type="hidden" name="postNo" value="${ requestScope.n.postNo }">
		
		<div class="notice-title-area">
			<h2>공지사항</h2>
			
			<div>
				<button type="submit" class="btn-update">
					수정
				</button>
				<button type="button" class="btn-delete" onclick="deleteNotice(${ requestScope.n.postNo });">
					삭제
				</button>
			</div>
		</div>
		
		<div class="notice-card">
			<table class="notice-table table">
				<tr>
					<th>제목</th>
					<td colspan="3">${ requestScope.n.title }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td style="width : 600px">${ requestScope.n.postWriter }</td>
					<th style="border : 1px solid #e5e7ed;">날짜</th>
					<td>${ requestScope.n.createdAt }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<p style="height : 300px;">
							${ requestScope.n.content }
						</p>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<c:choose>
							<c:when test="${ empty requestScope.at }">
								첨부파일이 없습니다..
							</c:when>
							<c:otherwise>
								<a download="${ requestScope.at.originName }"
								   href="/know-how/${ requestScope.at.filePath }${ requestScope.at.saveName }">
									${ requestScope.at.originName }   
								</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		
	</form>
	<script>
		function deleteNotice(postNo) {
			if(confirm("해당 공지사항을 삭제하시겠습니까?")) {
				$.ajax({
					url : "/know-how/admin/notice/delete",
					type : "post",
					data : {
						postNo : postNo
					},
					success(result) {
						if(result == "success") {
							alert("삭제가 완료되었습니다.");
							location.href = "/know-how/admin/notice";
							
						} else {
							
							alert("삭제가 실패했습니다.");
							
						}
					},
					error() {
						console.log("공지사항 삭제용 ajax 통신 실패!");
					}
				});
			}
		}
	</script>
</body>
</html>