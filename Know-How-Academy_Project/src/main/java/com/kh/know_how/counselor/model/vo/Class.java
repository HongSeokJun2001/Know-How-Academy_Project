package com.kh.know_how.counselor.model.vo;

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
public class Class {
	private int classNo;          //CLASS_NO	NUMBER               반번호
	private String className;     //CLASS_NAME	VARCHAR2(100 BYTE)   반이름
	private String description;   //DESCRIPTION	VARCHAR2(500 BYTE)   반설명
	private String status;        //STATUS	VARCHAR2(1 BYTE)         사용상태
	private Date createdAt;       //CREATED_AT	DATE                 생성일
	private Date updatedAt;       //UPDATED_AT	DATE                 수정일

    private String userName;
    private String phone;
   

}
