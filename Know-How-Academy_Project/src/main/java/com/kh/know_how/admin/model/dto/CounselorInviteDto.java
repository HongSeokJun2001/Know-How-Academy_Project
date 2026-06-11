package com.kh.know_how.admin.model.dto;

import java.util.ArrayList;

import com.kh.know_how.admin.common.PageResponseDto;

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
public class CounselorInviteDto {
	
	private String counselorName;
	private String email;
	private String inviteToken;
	private String inviteUrl;

}
