package com.kh.know_how.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class ReservationPageInfo {

	    private int userNo;
		private int listCount;
		private int currentPage;
		private int pageLimit;
		private int reservationLimit;
		
		private int maxPage;
		private int startPage;
		private int endPage;

	
}
