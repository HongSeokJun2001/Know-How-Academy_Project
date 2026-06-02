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
	
	private int currHiredCount;		//이번달 입학상담 신청횟수
	private int prevHiredCount;		//저번달 입학상담 신청횟수
	private int currEnrollCount;	//이번달 취업상담 신청횟수
	private int prevEnrollCount;	//저번달 취업상담 신청횟수
	
	private double enrollRate;   // 이번달 신청상담수 대비 입학상담 비율
	private double hiredRate;    // 이번달 신청상담수 대비 취업상담 비율
}
