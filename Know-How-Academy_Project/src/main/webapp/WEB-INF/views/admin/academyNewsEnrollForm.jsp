<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.section {
	    width : 100%;
	    padding : 0px 40px 80px;
	    box-sizing : border-box;
	}
	.title-area {
		display : flex;
		justify-content : space-between;
		align-items: flex-end;
		margin-bottom : 28px;
	}
	
	.title-area h2 {
	    margin: 0;
	    font-size: 32px;
	    font-weight: 800;
	    color: #2c2f3f;
	}
	
	.card {
		padding : 28px;
		background-color : #fff;
		border : 1px solid #e5e7ed;
		border-radius : 14px;
		box-shadow : 0 4px 14px rgba(17, 12, 39, 0.06); 
	}
	
	table {
		width : 100%;
		border-collapse : separate;
		border-spacing : 0;
		border : 1px solid #e5e7eb;
		border-radius : 10px;
		overflow : hidden;
		font-size : 18px;
	}
	
	table th {
		width: 10%;
		height : 54px;
		background-color : #fafafa;
		border-right : 1px solid #e5e7eb;
		border-bottom : 1px solid #e5e7eb;
	}
	
	table td {
		width : 90%;
		text-align: center;
		border-bottom : 1px solid #e5e7eb;
	}
	
	table tr:last-child * {
	    border-bottom: none;
	}
	
	table tr:last-child td {
    	width : 30%;
	}

	table input, textarea {
		padding : 9px;
		margin : 7px;
		width : 99%;
		border : none;
	}
	
	textarea {
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
	<form class="section" id="enrollForm" enctype="multipart/form-data">
	
		<input type="hidden" name="postWriter" value="1"<%--value="${ sessionScope.loginUser.userNo }"--%>>
		
		<div class="title-area">
			<h2>학원소식</h2>
			
			<button type="submit" class="btn-primary">
				등록
			</button>
		</div>
		
		<div class="card">
			<table>
				<tr>
					<th>제목</th>
					<td colspan="3">
						<input type="text" name="title" required>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea name="content" required></textarea>
					</td>
				</tr>
				<tr>
					<th>대표이미지</th>
					<td colspan="3">
						<img id="titleImg" width="250" height="170">
					</td>
				</tr>
				<tr>
					<th>상세이미지</th>
					<td>
						<img id="contentImg1" width="150" height="110">
					</td>
					<td>
						<img id="contentImg2" width="150" height="110">
					</td>
					<td>
						<img id="contentImg3" width="150" height="110">
					</td>
				</tr>
			</table>
			<div id="file-area">
				<input type="file" accept="image/*" id="file1" name="files" onchange="loadImg(this, 1)">
				<input type="file" accept="image/*" id="file2" name="files" onchange="loadImg(this, 2)">
				<input type="file" accept="image/*" id="file3" name="files" onchange="loadImg(this, 3)">
				<input type="file" accept="image/*" id="file4" name="files" onchange="loadImg(this, 4)">
			</div>
		</div>
		
	</form>
	<script>
		$(function() {
		   
			$("#file-area").hide();
			
			$("#titleImg").click(function() {
				
				$("#file1").click();
			});
			
			$("#contentImg1").click(function() {
				
				$("#file2").click();
			});
			
			$("#contentImg2").click(function() {
				
				$("#file3").click();
			});
			
			$("#contentImg3").click(function() {
				
				$("#file4").click();
			});
			
		});
		
		function loadImg(inputFile, num) {
			
			if(inputFile.files.length == 1) {
				
				let reader = new FileReader();
				
				reader.readAsDataURL(inputFile.files[0]);
				
				reader.onload = function(e) {
					
					switch(num) {
					case 1 :
						$("#titleImg").attr("src", e.target.result);
						break;
					case 2 :
						$("#contentImg1").attr("src", e.target.result);
						break;
					case 3 :
						$("#contentImg2").attr("src", e.target.result);
						break;
					case 4 :
						$("#contentImg3").attr("src", e.target.result);
						break;
					}
					
				}
				
			} else {
				
				switch(num) {
				case 1 :
					$("#titleImg").attr("src", null);
					break;
				case 2 :
					$("#contentImg1").attr("src", null);
					break;
				case 3 :
					$("#contentImg2").attr("src", null);
					break;
				case 4 :
					$("#contentImg3").attr("src", null);
					break;
				}
				
			}
			
		}
		
	    $("#enrollForm").on("submit", function(event) {
	        event.preventDefault();
	        
	        let titleImgSrc = $("#titleImg").attr("src");
	        
	        if (!titleImgSrc || titleImgSrc === "" || titleImgSrc === "null") {
	            alert("대표 이미지는 무조건 있어야 합니다! 이미지를 등록해 주세요.");
	            return false;
	        }
	        
	        let formData = new FormData(this);
	        
	        $.ajax({
	            url : "/know-how/admin/academyNews/insert",
	            type : "post",
	            data : formData,
	            processData : false,
	            contentType : false,
	            success(result) {
					if(result == "success") {
						
						alert("학원소식이 등록되었습니다.");
						
						location.href = "/know-how/admin/academyNews";
						
					} else {
						
						alert("학원소식 등록에 실패했습니다.");
						
					}
				},
				error(xhr) {
					if (xhr.status === 413) {
			            alert("첨부파일의 용량이 너무 큽니다. 파일 크기를 줄여서 다시 시도해주세요.");
			        } else {
			        	console.log("학원소식 등록용 ajax 통신 실패!!");
			        }
				}
	        });
	    });
	</script>
</body>
</html>