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
public class StudentDetailDto {

	private int studentNo;
	private int userNo;
	private String studentName;
	private String phone;
	private String email;
	private Date createdAt;
	private String className;
	private String counselorName;
	private String studentStatus;
	private Date updatedAt;
}