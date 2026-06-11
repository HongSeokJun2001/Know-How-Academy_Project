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

                .top-area {
                    width: 940px;
                    margin: 0 auto 10px auto;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .bottom-area {
                    width: 940px;
                    margin: 0 auto;
                    display: flex;
                    justify-content: flex-end;
                }

                #leftBtn {
                    display: flex;
                    gap: 5px;

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
                <div class="top-area">
                    <div id="leftBtn">
                        <!--수정과 삭제는 작성자 본인 만 볼수 있게 작업-->
                        <c:if test="${(not empty sessionScope.loginUser) and 
                            (sessionScope.loginUser.userNo eq b.writerNo)}">
                            <!--로그인중이며, 사용자와 작성자명이 같을 경우에~~-->

                            <a id="upBtn" class="btn btn-outline-secondary" onclick="postSubmit(1)">수정</a>
                            <a id="delBtn" class="btn btn-outline-secondary" onclick="postSubmit(2)">삭제</a>

                            <!--삭제하기위한 정보를 post 방식으로 전송-->
                            <form id="postForm" method="post">
                                <input type="hidden" name="postNo" value="${b.postNo}">
                            </form>
                            <!--수정과 삭제에 대한 실행작성-->
                            <script>
                                function postSubmit(num) {
                                    if (num == 1) {
                                        $("#postForm").prop("action", "/know-how/community/board/${type}/updateForm").submit();
                                    } else {
                                        $("#postForm").prop("action", "/know-how/community/board/${type}/deleteForm").submit();
                                    }
                                }
                            </script>
                        </c:if>
                    </div>
                    <div class="rightBtn">
                        <a href="/know-how/community/board/post" class="btn btn-outline-secondary">목록</a>
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
                                <c:when test="${empty fa}">
                                    첨부파일이 없습니다.
                                </c:when>
                                <c:otherwise>
                                    <a class="fileName" download="${fa.originName}"
                                        href="/know-how/${fa.filePath}${fa.saveName}">${fa.originName}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
                <div class="bottom-area">
                    <a id="rightBtn2" href="/know-how/community/board/post" class="btn btn-outline-secondary">목록</a>
                </div>
                <div id="reply-area">
                    <c:choose>
                        <c:when test="${ !empty loginUser}">
                            <div id="reply-area">
                                <textarea id="replyContent"></textarea>
                                <button type="submit" class="btn btn-outline-secondary" id="reply-btn">
                                    댓글작성
                                </button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <textarea id="replyContent" style="font-size: 25px;" placeholder="로그인 후 이용 가능합니다."
                                readonly></textarea>
                            <button id="reply-btn" type="submit" class="btn btn-outline-secondary" disabled>
                                댓글작성
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div id="reply-list"></div>

                <script>
                    //댓글목록 조회용
                    function selectReplyList() {
                        selectReplyList();

                        setInterval(selectReplyList, 1000);

                        $.ajax({
                            url: "/know-how/board/${type}/clist",
                            type: "get",
                            data: { postNo: "${ requestScope.p.postNo }" },
                            success: function (result) {

                                let resultStr = "";

                                for (let i in result) {

                                    resultStr += "<div>"
                                        + "<span>" + result[i].replyWriter + "</span>"
                                        + "<span>" + result[i].replyContent + "</span>"
                                        + "<span>" + result[i].createDate + "</span>"
                                        + "</div>";
                                }
                                $('#reply-list').html(resultStr);
                            },
                            error: function () {

                                console.log("실패");

                            }

                        })
                    }

                    //댓글 등록용 함수
                    function insertReply(){

                        //사용자가 입력한 댓글 담기
                        let replyContent = $("#replyContent").val();

                        //등록 요청시 /know-how/board/${type}/rinsert" post
                        //PostComment에 postNo, replyNo 만 넘길 것

                        $.ajax({
                            url : "/know-how/board/${type}/cinsert",
                            type : "${type}",
                            data : {
                                postNo : "${p.postNo}",
                                replyNo : "${p.replyNo}"
                            },
                            success : function(result){

                                if(result == "success"){
                                    //요청 성공, 목록 재조회 및 textarea초기화
                                    selectReplyList();

                                    $("#replyContent").val("");
                                }else {
                                    alert("작성실패");
                                }
                            },
                            error : function(){
                                console.log("실패");
                            }
                        })

                    }
                </script>

            </div>

        </body>


        </html>