package com.kh.know_how.admin.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class StudentPendingListDto {

	private int userNo;
	private String studentName;
	private Date createdAt;
	private String status;
	
}