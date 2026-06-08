package com.kh.know_how.counselor.model.vo;

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
public class Counselor {
	
	private int logNo;         // LOG_NO	NUMBER
	private int reservationNo; // RESERVATION_NO	NUMBER
	private String content;    // CONTENT	CLOB
	private Date createdAt;    // CREATED_AT	DATE
	private Date updatedAt;    // UPDATED_AT	DATE
	private String status;     // STATUS	VARCHAR2(1 BYTE)
}
