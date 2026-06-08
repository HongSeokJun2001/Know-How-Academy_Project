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
public class Reservation {
	
	//필드부
	private int reservationNo;			//	  RESERVATION_NO NUMBER CONSTRAINT PK_RESERVATION_NO PRIMARY KEY,
	private int studentNo;				//	  STUDENT_NO NUMBER NOT NULL,
	private int categoryNo;				//	  CATEGORY_NO NUMBER NOT NULL,
	private Date consultDate;			//	  CONSULT_DATE DATE DEFAULT SYSDATE NOT NULL,
	private String inquiryContent;		//	  INQUIRY_CONTENT CLOB NOT NULL,
	private String reservationStatus;	//	  RESERVATION_STATUS VARCHAR2(20) DEFAULT 'RESERVED' CONSTRAINT CK_RESERVATION_STATUS CHECK(RESERVATION_STATUS IN ('APPLIED', 'CANCELED', 'RESERVED', 'COMPLETED')), 
	private Date createdAt;				//	  CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	private Date updatedAt;				//	  UPDATED_AT DATE DEFAULT SYSDATE,
	private int counselNo;				//	  COUNSEL_NO NUMBER NOT NULL,
	
	private String counselorName;
	private String categoryName;
}
