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
public class AdminCounselWaitingDto {

	private String createdAt;		//	CREATED_AT(상담신청일)	DATE
	private String studentName;		//	USER_NAME(학생)	VARCHAR2(20 BYTE)
	private String categoryName;	//	CATEGORY_NAME(상담종류)	VARCHAR2(50 BYTE)
	private String className;		//	CLASS_NAME(클래스)	VARCHAR2(100 BYTE)
	private String counselorName;	//	USER_NAME(상담사)	VARCHAR2(20 BYTE)
	private int elapsedDays;		//	(경과일) int  --글씨색바꿀용도
	
	
}
