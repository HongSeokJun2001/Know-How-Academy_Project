<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <style>         

                /* 레이아웃 공통 설정 */
                .outer {
                    width: 940px !important;
                    border: none !important;
                }

                /* 게시글 테이블 */
                .table {                   
                    margin: 10px auto;
                    border-collapse: collapse;
                    table-layout: fixed;

                }

                .table th {
                    width: 100px;
                    padding: 10px;
                    text-align: center;                   
                    font-weight: 450;
                    background-color: rgb(233, 233, 233);
                }

                .table td {
                    padding: 10px;
                }

                /* 입력창 스타일 */
                input[type="text"],
                textarea {
                    width: 100%;
                    padding: 5px;
                    border: none;
                    outline: none;
                }

                textarea {
                    height: 300px;
                    resize: none !important;
                }

                /* 버튼 영역 */
                .btn-area {
                    width: 940px;
                    margin: 0 auto;
                    display: flex;
                    justify-content: flex-end;
                    /* 등록 버튼을 오른쪽으로 배치 */
                    gap: 10px;
                    align-items: center;
                }

                .btn-hover:hover {
                    background-color: blueviolet;
                    color: white;
                }
            </style>
        </head>

        <body>
            <jsp:include page="../common/menubar.jsp" />

            <div class="outer">
                <h2 align="center">자유게시글 수정</h2>

                <form id="updateForm" action="/know-how/board/insert" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="writerNo" value="${b.postNo}">

                    <div class="btn-area">
                        <a id="listBtn" href="/know-how/board/list" class="btn btn-outline-secondary btn-hover">목록</a>
                        <button type="submit" class="btn btn-outline-secondary btn-hover">등록</button>
                    </div>

                    <table class="table">
                        <tr>
                            <th>제목</th>
                            <td colspan="3"><input type="text" name="title" value="${b.title}" required></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td colspan="3"><textarea name="content" required>${b.content}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="3"><input type="file" name="originalFile" class="btn-hover"
                                    style="resize: none;"></td>
                        </tr>
                    </table>
                    <br>
                    <br>
                </form>
            </div>
        </body>

        </html>