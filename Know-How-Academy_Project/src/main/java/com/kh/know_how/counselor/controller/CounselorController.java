package com.kh.know_how.counselor.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.counselor.model.service.CounselorService;
import com.kh.know_how.counselor.model.vo.Class;

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
	
    @GetMapping("myStudentClassListForm") // 학생 리스트
    public ModelAndView myStudentClassList(ModelAndView mv) {
    	ArrayList<Class> ClassList = counselorService.selectClassDetailList();
        
    	mv.addObject("ClassList", ClassList);
    	mv.setViewName("counselor/myStudentClassListForm");
    	return mv;
    }
	
}
