package com.kh.know_how.member.model.vo;

import java.sql.Date;

public class Member {
	private int number;//	USER_NO	NUMBER	사용자번호
	private String userId;//	USER_ID	VARCHAR2(50 BYTE)	사용자아이디
	private String userPwd;//	USER_PWD	VARCHAR2(200 BYTE)	사용자비밀번호
	private String userName;//	USER_NAME	VARCHAR2(20 BYTE)	사용자이름
	private String phone;//	PHONE	VARCHAR2(20 BYTE)	휴대폰번호
	private String enail;//	EMAIL	VARCHAR2(100 BYTE)	이메일
	private String address;//	ADDRESS	VARCHAR2(300 BYTE)	주소
	private String rollCode;//	ROLE_CODE	VARCHAR2(20 BYTE)	권한코드
	private String status;//	STATUS	VARCHAR2(20 BYTE)	상태값
	private Date createdAt;//	CREATED_AT	DATE	생성일
	private Date updateAt;//	UPDATED_AT	DATE	수정일
	private int classNo;//	CLASS_NO	NUMBER	반번호
}
