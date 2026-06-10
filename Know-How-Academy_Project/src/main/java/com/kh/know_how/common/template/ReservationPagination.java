package com.kh.know_how.common.template;

import com.kh.know_how.common.model.vo.ReservationPageInfo;

public class ReservationPagination {
    /*
	public static ReservationPageInfo getReservationPageInfo(int userNo, int listCount, int currentPage, int pageLimit, int reservationLimit) {
    	
    	
    	int maxPage = (int)Math.ceil((double)listCount / reservationLimit);
    	int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
    	int endPage = startPage + pageLimit - 1;
    	
    	if(endPage > maxPage) {
    		endPage = maxPage;
    	}
    	
    	return new ReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit, maxPage, startPage, endPage);
    	
	}
	*/
}
