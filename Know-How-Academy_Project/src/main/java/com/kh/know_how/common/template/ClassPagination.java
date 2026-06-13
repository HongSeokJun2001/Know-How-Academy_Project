package com.kh.know_how.common.template;

import com.kh.know_how.common.model.vo.ClassPageInfo;

public class ClassPagination {
	
	public static ClassPageInfo getClassPageInfo(int listCount, int currentPage,
            int pageLimit, int classLimit) {
	int maxPage = (int)Math.ceil((double)listCount / classLimit);
	int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
	int endPage = startPage + pageLimit - 1;
	if(endPage > maxPage) {
		
		endPage = maxPage;
	}
	
	return new ClassPageInfo(listCount, currentPage, pageLimit, classLimit,
						maxPage, startPage, endPage);
	}
}
