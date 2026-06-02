<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <style>
                .outer {
                    border: none !important;
                }

                #content {
                    width: 940px;
                    margin: 10px auto;
                    border-collapse: collapse;
                }

                #content th {
                    width: 100px;
                    text-align: center;
                    font-size: 16px;
                    background-color: rgb(233, 233, 233);
                    font-weight: 450;
                    padding: 10px;
                }

                #content td {
                    width: 370px;
                    padding: 10px;
                }

                #reply-area {
                    margin: auto;
                    padding: 10px;
                    width: 940px;
                }

                #reply-area td {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .btn-area {
                    width: 940px;
                    margin: 0 auto;
                    display: flex;
                    /* 가로 정렬 시작 */
                    justify-content: space-between;
                    /* 왼쪽과 오른쪽으로 배치 */
                    align-items: center;
                }

                .leftBtn {
                    display: block;
                    gap: 5px;
                }

                .rightBtn2 {
                    width: 940px;
                    margin: 0 auto;
                    display: flex;
                    justify-content: flex-end;
                    margin-top: 10px;
                }

                #reply-area {
                    width: 940px;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                    margin: 20px auto;
                    display: flex;
                    /* 가로 정렬 시작 */
                    justify-content: space-between;
                    /* 왼쪽과 오른쪽으로 배치 */
                    align-items: center;
                }

                #reply-area>#replyContent {
                    width: 88%;
                    height: 100px;
                    border: none;
                    resize: none;
                }

                #reply-area>#reply-btn {
                    width: 12%;
                    height: 100px;
                    border: none;
                }
                #replyContent:focus{
                    outline-color: blueviolet;
                    border: 2px;
                }   
                #reply-btn:hover, #upBtn:hover, #delBtn:hover, #listBtn1:hover, #listBtn2:hover{
                    background-color: blueviolet;                    
                }
            </style>
        </head>

        <body>
            <jsp:include page="../common/menubar.jsp" />

            <div class="outer">
                <h2 align="center">일반게시판</h2>

                <div class="btn-area">
                    <div class="leftBtn">
                        <!--@@@수정/삭제 버튼은 로그인 폼 적용후 c:if내부로 이동@@@-->
                        <a id="upBtn" class="btn btn-outline-secondary" onclick="upPostSubmit(1)">수정</a>
                        <a id="delBtn" class="btn btn-outline-secondary" onclick="upPostSubmit(2)">삭제</a>
                        <!--수정과 삭제는 작성자 본인 만 볼수 있게 작업-->
                        <c:if test="${(not empty sessionScope.loginUser) and 
                            (sessionScope.loginUser.userId eq b.boardWriter)} ">
                            <!--로그인중이며, 사용자와 작성자명이 같을 경우에~~-->


                            <!--삭제하기위한 정보를 post 방식으로 전송-->
                            <form id="postForm" method="post">
                                <input type="hidden" name="bno" value="${b.boardNo}">
                            </form>
                            <!--수정과 삭제에 대한 실행작성-->
                            <script>
                                function upPostSubmit(num) {
                                    if (num == 1) {
                                        $("#postForm").prop("action", "/know-how/board/updateForm").submit();
                                    } else {
                                        $("#postForm").prop("action", "/know-how/board/deleteForm").submit();
                                    }
                                }
                            </script>
                        </c:if>
                    </div>
                    <div class="rightBtn1">
                        <a href="/know-how/board/list" id="listBtn1" class="btn btn-outline-secondary">목록</a>
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
                        <td colspan="3">${b.content}</td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="3">
                            <c:choose>
                                <c:when test="${empty at}">
                                    첨부파일이 없습니다.
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="rightBtn2">
                <a href="/know-how/board/list" id="listBtn2" class="btn btn-outline-secondary">목록</a>
            </div>


            <div class="" id="reply-area">
                <textarea id="replyContent"></textarea>
                <button type="submit" class="btn btn-outline-secondary" id="reply-btn">댓글 작성</button>
            </div>




        </body>


        </html>