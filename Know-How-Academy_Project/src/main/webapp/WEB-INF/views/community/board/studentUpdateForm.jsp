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
            <jsp:include page="../../common/menubar.jsp" />

            <div class="outer">
                <h2 align="center">수강생 게시글 수정</h2>

                <form id="updateForm" action="/know-how/community/board/${type}/update" method="post"
                    enctype="multipart/form-data">
                    <input type="hidden" name="postNo" value="${b.postNo}">
                    <input type="hidden" name="postType" value="POST">

                    <div class="btn-area">
                        <a id="listBtn" href="/know-how/community/board/post"
                            class="btn btn-outline-secondary btn-hover">목록</a>
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
                            <td colspan="3">
                                <!--기존의 파일이 이미 있을 경우-->
                                <span id="changeFileArea">
                                    <c:if test="${ not empty requestScope.fa}">
                                        <a download="${fa.originName}" href="/know-how/${fa.filePath}${fa.saveName}">
                                            ${fa.originName}
                                        </a>
                                        <input type="hidden" name="originalFileNo" value="${fa.fileNo}">
                                        <input type="hidden" name="originalFileSaveName" value="${fa.saveName}">
                                    </c:if>
                                </span>

                                <button type="button" class="btn btn-outline-secondary"
                                    onclick="document.getElementById('fileInput').click();">파일 선택</button>
                                <input type="file" name="originalFile" id="fileInput" style="display:none;">
                            </td>
                        </tr>
                    </table>
                    <br>
                    <br>
                </form>
            </div>
            <script>
                document.getElementById('fileInput').addEventListener('change', function () {
                    // 기존 파일 정보 영역 선택
                    var changeFileArea = document.getElementById('changeFileArea');

                    // 새로 선택한 파일 이름 가져오기
                    var fileName = this.files[0].name;

                    // 기존 영역의 내용을 새로 선택한 파일 이름으로 교체
                    changeFileArea.innerHTML = '<span>' + fileName + '</span>';
                });
            </script>
        </body>

        </html>