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
		width : 100%;
		border-collapse : separate;
		border-spacing : 0;
		border : 1px solid #e5e7eb;
		border-radius : 10px;
		overflow : hidden;
		font-size : 18px;
	}
	
	.notice-table th {
		width: 10%;
		height : 54px;
		background-color : #fafafa;
		font-weight: 500;
		border-right : 1px solid #e5e7eb;
		border-bottom : 1px solid #e5e7eb;
		text-align: center;
	}
	
	.notice-table td {
		width : 90%;
		border-bottom : 1px solid #eef0f4;
	}
	
	.notice-table input, .notice-table textarea, .notice-table a {
		padding : 9px;
		margin : 7px;
		width : 99%;
		border : none;
	}
	
	.notice-table a {
		text-decoration: none;
	}
	
	.notice-table textarea {
		height : 300px;
		resize : none;
	}
	
	.btn-primary {
		min-width : 96px;
		height : 42px;
		padding : 0 22px;
		border: none;
		border-radius: 8px;
		background-color: #4233c7;
		color: #fff;
		font-size: 15px;
		font-weight: 700;
		cursor: pointer;
	}
	
	.btn-primary:hover {
		background-color : #3528a8;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<form class="notice-session" id="updateForm" enctype="multipart/form-data">
	
		<input type="hidden" name="postNo" value="${ requestScope.n.postNo }">
		
		<div class="notice-title-area">
			<h2>공지사항</h2>
			
			<button type="submit" class="btn-primary">
				수정하기
			</button>
		</div>
		
		<div class="notice-card">
			<table class="notice-table">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" value="${ requestScope.n.title }" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" required>${ requestScope.n.content }</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<c:if test="${ not empty requestScope.fa }">
							
							<a download="${ requestScope.fa.originName }"
							   href="/know-how/${ requestScope.fa.filePath }${ requestScope.fa.saveName }">
								${ requestScope.fa.originName }
							</a>
							<input type="hidden" name="originalFileNo" value="${ requestScope.fa.fileNo }">
							<input type="hidden" name="originalFileSaveName"
												 value="${ requestScope.fa.saveName }">
						</c:if>
						
						<input type="file" name="reUpfile">
					</td>
				</tr>
			</table>
		</div>
		
	</form>
	<script>
		$(function() {
		   
		    $("#updateForm").on("submit", function(event) {
		        event.preventDefault();
		        
		        let formData = new FormData(this);
		        
		        $.ajax({
		            url : "/know-how/admin/notice/update",
		            type : "post",
		            data : formData,
		            processData : false,
		            contentType : false,
		            success(result) {
						if(result == "success") {
							
							alert("공지사항이 수정되었습니다.")
							
							location.href = "/know-how/admin/notice";
							
						} else {
							
							alert("공지사항 수정에 실패했습니다.");
							
						}
					},
					error(xhr) {
						if (xhr.status === 413) {
				            alert("첨부파일의 용량이 너무 큽니다. 파일 크기를 줄여서 다시 시도해주세요.");
				        } else {
				        	console.log("공지사항 수정용 ajax 통신 실패!!");
				        }
					}
		        });
		    });
		});
	</script>
</body>
</html>