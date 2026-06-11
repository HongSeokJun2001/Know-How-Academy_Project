package com.kh.know_how.admin.model.dto;

import java.util.ArrayList;

import com.kh.know_how.admin.common.PageResponseDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


/**페이징처리시
 * DB에서 정보를 받아올 DTO
 */
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class CounselorListPageDto {
	
    private ArrayList<CounselorListResponseDto> counselorList;	//상담사 목록
    private PageResponseDto pageInfo;							//페이징공용DTO
    private ArrayList<ClassListDto> classList;					//담당상담사가없는 클래스 목록
    
}
