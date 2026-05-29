package com.kh.know_how.common.template;

import com.kh.know_how.common.model.vo.PageInfo;

public class Pagination {
	
	/**
	 * 페이징처리
	 * @param listCount 총게시글
	 * @param currentPage 출력페이지
	 * @param pageLimit 보여줄 페이징바 갯수
	 * @param boardLimit 한 페이지 게시글 갯수
	 * @return
	 */	
	public static PageInfo getPageInfo(int listCount, 
										int currentPage, 
										int pageLimit,
										int boardLimit) {
		//단순 기능 클래스로서 static을사용 프로젝트 내에서 별도의 과정없이 바로 사용가능
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit);
	}

}
// pagination return 은 new가 붙는가