package com.kh.know_how.admin.model.dto;

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
public class AdminDashboardStatsDto {
	
		private int categoryNo;				// 상담 카테고리 번호
	    private String categoryName;		// 상담 카테고리 이름
	    private int currCount;				// 이번달 상담 신청 건수
	    private int prevCount;				// 지난달 상담 신청 건수
	    private double rate;				// 카테고리별 상담 신청률

}
