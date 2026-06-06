<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    <style>
        .outer {
            border: 1px red solid;
            text-align: center;
        }
        table{
            margin: auto;
        }
    </style>
    </head>

    <body>
        <jsp:include page="../../common/menubar.jsp" />

        <div class="outer">
            <h2>공지사항</h2>
            <br><br>

            <table class="table">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                    <tr>
                        <td>1001</td>
                        <td>글제목</td>
                        <td>이남훈</td>
                        <td>123</td>
                        <td>2026-05-27</td>
                    </tr>
                </thead>
                <tbody>

                </tbody>
                <tfoot>

                </tfoot>
                
            </table>

        </div>


    </body>

    </html>