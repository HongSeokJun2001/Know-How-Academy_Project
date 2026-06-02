package com.kh.know_how.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.Pagination;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	/**
	 * 일반 게시글 리스트
	 * 페이징처리
	 * @return
	 */
	@GetMapping("/list")
	public ModelAndView selectBoardList(
			@RequestParam(value="cpage",defaultValue="1")int currentPage, 
			ModelAndView mv) {
		
		//페이징처리
		int listCount; //게시글 총 갯수
		//int currentPage == 현재 사용자가 요청한 페이지
						   //상단 메서드에서 매개변수 작성
		int pageLimit; //페이지 하단에 보여질 페이징바 갯수(예 1~10의 버튼)
		int boardLimit; //한페이지에 보여질 게시글 갯수
		
		int maxPage; //가장 몇번페이지가 몇 번 페이지이 == 총 페이지 수
		int startPage; // 페이징바 시작수
		int endPage; // 페이징바 끝수
		
		listCount = boardService.selectListCount();
		
		pageLimit = 10;
		boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, 
											currentPage,
											pageLimit,
											boardLimit);	
		
		ArrayList<Board> list = boardService.selectBoardList(pi);
		//System.out.println("조회된 리스트 개수 : " + list.size());
		//System.out.println("리스트 내용 : " + list);
		//System.out.println("조회된 게시글 수 : " + list.size());
		
		mv.addObject("list",list);
		//다량의 게시글의 정보가 담긴 거
		
		mv.addObject("pi",pi);
		//페이징처리에 대한 정보와 페이징바 갯수 처리에 대한 정보가 담긴 거
		
		mv.setViewName("board/boardListView");
		//WEB-INF/views/board/boardListView.jsp
		
		
		
		return mv;
	}
	/**
	 * 일반 게시글 검색리스트 조회
	 * @param condition1 작성자/제목/내용
	 * @param condition2 입학/취업
	 * @param keyword 검색어
	 * @param currentPage 요청페이지
	 * @param mv
	 * @return
	 */
	@GetMapping("/search")
	public ModelAndView searchBoardList(String condition1, String condition2, String keyword,
										@RequestParam(value="cpage", defaultValue="1")int currentPage,
										ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition1", condition1);
		map.put("condition2", condition2);
		map.put("keyword", keyword);
		
		int searchCount = boardService.selectSearchCount(map);
		
		return mv;		
	}
	/**
	 * 
	 * @param boardNo Board VO
	 * @param model 
	 * @return
	 */
	@GetMapping("detail/{boardNo}")	
	public String selectBoard(@PathVariable int boardNo, Model model) {
				
		//System.out.println(boardNo);
		//해당 게시글의 조회?
		int result = boardService.increaseCount(boardNo);
		
		if(result>0) {
			
			//result > 0 이면 게시글 내부 DB 요청
			Board b = boardService.selectBoard(boardNo);
			
			model.addAttribute("b", b);
			//첨부파일작업시 재활성화
//			model.addAttributes("at", at);
			
			//첨부파일작업시 재활성화
			//Attachment at = boardService.selectAttachment(boardNo);
			
			return "board/boardDetailView";
						
		}else {
			//result > 0 아닐 시 에러문구 표현
		}
			
		return "common/errorPage";
	}
	
	
}
