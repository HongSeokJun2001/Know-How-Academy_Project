package com.kh.know_how.admin.model.dto;

import com.kh.know_how.admin.common.PageRequestDto;

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
public class CounselorSearchRequestDto {
	
	//검색어
	private String keyword;     // 검색어
	//페이징처리
	private String status = "ACTIVE";      // 활성/비활성 탭 구분
	private PageRequestDto pageRequest = new PageRequestDto(); // 현재페이지, 시작행, 끝행
    
}