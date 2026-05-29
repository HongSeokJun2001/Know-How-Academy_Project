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
public class Board {

	//필드부
	private int postNo;//	POST_NO	NUMBER
	private int writerNo;//	WRITER_NO	NUMBER
	// > "1" (작성 시 회원번호) / "admin" (조회 시 회원 아이디)
	
	private String postType;//	POST_TYPE	VARCHAR2(10 BYTE)
	private String category;//	CATEGORY	VARCHAR2(30 BYTE)
	private String title;//	TITLE	VARCHAR2(200 BYTE)
	private String content;//	CONTENT	CLOB
	private Date createdAt;//	CREATED_AT	DATE
	private Date updatedAt;//	UPDATED_AT	DATE
	private String status;//	STATUS	VARCHAR2(1 BYTE)
	private int viewCount;//	VIEW_COUNT	NUMBER
	private String userName;	

	
	
	
}
