package com.kh.know_how.admin.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class StudentApproveDto {

	private int userNo;
	private String classNo;	
}