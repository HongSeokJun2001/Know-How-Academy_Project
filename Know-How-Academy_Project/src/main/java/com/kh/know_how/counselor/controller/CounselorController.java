package com.kh.know_how.counselor.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.counselor.model.service.CounselorService;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.kh.know_how.counselor.model.vo.Class;

@Controller
@RequestMapping("myPageCounselor")
public class CounselorController {
    
	
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
	
    @PostMapping("myStudentClassListForm") // 학생 리스트
    public String myStudentClassList(HttpSession session, HttpServletResponse response, Model model, Member m) {
    	
    	ArrayList<Class> classList = counselorService.selectClassDetailList(m);
    	System.out.println("리스트 : " + classList);
        if(classList != null) {
    	model.addAttribute("classList", classList);
    	return ("counselor/myStudentClassListForm");
        } else {
        	model.addAttribute("errorMsg", "담당받은 반이없습니다.");
        	return ("counselor/counselorInformationSelectForm");
        }
    	
    }
	
}
