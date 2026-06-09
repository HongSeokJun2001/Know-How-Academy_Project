<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <style>               
                /* 레이아웃 공통 설정 */
                .outer {
                    border: none !important;
                }

                /* 게시글 테이블 */
                #content {
                    width: 940px;
                    margin: 10px auto;
                    border-collapse: collapse;
                }

                #content th {
                    width: 100px;
                    padding: 10px;
                    text-align: center;
                    font-size: 16px;
                    font-weight: 450;
                    background-color: rgb(233, 233, 233);
                }

                #content td {
                    padding: 10px;
                }

                #content-body {
                    height: 300px;
                }

                /* 버튼 영역 */
                .btn-area, .rightBtn1, .rightBtn2{
                    width: 940px;
                    margin: 0 auto;
                    display: flex;
                     justify-content: flex-end;
                    align-items: center;
                }
                
                .rightBtn2 {
                    margin-top: 10px;
                }

                /* 댓글 영역 */
                #reply-area {
                    width: 940px;
                    margin: 20px auto;
                    padding: 10px;
                    display: flex;
                    gap: 10px;
                    justify-content: space-between;
                    align-items: center;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                }

                #replyContent {
                    width: 88%;
                    height: 100px;
                    border: none;
                    resize: none;
                }

                #replyContent:focus {
                    outline-color: blueviolet;
                    border: 2px;
                }

                #reply-btn {
                    width: 12%;
                    height: 100px;
                    border: none;
                }

                /* 호버 효과 그룹화 */
                #reply-btn:hover,
                #upBtn:hover,
                #delBtn:hover,
                #listBtn1:hover,
                #listBtn2:hover {
                    background-color: blueviolet;
                    color: white;
                    /* 호버 시 글자색도 흰색으로 바꾸면 더 예쁩니다 */
                }

                .fileName {
                    font-weight: bold;
                    color: blueviolet;
                }
            </style>
        </head>

        <body>
            <jsp:include page="../../common/menubar.jsp" />

            <div class="outer">
                <h2 align="center">자유게시판</h2>
                <div class="btn-area">
                    <!--수정과 삭제는 작성자 본인 만 볼수 있게 작업-->
                    <c:if test="${(not empty sessionScope.loginUser) and 
                            (sessionScope.loginUser.userNo eq b.writerNo)}">
                        <!--로그인중이며, 사용자와 작성자명이 같을 경우에~~-->
                        <div class="leftBtn">
                            <a id="upBtn" class="btn btn-outline-secondary" onclick="postSubmit(1)">수정</a>
                            <a id="delBtn" class="btn btn-outline-secondary" onclick="postSubmit(2)">삭제</a>
                        </div>
                        <!--삭제하기위한 정보를 post 방식으로 전송-->
                        <form id="postForm" method="post">
                            <input type="hidden" name="postNo" value="${b.postNo}">
                        </form>
                        <!--수정과 삭제에 대한 실행작성-->
                        <script>
                            function postSubmit(num) {
                                if (num == 1) {
                                    $("#postForm").prop("action", "/know-how/community/board/updateForm").submit();
                                } else {
                                    $("#postForm").prop("action", "/know-how/community/board/deleteForm").submit();
                                }
                            }
                        </script>
                    </c:if>

                    
                </div>
                <div class="rightBtn1">
                        <a href="/know-how/community/board/list" id="listBtn1" class="btn btn-outline-secondary">목록</a>
                    </div>
            </div>
            <table class="table" id="content">
                <tr>
                    <th>제목</th>
                    <td colspan="3">${b.title}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${b.userName}</td>
                    <th>작성일</th>
                    <td>${b.createdAt}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td id="content-body" colspan="3">${b.content}</td>
                </tr>
                <tr>
                    <!-- 첨부파일의 있고없고의 따른 경우 -->
                    <th>첨부파일</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${empty at}">
                                첨부파일이 없습니다.
                            </c:when>
                            <c:otherwise>
                                <a class="fileName" download="${at.originName}"
                                    href="/know-how/${at.filePath}${at.saveName}">${at.originName}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
            <div class="rightBtn2">
                <a href="/know-how/community/board/list" id="listBtn2" class="btn btn-outline-secondary">목록</a>
            </div>

            <div id="reply-area">
                <textarea id="replyContent"></textarea>
                <button type="submit" class="btn btn-outline-secondary" id="reply-btn">댓글 작성</button>
            </div>
            </div>





        </body>


        </html>