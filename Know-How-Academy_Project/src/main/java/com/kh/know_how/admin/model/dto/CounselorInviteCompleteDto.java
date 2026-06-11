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
public class CounselorInviteCompleteDto {

    private int inviteNo;
    private String inviteName;
    private String inviteEmail;
    private int userNo; 

}
