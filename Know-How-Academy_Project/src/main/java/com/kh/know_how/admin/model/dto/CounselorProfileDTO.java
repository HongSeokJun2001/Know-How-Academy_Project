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
public class CounselorProfileDTO {
	
	private int userNo;
	private String userId;		
	private String imgPath;	
	private String status;	
    private String className;			
    private String userName;			
    private String phone;		
    private String email;	
    private int studentCount;
    
}
