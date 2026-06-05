<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
         <style>
            .outer {
                text-align: center;
                border: none !important;
            }

            #search-area {}

            .table tbody {

                cursor: pointer;
            }

            #search-area {
                display: flex !important;
                justify-content: center;
                /*가운데 정렬*/
                align-items: center;
                /*세로축 기준 중앙 정렬*/
                gap: 6px;
                /*박스간격*/
                margin: 20px 0;
            }

            /* 선택창(select)과 검색창(input) 디자인 일체감 주기 */
            #search-area select.form-control {
                width: 110px !important;
                display: inline-block;
                background-color: #ffffff !important;
                /* 무조건 깔끔한 흰색 바탕 */
                border: 1px solid #ced4da;
                /* 은은한 회색 테두리 */
                border-radius: 4px;
                /* 부드러운 모서리 곡률 */
            }

            /* 검색 텍스트창의 너비 따로 조절 */
            #search-area input[type="search"] {
                width: 200px !important;
            }

            /* 글쓰기 버튼 영역 여백 */
            .write-btn-area {
                margin-bottom: 15px;
            }

            #search-area .btn,
            .outer .btn {
                border-color: #ced4da;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/menubar.jsp" />

        <div class="outer">
            <h2>수강게시판</h2>
            <br>
            <hr>
            <div id="search-area">
                <select name="condition1" class="form-control mr-sm-2">
                    <option value="writer">작성자</option>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>

                <select name="condition2" class="form-control mr-sm-2">
                    <option value="admission">입학상담</option>
                    <option value="employment">취업상담</option>
                </select>

                <input type="search" name="keyword" class="form-control mr-sm-2" placeholder="검색어를 입력하세요">
                <button type="submit" class="btn btn-outline-secondary">검색</button>
                <br><br>
            </div>

            <div class="write-btn-area" align="right">
                <button type="button" class="btn btn-outline-secondary">글쓰기</button>
            </div>

            <table class="table table-hover">
                <!--게시글 카테고리-->
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <!--게시글 목록-->
                <tbody>

                    <tr>
                        <td>1</td>
                        <td>취업상담</td>
                        <td>글제목</td>
                        <td>이남훈</td>
                        <td>10</td>
                        <td>2026-05-26</td>
                    </tr>
                </tbody>
                <!--페이징바-->
                <tfoot>

                </tfoot>
            </table>

        </div>
    </body>

    </html>