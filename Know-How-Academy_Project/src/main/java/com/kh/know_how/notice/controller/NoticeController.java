package com.kh.know_how.notice.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;

@Controller
@RequestMapping("community/notice")
public class NoticeController {
	
	@Autowired
	private BoardService boardService;
	
	/**
	 * 공지사항 게시글 리스트
	 * @return
	 */
	@GetMapping("/list")
	public String selectNoticeList() {
		
		return "community/notice/noticeListView";
	}
	
	@ResponseBody
	@GetMapping("/mainnoticelist")
	public ArrayList<Board> mainPageNoticeList() {
		
		return boardService.mainPageNoticeList();
		
	}
}
