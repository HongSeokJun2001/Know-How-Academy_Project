package com.kh.know_how.admin.common;



public class AdminPagination {
	
	public static PageResponseDto createPageInfo(PageRequestDto pageRequest, int listCount) {
		
		int pageLimit = 4; 
		int boardLimit = 4;
		
		int currentPage = pageRequest.getCurrentPage();
		if(currentPage < 1) { currentPage = 1; }
		
		int startRow = (currentPage - 1) * boardLimit + 1;
		int endRow = startRow + boardLimit - 1;
		
		pageRequest.setStartRow(startRow);
		pageRequest.setEndRow(endRow);
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > maxPage) {
            endPage = maxPage;
        }
        

        PageResponseDto pr = new PageResponseDto();
        pr.setListCount(listCount);
        pr.setCurrentPage(currentPage);
        pr.setPageLimit(pageLimit);
        pr.setBoardLimit(boardLimit);
        pr.setMaxPage(maxPage);
        pr.setStartPage(startPage);
        pr.setEndPage(endPage);

        return pr;

	}
	
}
