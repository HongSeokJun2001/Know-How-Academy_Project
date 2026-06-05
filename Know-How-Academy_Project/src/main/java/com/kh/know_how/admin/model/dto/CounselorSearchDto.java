package com.kh.know_how.admin.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**페이징처리시
 * DB로 정보 전달용 DTO
 */
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class CounselorSearchDto {
	
    private String status;      // ACTIVE, INACTIVE
    private String keyword;		// 검색키워드

    private int startRow;		// 가져올 목록번호 시작수
    private int endRow;			// 가져올 목록번호 마지막수
    
}