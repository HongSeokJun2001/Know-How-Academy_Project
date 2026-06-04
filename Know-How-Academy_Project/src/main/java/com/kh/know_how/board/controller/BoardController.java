package com.kh.know_how.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.Pagination;


@Controller
@RequestMapping("/community/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	/**
	 * 일반 게시글 리스트 
	 * @return
	 */
	@GetMapping("/list")
	public String selectBoardList() {
		
		return "community/board/boardListView";
	}
	
	@ResponseBody
	@GetMapping("news/list")
	public Map<String, Object> selectNewsList(@RequestParam(value="cpage", defaultValue="1") int currentPage) {
		int listCount = boardService.selectNewsListCount();
		int boardLimit = 4;
		int pageLimit = 1;

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<Board> list = boardService.selectNewsList(pi);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		return map;
	}
	
	/**
	 * 학원 소식 상세조회페이지
	 * @return
	 */
	@GetMapping("news/detail/{postNo}")
	public ModelAndView academyNews(@PathVariable int postNo, ModelAndView mv) {
		Board b = boardService.selectNews(postNo);
		
		ArrayList<FileAttachment> list = boardService.selectFileAttachmentList(postNo);

		mv.addObject("b", b)
		  .addObject("list", list)
		  .setViewName("common/academyNews");
		
		return mv;
	}
	
	
}
