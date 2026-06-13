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
		position: relative;
		padding-bottom: 70px;
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

	.thumbnail {
		display: inline-block;
		margin: 15px;
		cursor: pointer;
	}
	
	.paging-area {
		position: absolute;
		bottom: 7px;
		left: 50%;
		transform: translateX(-50%);
	}
	
</style>
</head>
<body>
	<jsp:include page="./common/menubar.jsp"/>

		<div class="outer">
			<div id="content">
				<div id="content_1">
					<h4 align="center"><b>공지사항</b></h1>
					<a href="/know-how/community/notice/list">더보기&gt;</a>
					<table class="table table-hover"></table>
				</div>
				<div id="content_2">
					<img src="/know-how/resources/image/academyintroimage.png" alt="학원소개이미지" />
				</div>
				<div id="content_3">
					<h4 align="center"><b>학원 소식</b></h4>
					<div id="news">
					</div>
					<div class="paging-area">
						<ul class="pagination justify-content-center">
						</ul>
					</div>
				</div>
			</div>
		</div>
	<script>
		$(function() {
			// 메인페이지 공지사항 목록 ajax
			$.ajax({
				url : "/know-how/community/notice/mainnoticelist",
				type : "get",
				success : function(result) {

					if(result.length > 0){
						let resultStr = "";
						
						for(let i in result) {
							
							resultStr += "<tr>"
									   +		"<td>" + result[i].title + "<input type='hidden' name='noticeNo' value='"+ result[i].postNo +"'></td>"
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
			// 메인페이지 공지사항 클릭 시 상세조회 화면 출력
			$("#content_1>table").on("click", "tr", function() {
				
				let nno = $(this).find("input[name='noticeNo']").val();
				
				location.href = "/know-how/community/notice/detail/" + nno;
				
			});
			// 메인페이지 학원 소식 목록 currentPage 가 1로 시작 
			getNewsList(1);
			// 학원 소식 썸네일 클릭시 상세조회 화면 출력
			$(document).on("click", ".thumbnail", function() {
				
				let pno = $(this).children().eq(0).val();
				
				location.href = "/know-how/community/board/news/detail/" + pno;
			});
		});
		function getNewsList(page) {
			// 메인페이지 학원 소식 목록 ajax
			$.ajax({
				url : "/know-how/community/board/news/list",
				type : "get",
				data : { cpage : page },
				success : function(result) {
					
					if(result.list.length > 0){
						let resultList = "";
						let resultPi = "";
						
						for(let i in result.list) {
							let newsTitle = result.list[i].title;
							
							if(newsTitle.length > 6) {
								newsTitle = newsTitle.substring(0, 6) + "...";
							}
							
							resultList += "<div class='thumbnail' align='center'>"
									   + "<input type='hidden' value='" + result.list[i].postNo + "'>"
									   + "<img src='/know-how" + result.list[i].titleImg + "' width='100px' height='100px'>"
						    		   + "<p>"
									   + newsTitle + "<br>"
									   + result.list[i].createdAt.substring(0, 10)
									   + "</p>"
						   			   + "</div>";
						}
						$("#news").html(resultList);
						
						if(result.pi.currentPage == 1) {
							resultPi += "<li class='page-item disabled'>"
									  + "<a class='page-link'>&lt;</a>"
									  + "</li>";
						} else {
							let prevPage = result.pi.currentPage - 1
							resultPi += "<li class='page-item'>"
									  + "<a class='page-link' href='javascript:void(0);' onclick='getNewsList("+ prevPage +")'>&lt;</a>"
									  + "</li>";
						}
						
						if(result.pi.currentPage == result.pi.maxPage) {
							resultPi += "<li class='page-item disabled'>"
									  + "<a class='page-link'>&gt;</a>"
									  + "</li>";
						} else {
							let nextPage = result.pi.currentPage + 1;
							resultPi += "<li class='page-item'>"
									  + "<a class='page-link' href='javascript:void(0)' onclick='getNewsList("+ nextPage +")'>&gt;</a>"
									  + "</li>";
						}
						
						$(".paging-area>ul").html(resultPi);
					
					} else {
						$("#news").html("등록된 학원소식이 없습니다.")
						let resultStr = ""
						resultStr += "<li class='page-item disabled'>"
							       + "<a class='page-link'>&lt;</a>"
							       + "</li>"
								   + "<li class='page-item disabled'>"
							       + "<a class='page-link'>&gt;</a>"
							       + "</li>";
						$(".paging-area>ul").html(resultStr);
					}
				},
				error : function() {
				    console.log("학원소식 목록 조회용 ajax 통신 실패!!");
				}
			});
			
		}
			
	</script>
	<jsp:include page="./common/footer.jsp" />
</body>
</html>