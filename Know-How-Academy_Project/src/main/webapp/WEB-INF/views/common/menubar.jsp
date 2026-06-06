<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .nav-area {
            background-color: rgb(82, 3, 209);
        }

        .menu {
            display: table-cell;
            height: 50px;
            width: 150px;
            position: relative;
        }
        .menu>ul {
            background-color: rgb(182, 174, 253);
            padding : 0px;
            list-style-type : none;
            display : none;
            position: absolute;
            top: 50px;
            left: 0;
            width: 100%;
            z-index: 1;
        }

        .menu a {
            text-decoration : none;
            color : white;
            font-size : 17px;
            font-weight : 560;
            width : 100%;
            height : 100%;
            display : block;
            line-height : 50px;
            text-align: center;
            transform : scale(1);
        }

        .menu a:hover {
            color : white;
            text-decoration: none;
            font-size : 18px;
        }
        .outer {
            width : 1500px;
            margin : auto;
            margin-top : 50px;
	    }
	    .mypage-outer {
	        width : 1200px;
            border : 1px dotted black;
            margin : auto;
            margin-top : 50px;
	    }
        header {
            text-align: center;
        }
        #logo_link {
            display: inline-block
        }
        #img_area{
	    .mypage-outer {
		width : 800px;
		border : 1px dotted black;
		margin : auto;
		margin-top : 50px;
		margin-bottom : 50px;
	    }
        img{
            width: 300px;
            display: block;
        }
        
    </style>
    
    <title>Know-How Academy</title>
    <!-- alertify 라이브러리 연동 구문 -->
    <!-- JavaScript -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css">
    <!-- Default theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css">
    <!-- Semantic UI theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css">

    <!-- JSP 에서 부트스트랩 연동도 가능함!! -->
    <!-- 부트스트랩 CDN 방식으로 연동하는 구문들 -->
    <!-- 예쁘게 정의된 스타일들이 들어 있는 CSS 파일 -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- 간단한 동작들을 정의해둔 JS 파일 -->
    <!-- 온라인 방식 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	
    <br>
    <header>
        <a href="/know-how" id="logo_link">
            <img id="img_area" src="/know-how/resources/image/logo.png" alt="로고"/>
        </a>
    </header>
    <br>

    <div class="nav-area" align="center">
        <div class="menu"><a href="/know-how/introduce">교육원 소개</a></div>
        <div class="menu">    
            <a href="#">상담</a>
            <ul>
                <li><a href="/know-how/reservation/list">예약리스트</a></li>
                <li><a href="/know-how/counselor/list">상담목록</a></li>
            </ul>
        </div>
        <div class="menu">
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="/know-how/notice/list">공지사항</a></li>
                <li><a href="/know-how/board/list">일반게시판</a></li>
                <li><a href="/know-how/student/list">수강생게시판</a></li>
            </ul>
        </div>
        <div class="menu"><a href="/know-how/member/myPage">마이페이지</a></div>
    </div>

<script>
		$(document).ready(function() {
			// .menu 영역에 마우스를 올리거나 뗐을 때 동작
			$('.menu').hover(
				function() {
					// 마우스를 올렸을 때: 자식요소인 ul을 부드럽게 내림
					$(this).children('ul').stop().slideDown(250);
				},
				function() {
					// 마우스를 뗐을 때: 자식요소인 ul을 부드럽게 올림
					$(this).children('ul').stop().slideUp(250);
				}
			);
		});
	</script>
</body>
</html>