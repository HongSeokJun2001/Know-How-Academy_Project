package com.kh.know_how.member.model.vo;

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
public class MemberLock {
	private int userNo;      // USER_NO	NUMBER  사용자번호
	private int failCount;   // FAIL_COUNT	NUMBER 로그인실패횟수
	private String isLocked; // IS_LOCKED	VARCHAR2(1 BYTE) 계정잠금여부
	private Date lockedAt;// LOCKED_AT	DATE 잠금발생시간
	private Date lastFailAt;// LAST_FAIL_AT	DATE 마지막로그인실패시간
	private String userName; // USER_NAME 사용자 이름 (JOIN)
	private String roleCode; // ROLE_CODE 권한코드 (JOIN)
}
