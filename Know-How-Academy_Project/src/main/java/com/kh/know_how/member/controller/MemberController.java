package com.kh.know_how.member.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.member.model.service.MemberService;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("myPage")
public class MemberController {
    
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	private Map<String, String> certNoList = Collections.synchronizedMap(new HashMap<>());
	
	@Autowired
	private JavaMailSender mailSender; 
	
	@Autowired
	private MemberService memberService;

	@GetMapping("")
	public ModelAndView myPage(ModelAndView mv) {
		
	mv.setViewName("member/myPage");
		
	return mv;
	}
	
	@PostMapping("login")
	public String loginMember(Member m, Model model, String saveId, 
			                  HttpSession session, HttpServletResponse response) {
	
		// 아이디 저장 기능 
		// 2. 아이디 저장 여부에 따른 쿠키 생성
			if((saveId != null) && (saveId.equals("y"))) {
				// > 아이디를 저장하고 싶은 경우
		
				Cookie cookie = new Cookie("saveId", m.getUserId());
				cookie.setMaxAge(1 * 24 * 60 * 60); // 1일 (초단위)
				cookie.setPath("/know-how/"); // 이 쿠키를 우리 웹사이트 내부에서만 이용 가능하게끔
				
				response.addCookie(cookie);
				
			} else {
				// > 아이디를 저장하지 않을 경우
				//   아이디값을 갖고 있던 "쿠키" 를 삭제
				Cookie cookie = new Cookie("saveId", m.getUserId());
				cookie.setMaxAge(0);
				cookie.setPath("/know-how/");
				
				response.addCookie(cookie);
			}
			
			// 암호화 작업
			// Service 요청 후 결과 받기
			Member loginUser = memberService.loginMember(m);
			
			// 암호화 작업 후 비밀알아내기
			String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
			System.out.println("암호문 : " + encPwd);
			
			if((loginUser != null) && 
			   (bCryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd()))) {
				// > 로그인 성공일 경우
				
				// 로그인한 회원의 정보를 마찬가지로 session 에 담아야함!! (loginUser 키값으로)
				session.setAttribute("loginUser", loginUser);
				
				String roleCode = loginUser.getRoleCode(); 
				
				if("STUDENT".equals(loginUser.getRoleCode())) {
					// 세션에 1회성 알림 문구를 담아 메인페이지로 url 재요청
					session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
					
					return "redirect:/myPage";
				} else if("COUNSELOR".equals(loginUser.getRoleCode())) {
					// 세션에 1회성 알림 문구를 담아 메인페이지로 url 재요청
					session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
					
					return "redirect:/myPageCounselor";
				} else {
					// > 관리자 계정일때
					model.addAttribute("errorMsg", "관리자계정입니다.관리자페이지로 이동하세요.");
					
					return "redirect:/";
				}
				
			} else {
				// > 로그인 실패일 경우
				
				// 에러 문구를 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "로그인에 실패했습니다.");
				
				return "common/errorPage";
			}	
				
	}
	
	@GetMapping("logout")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
		session.setAttribute("alertMsg", "로그아웃이 되었습니다.");
		
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
	
	@GetMapping("myInformationSelectForm") // 내정보 조회 페이지로 이동
	public ModelAndView myInformationSelectForm(ModelAndView mv) {
		
		mv.setViewName("member/myInformationSelectForm");
		
		return mv;
	}
	
	@GetMapping("myInformationChangeForm") // 내정보 수정 페이지로 이동
	public ModelAndView myInformationChangeForm(ModelAndView mv) {
		
		mv.setViewName("member/myInformationChangeForm");
		
		return mv;
	}
	
	@GetMapping("checkPasswordForm") // 비밀번호확인 페이지로 이동
	public ModelAndView checkPasswordForm(ModelAndView mv) {
		
		mv.setViewName("member/checkPasswordForm");
		
		return mv;
	}
	
	@PostMapping("memberEnrollForm/insert")
	public String insertMember(Member m, Model model, HttpSession session) {
		
		    // 암호화 작업 후
			String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
			
			// 비번 필드값 변경
			m.setUserPwd(encPwd);
			
			// > 최종적으로 셋팅된 Member 객체를 Service 로 넘기면서 요청 후 결과 받기
			int result = memberService.insertMember(m);
			
			// 3. 결과에 따른 응답페이지 지정
			if(result > 0) {
				// > 회원가입 성공
				
				// 1회성 알림문구를 담아서 메인페이지로 url 재요청
				session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");
				
				return "redirect:/";
				
			} else { 
				// > 회원가입 실패
				
				// 에러 문구를 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
				
				return "common/errorPage";
			}
	}
	
	@PostMapping("update")
	public ModelAndView updateMember(Member m, ModelAndView mv, HttpSession session) {
		
		int result = memberService.updateMember(m);
		
		// 응답페이지 처리
		if(result > 0) {
			// 회원 정보 변경에 성공했을 경우
			
			Member updateMem = memberService.loginMember(m);
			
			session.setAttribute("loginUser", updateMem);
			
			session.setAttribute("alertMsg","회원정보가 변경되었습니다.");
			
			mv.setViewName("redirect:/member/myInformationChangeForm");
		
		} else {
			// 회원 정보 변경 실패했을 경우
			
			mv.addObject("errorMsg","회원정보 변경에 실패했습니다.");
			
			mv.setViewName("common/errorPage");
		}
		
		return mv;
		
	}
	
	@PostMapping("updatePwd")
	public String updatePwd(String userId, String userPwd, String updatePwd, HttpSession session) {
		
		// 우선 사용자가 입력한 평문 현재의 비밀번호와 
		// 세션에 담겨있는 현재 로그인한 사용자의 암호화된 비밀번호가 맞아 떨어지는지 대조
		Member loginUser = (Member)(session.getAttribute("loginUser"));
		
		if(bCryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			// > 평문과 암호문 비밀번호가 맞아 떨어질 경우 
			
			// 비밀번호 변경 요청 서비스 호출 후 결과 받기
			// > 변경할 비밀번호 또한 암호문 형태로 변경해야한다!!
			String updateEncPwd = bCryptPasswordEncoder.encode(updatePwd);
			
			// 아이디와 변경할 비밀번호의 암호문을 넘기면서 서비스 호출 및 결과 받기
			// > 두 개 이상의 값을 한번에 넘길 경우에는 무조건 VO 등으로 가공해서 한번에 넘긴다!!
			Member m = new Member();
			m.setUserId(userId);
			m.setUserPwd(updateEncPwd);
			
			int result = memberService.updatePwd(m);
			
			// 처리된 결과에 따라 사용자가 보게 될 응답페이지를 지정
			if(result > 0) { 
				// > 비밀번호 변경 성공
				
				// 현재 로그인한 회원의 정보가 조금이라도 변경되었다면 
				// 무조건 그 갱신된 정보를 다시 불러와서 세션에 덮어씌워야함!!
				// > 기존의 로그인용 서비스 재활용하기
				Member updateMem = memberService.loginMember(m);
				
				session.setAttribute("loginUser", updateMem);
				// > 동일한 키값으로 한번 더 추가를 하면 밸류가 덮어씌워짐!!
				
				// 비밀번호가 잘 변경되었음을 1회성 알림 문구로 담아줄 것
				session.setAttribute("alertMsg", "성공적으로 비밀번호가 변경되었습니다.");
				
			} else {
				// > 비밀번호 변경 실패
				
				// 1회성 알림문구를 담기
				session.setAttribute("alertMsg", "비밀번호 변경에 실패했습니다.");
			}
			
		} else {
			// > 평문과 암호문 비밀번호가 맞아 떨어지지 않을 경우
			//   (사용자가 현재 비밀번호를 잘못 입력한 경우)
			
			// 1회성 알림 문구로 잘못입력했다고 알려주기
			session.setAttribute("alertMsg", "잘못된 비밀번호입니다. 다시 입력해주세요.");
		}
		
		// 뭐가 되었든 간에 마이페이지로 url 재요청
		return "redirect:/member/myPage";
	}
	
	@PostMapping("memberDeleteForm") // 회원탈퇴 페이지로 이동
	public String memberDeleteForm(String userPwd, HttpSession session) {
		
        Member loginUser = (Member)(session.getAttribute("loginUser"));
		
		if(bCryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			// > 평문과 암호문 비밀번호가 맞아 떨어질 경우 
			
			session.setAttribute("alertMsg", "비밀번호가 확인되었습니다.");
			
			return "member/memberDeleteForm";
			
		} else {
			// > 평문과 암호문 비밀번호가 맞아 떨어지지 않을 경우
			//   (비밀번호를 잘못 입력한 경우)
			
			// 1회성 알림 문구로 잘못입력했다고 알려주기
			session.setAttribute("alertMsg", "잘못된 비밀번호입니다. 다시 입력해주세요.");
			
			return "redirect:/";
		}
		
	}
	
	@PostMapping("memberDeleteForm/delete")
	public String deleteMember(String userPwd, HttpSession session, Model model) {
		     
		    Member loginUser = (Member)(session.getAttribute("loginUser"));
		    
		    if(bCryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
				// > 평문과 암호문 비밀번호가 맞아 떨어질 경우
				
				// 회원 탈퇴 서비스 요청 후 결과 받기
				int result = memberService.deleteMember(loginUser.getUserId());
				
				// 탈퇴 처리 결과에 따른 응답 페이지 지정
				if(result > 0) { 
					// > 탈퇴 성공
					
					// 로그아웃 처리 후 일회성 알림 문구를 담고 메인페이지로 url 재요청
					session.removeAttribute("loginUser");
					
					session.setAttribute("alertMsg", "성공적으로 회원 탈퇴 처리 되었습니다. 그동안 이용해 주셔서 감사합니다.");
					
					return "redirect:/";
					
				} else {
					// > 탈퇴 실패
					
					// 에러문구를 담아서 에러페이지로 포워딩
					model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
					
					return "common/errorPage";
				}
				
			} else {
				// > 평문과 암호문 비밀번호가 다를 경우
				//   (현재 비밀번호를 잘못 입력한 경우)
				
				// 1회성 알림 문구로 잘못 입력했음을 알려주고, 마이페이지로 url 재요청
				session.setAttribute("alertMsg", "잘못된 비밀번호입니다. 다시 입력해주세요.");
				
				return "redirect:/member/myPage";
			}
		
	}
	
	@PostMapping("searchId")
	public String searchId(String userName, String email) {
		
		Member m = new Member();
		m.setUserName(userName);
		m.setEmail(email);
		
		// Service로 넘기면서 요청 후 결과 받기
		int result = memberService.searchId(m);
		
		if(result > 0) {
			// > 비밀번호가 일치할 경우
			
			
			return "redirect:/";
			
		} else {
			// > 비밀번호가 일치하지않을 경우
			
			
			return "common/errorPage";
		}
		
	}
	
	
	@GetMapping("searchPassword")
	public String searchPassword(String checkId) {
	
		return "";
	}
	
	//-------------------------------------------------------
	@ResponseBody
	@GetMapping("memberEnrollForm/idCheck")
	public String ajaxIdCheck(String checkId) {
		
		// Service로 넘기면서 요청 후 결과 받기
		int count = memberService.idCheck(checkId);
		
		
		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	
	@ResponseBody
	@GetMapping("sendMail")
	public String sendCertNo(String email) {
		
		// 6자리의 랜덤 1회성 인증번호 발급 (100000 ~ 999999)
		// > OTP : One Time Password
		int random = (int)(Math.random() * 900000 + 100000);
		
		// 위의 OTP 를 email 로 전송하기
		// > 단, 그냥 넘기는게 아니라 이따 대조를 위해 어딘가에 OTP 를 저장도 해둬야함!!
		//   Controller 의 전역변수로 OTP 를 저장할 수 있는 Map 을 정의한 뒤 put
		certNoList.put(email, String.valueOf(random));
		
		// > CERT 테이블에 INSERT (EMAIL, CERT_NO, SYSDATE)
		
		// System.out.println(certNoList);
		
		// SimpleMailMessage 로 전송해보기
		SimpleMailMessage message = new SimpleMailMessage();
		
		// 메세지 정보 담기 : 제목, 내용, 받는사람
		message.setSubject("know-how academy 이메일 인증 번호입니다");
		message.setText("인증번호 : " + random);
		message.setTo(email);
		
		mailSender.send(message);
		
		return "인증번호 전송이 완료되었습니다.";
		
	}
	
	@ResponseBody
	@GetMapping("validateMail")
	public String validateCertNo(String email, String checkNo) {
		
		String result = "";
		
		// email 과 checkNo 세트가 certNoList 에 있는지 대조 후 결과에 따른 응답데이터 넘기기
		if((certNoList.get(email) != null) && (certNoList.get(email).equals(checkNo))) {
			// > 인증번호 발급 정보가 있다면
			
			// > CERT 테이블로부터 SELECT 
			//   SELECT * FROM CERT 
			//   WHERE EMAIL 일치, CERT_NO 일치, SYSDATE <= CREATE_DATE + 3분
			// > 3분 이내라면 한개의 행이 조회, 3분 이후라면 EMAIL, CERT_NO 이 일치해도 NULL 조회
			
			result = "success";
			
		} else {
			
			result = "fail";
		}

		// 1회성인 만큼 인증이 성공하든 실패하든 간에 무조건 발급 정보를 삭제해줄 것!!
		certNoList.remove(email);
		
		// > CERT 테이블로부터 DELETE (1회성)
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("newSendMail")
	public String newSendCertNo(String newEmail) {
		
		// 6자리의 랜덤 1회성 인증번호 발급 (100000 ~ 999999)
		// > OTP : One Time Password
		int random = (int)(Math.random() * 900000 + 100000);
		
		// 위의 OTP 를 email 로 전송하기
		// > 단, 그냥 넘기는게 아니라 이따 대조를 위해 어딘가에 OTP 를 저장도 해둬야함!!
		//   Controller 의 전역변수로 OTP 를 저장할 수 있는 Map 을 정의한 뒤 put
		certNoList.put(newEmail, String.valueOf(random));
		
		// > CERT 테이블에 INSERT (EMAIL, CERT_NO, SYSDATE)
		
		// System.out.println(certNoList);
		
		// SimpleMailMessage 로 전송해보기
		SimpleMailMessage message = new SimpleMailMessage();
		
		// 메세지 정보 담기 : 제목, 내용, 받는사람
		message.setSubject("know-how academy 이메일 인증 번호입니다");
		message.setText("인증번호 : " + random);
		message.setTo(newEmail);
		
		mailSender.send(message);
		
		return "인증번호 전송이 완료되었습니다.";
		
	}
	
	@ResponseBody
	@PostMapping("newValidateMail")
	public String newValidateCertNo(String newEmail, String newCheckNo) {
		
		String result = "";
		
		// email 과 checkNo 세트가 certNoList 에 있는지 대조 후 결과에 따른 응답데이터 넘기기
		if((certNoList.get(newEmail) != null) && (certNoList.get(newEmail).equals(newCheckNo))) {
			// > 인증번호 발급 정보가 있다면
			
			// > CERT 테이블로부터 SELECT 
			//   SELECT * FROM CERT 
			//   WHERE EMAIL 일치, CERT_NO 일치, SYSDATE <= CREATE_DATE + 3분
			// > 3분 이내라면 한개의 행이 조회, 3분 이후라면 EMAIL, CERT_NO 이 일치해도 NULL 조회
			
			result = "success";
			
		} else {
			
			result = "fail";
		}

		// 1회성인 만큼 인증이 성공하든 실패하든 간에 무조건 발급 정보를 삭제해줄 것!!
		certNoList.remove(newEmail);
		
		// > CERT 테이블로부터 DELETE (1회성)
		
		return result;
	}
}
