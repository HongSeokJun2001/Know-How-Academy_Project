package com.kh.know_how.common.model.vo;

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
public class ClassPageInfo {
	
	private int listCount;
	private int currentPage;
	private int pageLimit;
	private int classLimit;
	
	private int maxPage;
	private int startPage;
	private int endPage;
}
