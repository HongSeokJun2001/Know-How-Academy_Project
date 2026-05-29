<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Know-How Academy</title>
<style>
	#content{
		width: 100%;
		height: 500px;
		display: flex;
		justify-content: space-between;
		align-items: stretch;
		box-sizing: border-box;
	}
	#content>* {
		display: inline-block;
		margin-bottom: 10px;
	}
	#content_1 {
		width: 20%;
		border: 1px solid black;
		border-radius: 5px;
		padding : 20px 15px;
	}
	#content_2 {
		width: 60%;
		padding: 0 15px;
	}
	#content_3 {
		width: 20%;
		border: 1px solid black;
		border-radius: 5px;
		padding : 20px 15px;
	}
	
	#content_1 a {
		font-size: 12px;
		text-decoration: none;
		display: flex; 
		justify-content: flex-end;
		margin-bottom: 10px;
	}

	#content_1 tr{
		cursor: pointer;
	}
	#content_1 tr:last-child{
		border-bottom: 1px solid lightgray;
	}

	#content_2>img{
		width: 100%;
		height: 100%;
		object-fit: contain;
	}

	#thumbnail {
		display: inline-block;
		margin: 15px;
	}
	
</style>
</head>
<body>
	<jsp:include page="./common/menubar.jsp"/>

		<div class="outer">
			<div id="content">
				<div id="content_1">
					<h4 align="center"><b>공지사항</b></h1>
					<a href="/know-how/notice/list">더보기&gt;</a>
					<table class="table table-hover"></table>
				</div>
				<div id="content_2">
					<img src="/know-how/resources/image/academyintroimage.png" alt="학원소개이미지" />
				</div>
				<div id="content_3">
					<h4 align="center"><b>학원 소식</b></h4>
					<div id="thumbnail" align="center">
						<a href="/know-how/academyNews"><img src="/know-how/resources/image/academynews1.png" alt="학원소식이미지1" width="100" height="100" /></a>
						<p>
							학원소식제목1 <br>
							2026/05/28
						</p>
					</div>
					<div id="thumbnail" align="center">
						<a href="/know-how/academyNews"><img src="/know-how/resources/image/academynews2.png" alt="학원소식이미지2" width="100" height="100" /></a>
						<p>
							학원소식제목2 <br>
							2026/05/29
						</p>
					</div>
					<div id="thumbnail" align="center">
						<a href="/know-how/academyNews"><img src="/know-how/resources/image/academynews3.png" alt="학원소식이미지3" width="100" height="100" /></a>
						<p>
							학원소식제목3 <br>
							2026/05/30
						</p>
					</div>
					<div id="thumbnail" align="center">
						<a href="/know-how/academyNews"><img src="/know-how/resources/image/academynews4.png" alt="학원소식이미지4" width="100" height="100" /></a>
						<p>
							학원소식제목4 <br>
							2026/05/31
						</p>
					</div>
				</div>
			</div>
		</div>
	<script>
		$(function() {
			
			$.ajax({
				url : "/know-how/community/notice/mplist",
				type : "get",
				success : function(result) {
					if(result.length > 0){
						let resultStr = "";
						
						for(let i in result) {
							
							resultStr += "<tr>"
									   +		"<td>" + result[i].title + "<input type='hidden' name='noticeNo' value='"+ result[i].noticeNo +"'></td>"
									   +		"<td>" + result[i].viewCount + "</td>"
									   + "</tr>";
						}
						
						$("#content_1>table").html(resultStr);
					} else {
						$("#content_1>table").html("공지사항이 없습니다.");
					}
					
					
				},
				error : function() {
					
					console.log("공지사항 목록 조회용 ajax 통신 실패!!")
				}
			});
			
			$("#content_1>table").on("click", "tr", function() {
				
				let nno = $(this).find("input[name='noticeNo']").val();
				
				location.href = "/know-how/community/notice/detail/" + nno;
				
			});
			
		});
	</script>
	<jsp:include page="./common/footer.jsp" />
</body>
</html>