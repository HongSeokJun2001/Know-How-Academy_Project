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
public class StudentListDto {

	private int studentNo;
	private String studentName;
	private String phone;
	private String counselorName;
	private Date createdAt;
	private String studentStatus;
	
}