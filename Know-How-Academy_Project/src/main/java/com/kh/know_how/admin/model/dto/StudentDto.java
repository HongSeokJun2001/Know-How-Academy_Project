package com.kh.know_how.admin.model.dto;

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
public class StudentDto {

	private String studentNo;
	private String studentName;
	private String phone;
	private String email;
	private String counselorName;
	private Date createdAt;
	private Date updatedAt;
	private String className;
	private String status;
	private String studentMemo;
	
}
