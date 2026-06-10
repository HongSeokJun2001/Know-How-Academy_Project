package com.kh.know_how.admin.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**페이징처리용DTO
 * DB에서 계산된 결과를 받아오는 DTO
 */
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class PageResponseDto {
	
	//>>>>> pageLimit, boardLimit 은 admin/common/AdminPagination 에 있음!
	
    //DB 조회
    private int listCount;    // 총게시글의갯수(DB 조회)
    //UI 에서 넘어옴
    private int currentPage;  // 사용자가 요청한 페이지
    
    //개발자가 정해진 값을 입력
    private int pageLimit;    // 하단 페이지 번호 개수(페이징바의 '페이지 개수')
    private int boardLimit;   // 한 페이지당 '글 개수'
    
    //계산 결과
    private int maxPage;      // 가장 마지막 페이지 : (int)Math.ceil((double)listCount / boardLimit);
    private int startPage;    // 페이징바의 첫번째 페이지
    private int endPage;      // 페이징바의 마지막 페이지 
    
}
