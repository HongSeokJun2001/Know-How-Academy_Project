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
            table {
                margin: auto;
            }
            .table tbody {
                cursor: pointer;
            }

            /*@@@@@@@@@@@@@@검색&게시글 영역@@@@@@@@@@@@@@*/
            #search-area {
                display: flex !important;
                /*자식요소 전부 위->아래 가 아닌 왼 ->오른으로 정렬*/
                /*!important; 붙은 스타일을 강제우선한다*/
                justify-content: center;
                /*가로축 기준 가운데 정렬*/
                align-items: center;
                /*세로축 기준 가운데 정렬*/
                /*display: flex 로 인해 내부 요소는 전부 박스로 변해 
                    align-items, justify-content 로 손쉽게정렬됫다. */
                gap: 6px;
                /*search-area 내부 요소간격*/
                margin: 20px 0;
                /*위아래 여백 20px*/
                /*20px 0px 20px 0px 와같다. == 상우하좌*/
            }

            /* select 대신 사용하는 드롭다운 버튼 스타일 (기존 크기/테두리 그대로) */
            #search-area .dropdown-toggle {
                width: 110px !important;
                /* 기존 select 너비 유지 */
                height: 38px;
                /* 기존 높이 유지 */
                background-color: #ffffff !important;
                border: 1px solid #ced4da !important;
                /* 검색창과 똑같은 테두리 */
                color: #495057;
                /* 글자 색상 */
                text-align: left;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            /* 검색창 스타일 */
            #search-area input[type="search"].form-control {
                width: 180px !important;
                height: 38px;
                background-color: #ffffff !important;
                border: 1px solid #ced4da !important;
                display: inline-block;
            }

            /* 검색 버튼 & 글쓰기 버튼 테두리 통일 */
            #search-area .btn-outline-secondary,
            .outer .write-btn-area .btn {
                height: 38px;
                border-color: #ced4da !important;
                color: #6c757d;
                background-color: #ffffff;
            }

            /* 🔥 [핵심] 딱딱함을 지운 둥근 모서리 내부 박스 스타일 */
            #search-area .dropdown-menu {
                min-width: 110px !important;
                /* 버튼 너비와 맞춤 */
                background-color: #ffffff !important;
                /* 내부 박스 바탕 흰색 */
                border: 1px solid #ced4da !important;
                /* 내부 박스 테두리 연한 회색 */
                border-radius: 8px !important;
                /* ⭕️ 모서리를 부드럽게 8px로 라운드 처리 */
                overflow: hidden;
                /* ⭕️ 내부 아이템이 라운드 밖으로 삐져나가지 않게 잘라냄 */
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                /* 은은하고 이쁜 그림자 효과 */
                padding: 4px 0;
            }

            /* 내부 박스 안의 아이템(글자) 스타일 */
            #search-area .dropdown-item {
                color: #333333 !important;
                font-size: 14px;
                padding: 8px 12px;
            }

            /* 마우스 올렸을 때(Hover) 배경색과 글자색 포인트 */
            #search-area .dropdown-item:hover {
                background-color: #f1f3f5 !important;
                /* 연한 회색 하이라이트 */
                color: #6f42c1 !important;
                /* 포인트 보라색 글씨 */
            }
            /*@@@@@@@@@@@@@@검색&게시글 영역@@@@@@@@@@@@@@*/

            /*@@@@@@@@@@@@@@페이징바 영역@@@@@@@@@@@@@@*/
            .paging-area {
                display: flex !important;
                justify-content: center;
                /* 가로축 기준 정중앙 정렬 */
                align-items: center;
                /* 세로축 기준 정중앙 정렬 */
                margin: 30px 0;
                /* 테이블과의 위아래 간격 */
            }

            /* 페이징바 링크(숫자 상자) 스타일 조정 */
            .paging-area .page-link {
                color: #495057 !important;
                /* 숫자 글자 색상 */
                background-color: #ffffff !important;
                /* 배경색 흰색 */
                border: 1px solid #ced4da !important;
                /*  검색창과 완벽히 일치하는 연한 회색 테두리 */
                padding: 6px 12px;
                transition: all 0.2s;
                /* 부드러운 효과 */
            }

            /* 마우스를 올렸을 때(Hover) 스타일 */
            .paging-area .page-link:hover {
                background-color: #f1f3f5 !important;
                /* 살짝 어두워지는 회색 배경 */
                color: #6f42c1 !important;
                /* 마우스 올리면 글씨 색상 포인트 */
            }

            /* 현재 선택된 페이지 번호 스타일 (Active) */
            .paging-area .page-item.active .page-link {
                background-color: #6c757d !important;
                /* 검색 버튼 톤과 일치하는 짙은 회색 */
                border-color: #6c757d !important;
                color: #ffffff !important;
                /* 글씨 흰색 */
            }

            /* 비활성화된 버튼 스타일 (첫 페이지에서 '이전' 버튼 등) */
            .paging-area .page-item.disabled .page-link {
                color: #6c757d !important;
                opacity: 0.5;
                /* 흐리게 처리 */
                background-color: #ffffff !important;
            }
            /*@@@@@@@@@@@@@@페이징바 영역@@@@@@@@@@@@@@*/
        </style>
    </head>

    <body>
        <jsp:include page="../common/menubar.jsp" />
      
        <div class="outer">
            <h2>공지사항</h2>
            <br>
            <hr>

            <div id="search-area">
                <div class="dropdown">
                    <button class="btn dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false">
                        작성자
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">작성자</a></li>
                        <li><a class="dropdown-item" href="#">제목</a></li>
                        <li><a class="dropdown-item" href="#">내용</a></li>
                    </ul>
                </div>
                <input type="search" name="keyword" class="form-control" placeholder="검색어를 입력하세요">

                <button type="submit" class="btn btn-outline-secondary">검색</button>
            </div>
            <br><br>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>글제목</td>
                        <td>이남훈</td>
                        <td>123</td>
                        <td>2026-05-27</td>
                    </tr>
                </tbody>
            </table>

            <!--@@@페이징바영역@@@-->
            <div class="paging-area">
                    <ul class="pagination">

                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">4</a></li>
                        <li class="page-item"><a class="page-link" href="#">5</a></li>
                        <li class="page-item"><a class="page-link" href="#">6</a></li>
                        <li class="page-item"><a class="page-link" href="#">7</a></li>
                        <li class="page-item"><a class="page-link" href="#">8</a></li>
                        <li class="page-item"><a class="page-link" href="#">9</a></li>
                        <li class="page-item"><a class="page-link" href="#">10</a></li>
                        <li class="page-item"><a class="page-link" href="#">11</a></li>

                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>

                    </ul>               
            </div>

        </div>


    </body>

    </html>