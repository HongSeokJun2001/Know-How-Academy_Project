package com.kh.know_how.admin.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class PageInfoDto {
	
    //DB 조회
    private int listCount;    // 총게시글의갯수(DB 조회)
    //UI 에서 넘어옴
    private int currentPage;  // 사용자가 요청한 페이지
    //개발자가 정해진 값을 입력
    private int pageLimit;    // 하단 페이지 번호 개수(페이징바의 '페이지 개수')
    private int boardLimit;   // 한 페이지당 '목록 개수'
    
    //계산 결과
    private int maxPage;      // 가장 마지막 페이지 : (int)Math.ceil((double)listCount / boardLimit);
    private int startPage;    // 페이징바의 첫번째 페이지
    private int endPage;      // 페이징바의 마지막 페이지 

    private int startRow;     // SQL 조회 시작 행
    private int endRow;       // SQL 조회 끝 행
    
}
