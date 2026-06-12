package com.kh.know_how.counselor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.know_how.admin.model.dto.CounselorInviteCompleteDto;
import com.kh.know_how.admin.model.service.AdminService;
import com.kh.know_how.common.template.FileRenamePolicy;
import com.kh.know_how.counselor.model.vo.CounselorProfilImg;
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
    @ResponseBody
    @PostMapping("/counselor/signup/process")
    public String signupCounselor(Member member, CounselorProfile profile, HttpSession session) {
    	
    	
    	String message = "";
    	
    	try {
    		//세션에 가입정보가 없으면 홈으로
    		CounselorInviteCompleteDto inviteInfo = (CounselorInviteCompleteDto)session.getAttribute("inviteInfoDto");
        	if (inviteInfo == null) {
        		return "세션이 만료되었습니다. 초대 링크로 다시 접속해 주세요.";
        	}
        	
        	//프로필 사진 입력시 저장
        	MultipartFile file = profile.getProfileImg();
        	CounselorProfilImg cp = null;
        	
    		if (file != null && !file.isEmpty()) {
    			cp = new CounselorProfilImg();
    			
    			String changeName = FileRenamePolicy.saveFile(file, session, 
						"/resources/image/counselorProfile/");
    			profile.setProfileImgPath(changeName);
    			if("1".equals(changeName)) {
    				message = "imgFail";
    			}
        		cp.setOriginName(file.getOriginalFilename());
        		cp.setSaveName(changeName);
        		cp.setFilePath("resources/image/counselorProfile/");
    		}
    		
    		//서비스호출
        	int result = as.signupCounselor(member, inviteInfo, profile, cp);
        	
        	//결과값지정
        	if(result>0) {
        		
        		message = "회원가입에 성공하셨습니다.";
        		session.removeAttribute("inviteInfoDto");
        	}
        	
		} catch (IllegalArgumentException e) {
			
			System.out.println(">>> [상담사 회원가입 오류1] " + e.getMessage());
			//web 에서 빈 문자열 검사 후에도 들어온 null 값은 오류처리 
			message = "올바르지 않은 접근입니다.";
		} catch (RuntimeException e) {
			System.out.println(">>> [상담사 회원가입 오류2] " + e.getMessage());
			message = "imgFail";
		}
    	return message;
    }
    
    
    
}
