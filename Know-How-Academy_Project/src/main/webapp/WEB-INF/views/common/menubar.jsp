<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
	       background-color: #ffffff;
           border-radius: 12px;
           padding: 30px;
           box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
           border: 1px solid black;
           max-width: 1000px;
           margin: auto;
	    }
        header {
            text-align: center;
        }
        #logo_link {
            display: inline-block
        }
        #img_area img{
            width: 300px;
            display: block;
        }
        
    </style>
    
    <title>Know-How Academy</title>
    <!-- alertify 라이브러리 연동 구문 -->
    <!-- JavaScript -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>

                .menu a {
                    text-decoration: none;
                    color: white;
                    font-size: 17px;
                    font-weight: 560;
                    width: 100%;
                    height: 100%;
                    display: block;
                    line-height: 50px;
                    text-align: center;
                    transform: scale(1);
                }

                .menu a:hover {
                    color: white;
                    text-decoration: none;
                    font-size: 18px;
                }

                .outer {
                    width: 1500px;
                    margin: auto;
                    margin-top: 50px;
                }

                .mypage-outer {
                    width: 1200px;
                    border: 1px dotted black;
                    margin: auto;
                    margin-top: 50px;
                }

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%-- 
		- 1회성 alert 기능
		- script 태그 내에서는 JSP Action Tag 들이 사용 불가함!! (자바스크립트 영역이기 때문)
	--%>
	<c:if test="${ not empty sessionScope.alertMsg }">
		<script>
			
			let alertMsg = "${ sessionScope.alertMsg }";
			
			// alert(alertMsg);
			alertify.alert(alertMsg);
		
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>	
	<script>
		alertify.defaults.glossary.title = '시스템';
	</script>
    <br>
    <header>
        <a href="/know-how" id="logo_link">
            <img id="img_area" src="/know-how/resources/image/logo.png" alt="로고"/>
        </a>
    </header>
    <br>
    <c:choose>
		
	<c:when test="${empty sessionScope.loginUser}"> 
    <div class="nav-area" align="center">
        <div class="menu"><a href="/know-how/introduce">교육원 소개</a></div>
        <div class="menu">    
            <a href="#">상담</a>
            <ul>
                <li><a href="/know-how/reservation/list">예약리스트</a></li>
                <li><a href="/know-how/reservation/counselor/list">상담목록</a></li>
            </ul>
        </div>
        <div class="menu">
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="/know-how/community/notice/list">공지사항</a></li>
                <li><a href="/know-how/community/board/list">일반게시판</a></li>
                <li><a href="/know-how/community/student/list">수강생게시판</a></li>
            </ul>
        </div>
        <div class="menu"><a href="/know-how/myPage">로그인</a></div>
    </div>
    </c:when>
    <c:when test="${ sessionScope.loginUser.roleCode eq 'STUDENT' }">
    <div class="nav-area" align="center">
        <div class="menu"><a href="/know-how/introduce">교육원 소개</a></div>
        <div class="menu">    
            <a href="#">상담</a>
            <ul>
                <li><a href="/know-how/reservation/list">예약리스트</a></li>
                <li><a href="/know-how/reservation/counselor/list">상담목록</a></li>
            </ul>
        </div>
        <div class="menu">
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="/know-how/community/notice/list">공지사항</a></li>
                <li><a href="/know-how/community/board/list">일반게시판</a></li>
                <li><a href="/know-how/community/student/list">수강생게시판</a></li>
            </ul>
        </div>
        <div class="menu"><a href="/know-how/myPage">마이페이지</a></div>
    </div>
    </c:when>
    <c:otherwise>
    <div class="nav-area" align="center">
        <div class="menu"><a href="/know-how/introduce">교육원 소개</a></div>
        <div class="menu">    
            <a href="#">상담</a>
            <ul>
                <li><a href="/know-how/reservation/list">예약리스트</a></li>
                <li><a href="/know-how/reservation/counselor/list">상담목록</a></li>
            </ul>
        </div>
        <div class="menu">
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="/know-how/community/notice/list">공지사항</a></li>
                <li><a href="/know-how/community/board/list">일반게시판</a></li>
                <li><a href="/know-how/community/student/list">수강생게시판</a></li>
            </ul>
        </div>
        <div class="menu"><a href="/know-how/myPageCounselor">마이페이지</a></div>
    </div>
    </c:otherwise>
    </c:choose>
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
	
	<c:if test="${ not empty sessionScope.alertMsg }">
		<script>
		let alertMsg = "${ sessionScope.alertMsg }";
		alertify.alert(alertMsg, function() {alertify.success('OK');});
		</script>
	</c:if>
	<c:remove var="alertMsg" scope="session"/>
</body>
</html>
