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
	public String introduce() {
		
		return "common/academyIntroduce";
		
	}
	
	/**
	 * 학원 소식 상세조회페이지
	 * @return
	 */
	@GetMapping("/academyNews")
	public String academyNews() {
		
		return "common/academyNews";
		
	}
	
}
