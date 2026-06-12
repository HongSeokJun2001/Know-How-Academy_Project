package com.kh.know_how.counselor.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.common.model.vo.ClassPageInfo;
import com.kh.know_how.common.template.ClassPagination;
import com.kh.know_how.counselor.model.service.CounselorService;

@Controller
@RequestMapping("myPageCounselor")
public class CounselorController {
    

	private Map<String, String> certNoList = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private CounselorService counselorService;
	
	@GetMapping("")
	public ModelAndView myPageCounselor(ModelAndView mv) {
		
	mv.setViewName("counselor/myPageCounselor");
		
	return mv;
	}
	
	@GetMapping("counselorInformationSelectForm") // 직원용 내정보 조회 페이지로 이동
	public ModelAndView counselorInformationSelectForm(ModelAndView mv) {
		
		mv.setViewName("counselor/counselorInformationSelectForm");
		
		return mv;
	}
	
	@GetMapping("counselorInformationChangeForm") // 직원용 내정보 수정 페이지로 이동
	public ModelAndView counselorInformationChangeForm(ModelAndView mv) {
		
		mv.setViewName("counselor/counselorInformationChangeForm");
		
		return mv;
	}
	
	@GetMapping("myStudentClassListForm") // 내학생리스트페이지로 이동
	public ModelAndView myStudentClassList(ModelAndView mv) {
		
		mv.setViewName("counselor/myStudentClassListForm");
		
		return mv;
	}
	
	@GetMapping("list")
	public ModelAndView selectClassList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		
		// 기본적으로 구할 수 있는 4개의 변수
		int listCount; // 현재 총 게시글의 갯수 (단, 삭제되지 않은 일반게시글의 갯수)
		
		int pageLimit; // 페이지 하단에 보여질 페이징바의 페이지 최대 갯수
		int boardLimit; // 한 페이지에 보여질 게시글의 최대 갯수 (즉, 한 페이지당 몇개씩 볼거냐)
		
		// 위의 4개의 변수들로 계산해서 구해야 하는 3개의 변수
		int maxPage; // 가장 마지막 페이지가 몇 번 페이지인지 (즉, 총 페이지 수)
		int startPage; // 페이지 하단에 보여질 페이징바의 시작수
		int endPage; // 페이지 하단에 보여질 페이징바의 끝수
		
		// * listCount : 반의 갯수
		// > BOARD 테이블의 유효한 데이터의 갯수를 COUNT 함수로 세오기!!
		listCount = counselorService.selectListCount();
		
		pageLimit = 10;
		
		boardLimit = 10;
		
		ClassPageInfo pi = ClassPagination.getClassPageInfo(listCount, currentPage, 
											 pageLimit, boardLimit);
		
				
		// pi 를 전달하면서 Service 로 요청 후 결과 받기
		ArrayList<Class> list = counselorService.selectClassList(pi);
		
		mv.addObject("list", list);
		
		
		mv.addObject("pi", pi);
		
		mv.setViewName("class/classListView");
		
		
		return mv;
	}
	
	@GetMapping("search")
	public ModelAndView searchClassList(String condition, String keyword,
										@RequestParam(value="cpage", defaultValue="1") int currentPage,
										ModelAndView mv) {
		
		
		// HashMap 
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int searchCount = counselorService.selectSearchCount(map);
		
	
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		
		ClassPageInfo pi = ClassPagination.getClassPageInfo(searchCount, currentPage, 
											 pageLimit, boardLimit);
		
		// 위의 HashMap 과 PageInfo 둘 다 넘기면서 검색용 쿼리문을 실행해서 결과를 받아야함!!
		ArrayList<Class> list = counselorService.searchClassList(map, pi);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("condition", condition)
		  .addObject("keyword", keyword)
		  .setViewName("board/boardListView");
		// > 그래서 위와 같이 메소드 체이닝이 가능하다!! (호출 순서 주의)
		
		return mv;
	}
	
}
