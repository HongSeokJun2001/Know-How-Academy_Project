package com.kh.know_how.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.notice.model.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	//@Autowired
	//private NoticeService noticeService;
	
	/**
	 * 공지사항 게시글 리스트
	 * @return
	 */
	@GetMapping("/list")
	public String selectNoticeList() {
		
		return "notice/noticeListView";
	}
}
