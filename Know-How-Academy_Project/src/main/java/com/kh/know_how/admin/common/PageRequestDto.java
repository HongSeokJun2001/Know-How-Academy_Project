package com.kh.know_how.admin.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class PageRequestDto {

	private int currentPage;    // 현재 페이지
    private int startRow;		// 가져올 목록번호 시작수
    private int endRow;			// 가져올 목록번호 마지막수
}
