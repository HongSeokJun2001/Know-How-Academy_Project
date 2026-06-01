package com.kh.know_how.common.template;

import com.kh.know_how.common.model.vo.PageInfo;

public class Pagination {
	
	/**
	 * 페이징처리
	 * @param listCount 총게시글
	 * @param currentPage 출력페이지
	 * @param pageLimit 보여줄 페이징바 갯수
	 * @param boardLimit 한 페이지 게시글 갯수
	 * @return
	 */	
	public static PageInfo getPageInfo(int listCount, 
										int currentPage, 
										int pageLimit,
										int boardLimit) {
		//단순 기능 클래스로서 static을사용 프로젝트 내에서 별도의 과정없이 바로 사용가능
		//getPageInfo == PageInfo에서 데이터를 가져온다.
		//(max, start, end)page들은 코드의 간결, 데이터일관성을 위해 현재 페이지에서 계싼하기위해 가져오지않음.
		
		//@@최대 페이지 수 or 가장 마지막 페이지 수		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);		
		//게시글 수 103개 / 출력해야될 페이지바 수 11페이지
		//처음 계산식을 실수로 나누는 이유는 listCount = 103 boardLimit = 10
		//값은 10.3이지만 정수끼리의 계싼은 반드시 정수여야한다는 규칙에 의해 
		//0.3은 버려지기에 Math.ceil로 넘어왔을때의 값은 이미 10(10페이지)이여서 안된다.
		//실수와 정수 사이서는 실수여야한다로 바뀌기에 double로 변환 후 Math.ceil로 10.3을 올림처리한다. == 11페이지
		
		//@@페이지바 시작수 설정 계싼
		int startPage = (currentPage - 1)/ pageLimit * pageLimit +1;
		// =( 3 - 1 )/ 10 * 10 +1
		// =( 2 ) / 10 * 10 +1
		// = 0 * 10 + 1
		// = 1 == 시작수 페이지
		
		//@@페이지바 끝수 설정 계싼
		int endPage = startPage + pageLimit - 1;
		// = 1 + 10 - 1
		// = 11 - 1 
		// = 10
		
		//현재 페이지currentPage(?cPage=n)가 속한 구간의 페이징바 범위를 결정하는 기준의 값 == startPage 와 endPage
		
		//@@startPage == 1  endPage == 10 인 상황에서
		//maxPage가 8인경우 나머지 9 , 10 페이지는 아무것도 없는 페이지이기에
		//필요없는 페이지는 버릴 겸 endPage 와 maxPage를 같게 만들어준다.
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		// 새로운 객체로서 PageInfo 를 만들엇다. 기존의 PageInfo와는 이름은같지만 주소값이 다른 객체
		//101호 PageInfo와 102호 PageInfo
	}

}
