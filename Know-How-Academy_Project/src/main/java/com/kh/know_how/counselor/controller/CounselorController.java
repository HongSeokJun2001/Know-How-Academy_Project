package com.kh.know_how.counselor.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.member.model.service.MemberService;

@Controller
@RequestMapping("myPageCounselor")
public class CounselorController {
    
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private Map<String, String> certNoList = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private JavaMailSender mailSender; 
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("")
	public ModelAndView myPageCounselor(ModelAndView mv) {
		
	mv.setViewName("counselor/myPageCounselor");
		
	return mv;
	}
	
	@GetMapping("counselorMyInformationSelectForm") // 직원용 내정보 조회 페이지로 이동
	public ModelAndView counselorMyInformationSelectForm(ModelAndView mv) {
		
		mv.setViewName("counselor/counselorMyInformationSelectForm");
		
		return mv;
	}
	
	@GetMapping("counselorMyInformationChangeForm") // 직원용 내정보 수정 페이지로 이동
	public ModelAndView counselorMyInformationChangeForm(ModelAndView mv) {
		
		mv.setViewName("counselor/counselorMyInformationChangeForm");
		
		return mv;
	}
	
}
