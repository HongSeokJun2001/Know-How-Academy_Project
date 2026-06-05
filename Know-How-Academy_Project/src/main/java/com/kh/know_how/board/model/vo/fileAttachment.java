package com.kh.know_how.board.model.vo;

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
public class fileAttachment {

	private int fileNo;//	FILE_NO	NUMBER	파일 번호
	private int targetNo;//	TARGET_NO	NUMBER	게시글 번호
	private String targetType;//	TARGET_TYPE	VARCHAR2(20 BYTE)	게시판 유형 (POST, NOTICE 등)
	private String originName;//	ORIGIN_NAME	VARCHAR2(300 BYTE)	원본파일명
	private String saveName;//	SAVE_NAME	VARCHAR2(300 BYTE)	저장 파일명
	private String filePath;//	FILE_PATH	VARCHAR2(500 BYTE)	파일 저장 경로
	private Date createdAt;//	CREATED_AT	DATE	업로드 일
	private Date updateAt;//	UPDATED_AT	DATE	수정 일자
	private String status;//	STATUS	VARCHAR2(1 BYTE)	삭제 여부 (Y:유지, N:삭제)
	private String fileLevel;//	FILE_LEVEL	VARCHAR2(1 BYTE)	파일 구분 (1:썸네일, 2:일반)
	
}
