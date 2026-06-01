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
	private String reservationTime;
	private String categoryName;
	private String studentName;
	private String counselorName;
}
