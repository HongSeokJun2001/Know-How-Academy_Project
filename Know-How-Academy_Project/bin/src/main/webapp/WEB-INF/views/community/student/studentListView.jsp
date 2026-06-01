<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            .outer {
                border: 1px solid red;
                text-align: center;
            }

            #search-area {
                border: 1px solid blue;
            }

            table {
                border: 1px solid blue;
                margin: auto;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../../common/menubar.jsp" />

        <div class="outer">
            <br>
            <h2>수강생게시판</h2>
            <br>

            <div id="search-area">
                <select name="condition1">
                    <option value="writer">작성자</option>
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>

                <select name="condition2">
                    <option value="admission">입학상담</option>
                    <option value="employment">취업상담</option>
                </select>

                <input type="search" name="keyword">
                <button type="submit">검색</button>
                <br><br>
            </div>

            <div class="" align="right">
                <input type="submit" value="글쓰기">
            </div>

            <table class="table">
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