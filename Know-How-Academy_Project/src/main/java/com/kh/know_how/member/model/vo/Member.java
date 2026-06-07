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
public class Member {
  
	private int userNo;   // USER_NO INT 사용자 번호
	private String userId;	// USER_ID STRING 사용자 아이디
	private String userPwd;	// USER_PWD STRING 사용자 비밀번호
	private String userName;	// USER_NAME    사용자 이름
	private String phone;	// PHONE STRING 휴대폰 번호
	private String email;	// EMAIL STRING  이메일
	private String address;	// ADDRESS STRING 주소
	private String roleCode;	// ROLE_CODE STRING 권한코드
	private String status;	// STATUS STRING  상태값
	private Date createdAt;	// CREATED_AT DATE 생성일
	private Date updatedAt;	// UPDATED_AT DATE 수정일
	private int classNo;	// CLASS_NO INT 반번호
	
}
