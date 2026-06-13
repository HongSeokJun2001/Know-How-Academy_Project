package com.kh.know_how.reservation.model.vo;

import java.sql.Date;

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
public class CounselLog {
	private int logNo;
	private int reservationNo;
	private String content;
	private Date createdAt;
	private Date updatedAt;
	private String status;
}
