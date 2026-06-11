package com.kh.know_how.counselor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.know_how.admin.model.dto.CounselorInviteCompleteDto;
import com.kh.know_how.admin.model.service.AdminService;
import com.kh.know_how.counselor.model.vo.CounselorProfile;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/myPageCounselor")
@Controller
public class CounselorSignupController {
	
	
	//[필드부]
	@Autowired
	private AdminService as;
	
	//[메소드부]
	//----------- 상담사 가입 페이지 메소드 (토큰확인 후 email 주소 전달)
    @GetMapping("/counselor/signup")
    public String getCounselorInfo(@RequestParam("token") String token, Model model, HttpSession session) {
    	
    	CounselorInviteCompleteDto inviteInfoDto = as.getCounselorInfo(token);
    	
    	session.setAttribute("inviteInfoDto",inviteInfoDto);
    	model.addAttribute("inviteInfoDto",inviteInfoDto);
    	
    	return "counselor/counselorEnrollForm";
    }
    
    
    //----------- 상담사 회원가입 메소드 
    @PostMapping("")
    public String signupCounselor(Member member, CounselorProfile profile, HttpSession session) {
    	
    	try {
    		CounselorInviteCompleteDto inviteInfo = (CounselorInviteCompleteDto)session.getAttribute("inviteInfoDto");
        	if (inviteInfo == null) {
        	    return "redirect:/";
        	}
        	
        	int result = as.signupCounselor(member, inviteInfo, profile);
        	
        	if(result>0) {
        		session.setAttribute("alertMsg", "회원가입에 성공했습니다.");
        	}
        	
        	session.removeAttribute("counselorInvite");

		} catch (IllegalArgumentException e) {
			
			System.out.println(">>> [상담사 회원가입 오류] " + e.getMessage());
			//web 에서 빈 문자열 검사 후에도 들어온 null 값은 오류처리 
			session.setAttribute("alertMsg", "올바르지 않은 요청입니다");
		}
    	return "redirect:/";
    }
    
    
    
}
