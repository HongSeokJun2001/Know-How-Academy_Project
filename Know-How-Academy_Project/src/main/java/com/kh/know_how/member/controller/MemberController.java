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

import com.kh.know_how.common.template.XssDefencePolicy;
import com.kh.know_how.member.model.service.MemberService;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.member.model.vo.MemberLock;

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
		
		// XSS 공격 방지
		String replaceUserId
			= XssDefencePolicy.defence(m.getUserId());
		
		String replaceUserPwd
			= XssDefencePolicy.defence(m.getUserPwd());
		
		// 치환된 결과를 각 필드로
		m.setUserId(replaceUserId);
		m.setUserPwd(replaceUserPwd);
		
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
				//   아이디값을 갖고 있던 "쿠키" 를 삭제
				Cookie cookie = new Cookie("saveId", m.getUserId());
				cookie.setMaxAge(0);
				cookie.setPath("/know-how/");
				
				response.addCookie(cookie);
			}
			
			// 암호화 작업
			// Service 요청 후 결과 받기
			
			
			// [1.로그인관련] 멤버테이블 '재직/재학'중인 멤버 조회
			Member loginUser = memberService.loginMember(m.getUserId());
			// 암호화 작업 후 비밀알아내기
			if(loginUser == null) {
				session.setAttribute("alertMsg", "아이디가 존재하지 않습니다.");
					
				return "redirect:/myPage";
			}
			if(loginUser.getStatus().equals("PENDING")) {
				session.setAttribute("alertMsg", "가입승인 대기중입니다.");
				
				return "redirect:/";
			} else if(loginUser.getStatus().equals("REJECTED")) {
				session.setAttribute("alertMsg", "가입이 거절되어있습니다.");
				
				return "redirect:/";
			} else if(loginUser.getStatus().equals("INACTIVE")) {
				session.setAttribute("alertMsg", "이미 탈퇴한 계정입니다.");
				
				return "redirect:/";
			} 
			String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
			System.out.println("암호문 : " + encPwd);
			
			// [결과 확인용 로그]
			System.out.println("Member 테이블에 존재하는 회원여부 : " + loginUser);
			
			// [2.계정락관련] 조회 성공시 계정락 테이블 조회
			// 해당 유저의 계정락 테이블 조회 : 계정장금시 IS_LOCKED 상태값 'Y' 아닐경우 'N'
			MemberLock loginUserLock = memberService.loginLockMember(loginUser.getUserNo());
			// 계정락된 사람의 결과 (loginUserLock 이 null 이면 청정유저)

			//-----첫번째 if 문시작
			if(loginUserLock != null && "Y".equals(loginUserLock.getIsLocked())) {
				
				// 계정이 잠겨있을때
				// 에러 문구를 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "로그인5회이상실패로 계정이 잠겼습니다."
						               + "관리자에게문의하세요.");
				// [결과 확인용 로그]
				System.out.println("계정락 케이스");
				
				return "redirect:/";
				
			} else if((loginUser != null) &&
					   (bCryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd()))){
				
				
				// > 로그인 성공일 경우
				// [결과 확인용 로그]
				System.out.println("로그인성공케이스");
				
				// 로그인한 회원의 정보를 마찬가지로 session 에 담아야함!! (loginUser 키값으로)
				session.setAttribute("loginUser", loginUser);
				
				// 실패횟수 초기화 (청정유저 제외)
				int result = 1;
				if(loginUserLock != null) {
					result = memberService.resetFailCount(loginUserLock);
				}
				// 초기화 성공시 화면으로 리턴
				if(result>0) {
					String roleCode = loginUser.getRoleCode();
					
					if("STUDENT".equals(roleCode)) {
						// 세션에 1회성 알림 문구를 담아 메인페이지로 url 재요청
						session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
						
						return "redirect:/myPage";
					} else if("COUNSELOR".equals(roleCode)) {
						// 세션에 1회성 알림 문구를 담아 메인페이지로 url 재요청
						session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
						
						return "redirect:/myPageCounselor";
					} else if("INSTRUCTOR".equals(roleCode)) {
						// 세션에 1회성 알림 문구를 담아 메인페이지로 url 재요청
						session.setAttribute("alertMsg", "성공적으로 로그인이 되었습니다.");
						
						return "redirect:/myPageCounselor";
					} else {
						// > 관리자 계정일때
						session.setAttribute("alertMsg", "관리자계정입니다.관리자페이지로 이동하세요.");
						session.removeAttribute("loginUser");
						return "redirect:/";
					}
					
				} else {
					// result == 0, 초기화 update 문 오류
					session.setAttribute("alertMsg", "서버가 혼잡합니다. 잠시 후 다시 시도해주세요.");
					
					return "redirect:/myPage";
				}
				
			} else {
				// 비밀번호 오류가 몇번 있는 회원
				if(loginUserLock == null) {
					int num = memberService.insertMemberLock(loginUser.getUserNo());
					if(num > 0) {
						loginUserLock = memberService.loginLockMember(loginUser.getUserNo());
					} else {
						session.setAttribute("alertMsg", "계정 잠금 기능이 없는 아이디입니다. 관리자에게 문의하세요.");
						return "redirect:/";
					}
					
				}
				int failCount = loginUserLock.getFailCount();
				
				failCount += 1;
				loginUserLock.setFailCount(failCount);
				int result = memberService.increaseFailCount(loginUserLock);
				// 에러 문구를 담아서 에러페이지로 포워딩
				if(result > 0) {
					session.setAttribute("alertMsg", "로그인에실패했습니다. (" + failCount + "/ 5 실패횟수)");

					if(failCount >= 5) {

						result = memberService.lockAccount(loginUserLock.getUserNo());
						session.setAttribute("alertMsg", "계정이 잠겼습니다.");
						
						return "redirect:/myPage";
					} else {
						
						return "redirect:/";
					}
					
				} else {
					session.setAttribute("alertMsg", "로그인 실패 횟수가 기록되지 않습니다. 관리자에게 문의해주세요.");
					
					return "redirect:/myPage";
				}
			} 

		}

				
	
	@GetMapping("logout")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
		session.setAttribute("alertMsg", "로그아웃이 되었습니다.");
		
		return "redirect:/";
	}
	
	@GetMapping("memberEnrollForm") // 회원가입페이지로 이동
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
		        
		   // XSS 공격 방지
			String replaceUserId 
				= XssDefencePolicy.defence(m.getUserId());
			
			String replaceUserPwd 
				= XssDefencePolicy.defence(m.getUserPwd());
			
			String replaceUserName 
			= XssDefencePolicy.defence(m.getUserName());
			
			String replacePhone 
			= XssDefencePolicy.defence(m.getPhone());
			
			String replaceEmail
			= XssDefencePolicy.defence(m.getEmail());
			
			String replaceAddress 
			= XssDefencePolicy.defence(m.getAddress());
			
			// 치환된 결과를 각 필드로 
			m.setUserId(replaceUserId);
			m.setUserPwd(replaceUserPwd);
			m.setUserName(replaceUserName);
			m.setPhone(replacePhone);
			m.setEmail(replaceEmail);
			m.setAddress(replaceAddress);
			
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
				
				return "redirect:/";
			}
	}
	
	@PostMapping("update")
	public String updateMember(Member m,String userId, String userPwd, String userName,
			String phone, String email, String address, HttpSession session) { 
		
		// XSS 공격 방지 
    	userPwd
		= XssDefencePolicy.defence(userPwd);
    
    	userName 
		= XssDefencePolicy.defence(userName);
	
    	phone 
		= XssDefencePolicy.defence(phone);

    	email
		= XssDefencePolicy.defence(email);
    
    	address 
		= XssDefencePolicy.defence(address);
	    
    	String updateEncPwd = bCryptPasswordEncoder.encode(userPwd);
	    // 치환된 결과를 각 필드로 
	 		
    	    m.setUserId(userId);
	 		m.setUserPwd(updateEncPwd);
	 		m.setUserName(userName);
	 		m.setPhone(phone);
	 		m.setEmail(email);
	 		m.setAddress(address);
		
		int result = memberService.updateMember(m);
		
		// 응답페이지 처리
		if(result > 0) {
			// 회원 정보 변경에 성공했을 경우
			
			Member updateMem = memberService.loginMember(m.getUserId());
			
			session.setAttribute("loginUser", updateMem);
			
			session.setAttribute("alertMsg","회원정보가 변경되었습니다.");
			
			return "redirect:/myPage/myInformationChangeForm";
		
		} else {
			// 회원 정보 변경 실패했을 경우
			
			session.setAttribute("errorMsg","회원정보 변경에 실패했습니다.");
			
			return "redirect:/";
		}
		
		
		
	}
	
	@PostMapping("memberDeleteForm") // 회원탈퇴 페이지로 이동
	public String memberDeleteForm(Member m, String userPwd, HttpSession session) {
		// XSS 공격 방지	
		String replaceUserPwd 
			= XssDefencePolicy.defence(m.getUserPwd());
		
		// 치환된 결과를 각 필드로 
		m.setUserPwd(replaceUserPwd);
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
			
			return "redirect:/myPage/checkPasswordForm";
		}
		
	}
	
	@PostMapping("memberDeleteForm/delete")
	public String deleteMember(String userPwd, HttpSession session, Model model) {
		     
		        Member loginUser = (Member)(session.getAttribute("loginUser"));
		    
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
					
					return "redirect:/";
				}
		
	}
	
	@PostMapping("searchId")
	public String searchId(Member m, String userName, String email, HttpSession session) {
		
		// XSS 공격 방지
		String replaceUserName 
		= XssDefencePolicy.defence(m.getUserName());
		
		String replaceEmail
		= XssDefencePolicy.defence(m.getEmail());
	
		// 치환된 결과를 각 필드로 
		m.setUserName(replaceUserName);
		m.setEmail(replaceEmail);
	
		// Service로 넘기면서 요청 후 결과 받기
		Member idSearch = memberService.searchId(m);
		
		if(idSearch != null) {
			// 이름,이메일이 일치할 경우
			
			session.setAttribute("alertMsg", "요청하신 회원님의 아이디는 "
		                         + idSearch.getUserId()
		                         + " 입니다.");
			return "redirect:/myPage/searchIdForm";
			
		} else {
			// 이름,이메일이 일치하지않을 경우
			
			session.setAttribute("alertMsg", "이름,이메일이 일치하지 않습니다.");
			return "redirect:/";
		}
		
	}
	
	@ResponseBody
	@PostMapping("searchPassword")
	public String searchPassword(Member m, String userId, 
			                     String userName, String email, HttpSession session) {
		// XSS 공격 방지
		String replaceUserId 
			= XssDefencePolicy.defence(m.getUserId());
		String replaceUserName
	        = XssDefencePolicy.defence(m.getUserName());
		String replaceEmail
		    = XssDefencePolicy.defence(m.getEmail());
		
		// 치환된 결과를 각 필드로 
		m.setUserId(replaceUserId);
		m.setUserName(replaceUserName);
		m.setEmail(replaceEmail);
		
		// Service로 넘기면서 요청 후 결과 받기
		Member passwordSearch = memberService.searchPassword(m);
		// 시간된다면 이메일로 비밀번호 전송
		
		if(passwordSearch != null) {
			// 이름,이메일이 일치할 경우
			
            if(!"ADMIN".equals(passwordSearch.getRoleCode())) {
    			
    			int random = (int)(Math.random() * 90000000 + 10000000);
    			
    			String encPwd = bCryptPasswordEncoder.encode(String.valueOf(random));
    			passwordSearch.setUserPwd(encPwd);
    			
    			int result = memberService.updateMember(passwordSearch);
    			
    			if(result > 0) {
    				SimpleMailMessage message = new SimpleMailMessage();
        			
        			// 메세지 정보 담기 : 제목, 내용, 받는사람
        			message.setSubject("know-how academy 임시 비밀번호입니다.");
        			message.setText("임시 비밀번호 : " + random + "\n임시 비밀번호로 로그인 후 비밀번호 변경을 권장드립니다.");
        			message.setTo(m.getEmail());
        			
        			System.out.println(random + ", " + encPwd);
        			
        			mailSender.send(message);
        			
        			return m.getUserName() + "님의 이메일에 임시 비밀번호를 보냈습니다.\n로그인 후 비밀번호 변경을 권장드립니다.";
    			} else {
    				return "임시 비밀번호를 보내지 못했습니다.";
    			}
    			
		    } else {
			// 이름,이메일이 일치하지않을 경우
			
			return "관리자 페이지에서 찾아야합니다.";
		}
       } else {
    	// 이름,이메일이 일치하지않을 경우
    	   
			return "아이디,이름,이메일이 일치하지 않습니다.";
       }
		
	}
	//-------------------------------------------------------
	@ResponseBody
	@GetMapping("memberEnrollForm/idCheck")
	public String ajaxIdCheck(String checkId) {
		
		// XSS 공격 방지
		checkId = XssDefencePolicy.defence(checkId);
		
		// Service로 넘기면서 요청 후 결과 받기
		int count = memberService.idCheck(checkId);
		
		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	
	@ResponseBody
	@GetMapping("emailCheck")
	public String ajaxEmailCheck(String checkEmail) {
		
		// XSS 공격 방지
		checkEmail = XssDefencePolicy.defence(checkEmail);
			
		// Service로 넘기면서 요청 후 결과 받기
		int count = memberService.emailCheck(checkEmail);
		
		
		return (count > 0) ? "NNNNN" : "NNNNY";
	}
	
	@ResponseBody
	@GetMapping("sendMail")
	public String sendCertNo(Member m,String email) {
		// XSS 공격 방지
		email= XssDefencePolicy.defence(email);
		
        // 치환된 결과를 각 필드로 
		m.setEmail(email);
		
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
	public String validateCertNo(Member m,String email, String checkNo) {
		
		// XSS 공격 방지
		email
		= XssDefencePolicy.defence(email);
		
		// 치환된 결과를 각 필드로 
		m.setEmail(email);
	
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
	

}
