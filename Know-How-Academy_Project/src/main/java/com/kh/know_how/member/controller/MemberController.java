package com.kh.know_how.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.member.model.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {

	@GetMapping("/myPage")
	public String myPage() {
		
	return "member/myPage";
	}
	 
}
