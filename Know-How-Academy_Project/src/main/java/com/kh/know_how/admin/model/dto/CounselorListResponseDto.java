package com.kh.know_how.admin.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/** 상담사 목록조회 및 검색결과 DTO
 * DB 조회 결과를 받아올 List 의 형식이 되는 DTO
 */
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class CounselorListResponseDto {
	
	// 상담사 상세보기용, 자료 수정/삭제용
	private int userNo;  
	// 가입 거절용 가입번호
	private int inviteNo;           // 가입번호           // 유저 번호
    // 페이징처리용 목록정보
    private String userName;        // 상담사 이름
    private String email;		   // 상담사 이메일
    private String className;       // 담당클래스명
    private String status;          // 상태 : PENDING USED
    private String categoryName;    // 상담 카테고리 이름
    
}
