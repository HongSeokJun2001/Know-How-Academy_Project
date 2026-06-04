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
public class TodayReservationDto {
	private String reservationTime;	//상담시간
	private String categoryName;	//상담종류
	private String studentName;		//학생이름
	private String counselorName;	//상담사이름
	private int categoryNo;			//상담카테고리번호
}
