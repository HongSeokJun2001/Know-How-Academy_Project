package com.kh.know_how.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.board.model.service.BoardService;

@Controller
@RequestMapping("/community/board")
public class BoardController {
	
	//@Autowired
	//private BoardService boardService;

	/**
	 * 일반 게시글 리스트 
	 * @return
	 */
	@GetMapping("/list")
	public String selectBoardList() {
		
		return "community/board/boardListView";
	}
	
	
	
}
