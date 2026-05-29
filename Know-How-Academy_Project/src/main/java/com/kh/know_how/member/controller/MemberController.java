package com.kh.know_how.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.member.model.service.MemberService;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("member")
public class MemberController {
    
	// 아직 암호화 하기전임
	// 암호화 @Autowired
	// 암호화private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/myPage")
	public String myPage() {
		
	return "member/myPage";
	}

	@PostMapping("login")
	public String loginMember(Member m, Model model, 
			                  HttpSession session, HttpServletResponse response) {
		
		// Service 요청 후 결과받기
		Member loginUser = memberService.loginMember(m);
						
		// 결과에 따른 응답화면 지정
		if(loginUser == null) {
		// > 로그인 실패
				
		model.addAttribute("errorMsg", "로그인에 실패했습니다.");
					
		return "common/errorPage";
					
		} else {
		// > 로그인 성공
					
		// 로그인한 회원의 정보를 응답데이터로 session 객체에 담아두기!!
		session.setAttribute("loginUser", loginUser);
			
		// > menubar.jsp 에서 공통코드
		session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
					
		return "redirect:/"; 
		}		
					
	}
	
	@GetMapping("logout")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
		session.setAttribute("alertMsg", "성공적으로 로그아웃이 되었습니다.");
		
		return "redirect:/";
	}
	
	@GetMapping("enrollForm") // 회원가입페이지로 이동
	public String enrollForm() {
		
		return "member/memberEnrollForm";
	}
	
	@GetMapping("searchIdForm") // 내 아이디 찾기
	public String searchIdForm() {
		
		return "member/searchIdForm";
	}
	
	@GetMapping("searchPasswordForm") // 내 비밀번호 찾기
	public String searchPasswordForm() {
		
		return "member/searchPasswordForm";
	}
	
	@GetMapping("myInformationSelectForm") // 내정보 찾기 페이지로 이동
	public String myInformationSelectForm() {
		
		return "member/myInformationSelectForm";
	}
	
	@GetMapping("myInformationChangeForm") // 내정보 수정 페이지로 이동
	public String myInformationChangeForm() {
		
		return "member/myInformationChangeForm";
	}
	
	
	@PostMapping("insert")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		// 암호화 하기전
		int result = memberService.insertMember(m);
		
		if(result > 0) {
		// > 회원가입 성공
			
		// 1회성 알림 문구를 담아서 메인페이지로 url 재요청
		session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");
			
		return "redirect:/";
			
		} else {
		// > 회원가입 실패
			
		// 에러 문구를 담아서 에러페이지로 포워딩
		model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
			
		return "common/errorPage";
		// > /WEB-INF/views/common/errorPage.jsp
		}
	}
}
