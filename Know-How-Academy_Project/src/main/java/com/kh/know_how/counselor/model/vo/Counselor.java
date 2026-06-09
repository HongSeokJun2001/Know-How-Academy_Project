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
	
	private int logNo;         // LOG_NO	NUMBER            상담일지 번호
	private int reservationNo; // RESERVATION_NO	NUMBER    예약 번호
	private String content;    // CONTENT	CLOB              상담내용
	private Date createdAt;    // CREATED_AT	DATE          작성일
	private Date updatedAt;    // UPDATED_AT	DATE          수정일
	private String status;     // STATUS	VARCHAR2(1 BYTE)  상태값
}
