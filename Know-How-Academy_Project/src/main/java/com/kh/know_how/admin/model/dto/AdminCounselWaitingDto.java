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

	private String createdAt;		//	상담 신청일
	private String studentName;		//	학생이름
	private String categoryName;	//	상담종류
	private String className;		//	클래스
	private String counselorName;	//	상담사이름
	private int elapsedDays;		//	경과일 (3일 이상은 빨간 글씨)
	private int categoryNo;			//	카테고리번호
	
}
