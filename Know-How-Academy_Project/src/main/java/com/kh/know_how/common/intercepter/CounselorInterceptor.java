package com.kh.know_how.common.intercepter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CounselorInterceptor implements HandlerInterceptor{
    
    
	// 1. preHandle 메소드 (선처리용)
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, 
			                  Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		// 세션이 없거나 로그인 정보가 없으면 차단
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/myPage");
            return false;
        }

        // 로그인 유저 정보 꺼내기 (Member 객체로 형변환)
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 상담사(counselor) 권한 검사
        if (!"COUNSELOR".equals(loginUser.getRoleCode()) && !"INSTRUCTOR".equals(loginUser.getRoleCode())) {
        	// redirect 후 보여줄 메시지
            request.getSession().setAttribute("alertMsg", "직원계정 로그인 후 이용 가능한 서비스입니다.");
           
            response.sendRedirect(request.getContextPath() + "/myPage");//****컨트롤러매핑에맞춰수정필요(-)
            return false;
        }
	
	    return true; // 직원이라면 통과
}	    
		
					
  }
