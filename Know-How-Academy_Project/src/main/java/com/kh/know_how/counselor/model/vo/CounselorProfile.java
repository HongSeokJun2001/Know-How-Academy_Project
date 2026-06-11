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
public class CounselorProfile {
	
	private int counselNo;         // 상담사번호
    private int categoryNo;        // 상담카테고리번호
    private String profileImgPath;  // 프로필사진경로
    private String bio;             // 사원정보
    private String status;          // 비고 (ACTIVE, ON_LEAVE, RETIRED)
    private int userNo;            // 사용자번호
    
}
