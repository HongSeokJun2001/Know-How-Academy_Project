<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

    #footer {
        width : 100%;
        margin: 40px auto 0 auto; /* 메인 콘텐츠와의 상단 간격 40px 확보 */
    }

	#footer_1 {
        background-color: mediumslateblue;
		width : 100%;
	}

    #footer_2 {
        width: 100%;
    }

    .footer-inner {
        width: 1500px;
        margin: 0 auto;
        box-sizing: border-box;
    }

    #footer_1 .footer-inner {
        padding: 12px 0;
    }

    #footer_1 a {
        text-decoration: none;
        color: white;
        font-weight: 570;
        margin : 0 15px;
        vertical-align: middle;
    }

    #footer_2 ul {
        margin: 0px;
        font-size: 12px;
        padding: 20px 0 10px 0; /* 위아래 여백을 주고 왼쪽 기본 패딩(40px)을 제거 */
        list-style-position: inside;
    }

    #footer_2 li {
        margin-bottom: 6px; /* 줄글 간격 간격 확보 */
    }
    
    #footer_1 a:first-child {
        margin-left: 0;
    }

    #footer_2 p {
        margin: 20px 0 0 0;
        color: gray;
        font-size: 10px;
        text-align: center;
    }
</style>
</head>
<body>
    <div id="footer">
        <div id="footer_1">
            <div class="footer-inner">
                <a href="#">이용약관</a> | 
                <a href="#">개인정보 처리 방침</a> |
                <a href="#">인재채용 문의 </a> |
                <a href="#">신학협력 근황</a>
            </div>
        </div>

        <div id="footer_2">
            <div class="footer-inner">
                <ul>
                    <li>사업자(법인)명 : (주)Know-how 아카데미 사업자번호 : xxx-xx-xxxxx</li>
                    <li>대표자 : 홍길동</li>
                    <li>교육담당 : 코딩학원직업훈련시설명 : Khow-how 아카데미</li>
                </ul>
                <p>Copyrighterⓒ 2015 KOREA INFORMATION TECHNOLOGY ACADEMY. ALL RIGHTS RESERVED</p>
            </div>
        </div>
    </div>
    <br><br>
</body>
</html>