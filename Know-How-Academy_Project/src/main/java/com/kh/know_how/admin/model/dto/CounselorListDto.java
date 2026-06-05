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
public class CounselorListDto {

	private int userNo;             //유저 번호
    private String userName;        //상담사 이름
    private String className;       //클래스명
    private int classNo;            //클래스번호
    private int inviteNo;           //가입테이블번호
    private int counselorCount;     //재직중인 상담사 수
    private int counselNo;          //상담사 번호
    private int categoryNo;         //상담 카테고리 번호
    private String categoryName;    //상담 카테고리 이름

}
