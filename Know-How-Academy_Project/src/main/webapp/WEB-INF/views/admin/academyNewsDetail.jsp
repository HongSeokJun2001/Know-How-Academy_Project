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
	    width : 100%;
	    padding : 0px 40px 80px;
	    box-sizing : border-box;
	}
	.news-title-area {
		display : flex;
		justify-content : space-between;
		align-items: flex-end;
		margin-bottom : 28px;
	}
	
	.news-card {
		padding : 28px;
		background-color : #fff;
		border : 1px solid #e5e7ed;
		border-radius : 14px;
		box-shadow : 0 4px 14px rgba(17, 12, 39, 0.06); 
	}
	
	.news-table {
		width : 100%;
		border-collapse : separate;
		border-spacing : 0;
		border : 1px solid #e5e7eb;
		border-radius : 10px;
		overflow : hidden;
		font-size : 18px;
	}
	
	.news-table th {
		width: 10%;
		background-color : #fafafa;
		text-align: center;
		vertical-align: middle !important;
		border-right : 1px solid #e5e7eb;
	}
	
	.news-table tr:not(:nth-child(2)) td {
		width : 90%;
	}
	
	.news-table tr:nth-child(2) td {
		width : 40%;	
	}
	
	.news-table tr:nth-child(2) th:last-of-type {
		border-left : 1px solid #e5e7eb;
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
	<form class="news-session" id="postForm" action="/know-how/admin/academyNews/updateForm" method="POST">
		
		<input type="hidden" name="postNo" value="${ requestScope.n.postNo }">
		
		<div class="news-title-area">
			<h2>학원소식</h2>
			
			<div>
				<button type="submit" class="btn-update">
					수정
				</button>
				<button type="button" class="btn-delete" onclick="deleteNews(${ requestScope.n.postNo });">
					삭제
				</button>
			</div>
		</div>
		
		<div class="news-card">
			<table class="news-table table">
				<tr>
					<th>제목</th>
					<td colspan="3">${ requestScope.n.title }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${ requestScope.n.postWriter }</td>
					<th>날짜</th>
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
					<th>대표이미지</th>
					<td colspan="3" align="center">
						<img src="/know-how/${ requestScope.list[0].filePath }${ requestScope.list[0].saveName }" alt="대표이미지"
							 width="250" height="170">
					</td>
				</tr>
				<tr>
					<th>상세이미지</th>
					<td colspan="3" align="center">
						<c:choose>
							<c:when test="${ requestScope.list.size() eq 1 }">
								상세이미지가 존재하지 않습니다.
							</c:when>
							<c:otherwise>
								<c:forEach var="i" begin="1" end="${ requestScope.list.size() - 1 }" step="1">
								
									<img src="/know-how/${ requestScope.list[i].filePath }${ requestScope.list[i].saveName }" alt="상세이미지"
										 width="150" height="110" style="margin: 0 10px;">
								
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		
	</form>
	
	<script>
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
							location.href = "/know-how/admin/academyNews";
							
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
	
</body>
</html>