package com.kh.know_how.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IntroduceController {

	/**
	 * 교육원 소개 페이지
	 * @return
	 */
	@GetMapping("/introduce")
	public String introduce() { // 교육원 소개 페이지를 불러오는 메소드
		
		return "common/academyIntroduce";
		
	}
	
}
