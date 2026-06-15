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
	
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);		
		
		int startPage = (currentPage - 1)/ pageLimit * pageLimit +1;
		
		int endPage = startPage + pageLimit - 1;
	
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	
										}
}
