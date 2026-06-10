package com.kh.know_how.admin.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class CounselorInviteListDto {
	
	private int inviteNo;
	private String inviteName;
	private String inviteEmail;
	private Date inviteSentAt;
	private String inviteStatus; 
	//PENDING USED CANCELED EXPIRED
	private int userNo;
}
