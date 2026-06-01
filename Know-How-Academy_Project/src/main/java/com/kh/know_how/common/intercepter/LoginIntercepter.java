package com.kh.know_how.common.intercepter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
@Component
public class LoginIntercepter implements HandlerInterceptor {
    
	// 1. preHandle 메소드 (선처리용)
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, 
			                  Object handler) throws Exception {
		     
		     HttpSession session = request.getSession();
				
			// session 으로 부터 로그인한 회원의 정보를 꺼내오기
			Member loginUser = (Member)session.getAttribute("loginUser");
				
			//  로그인 여부 
			if(loginUser != null) {
				// > 로그인이 된 상황
					
			   return true; // 로그인된 사용자만 접속 가능하도록 true
					
			} else {
				// > 로그인이 안된 상황
					
				session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
					
				response.sendRedirect("/know-how");
					
				return false; // 로그인하지 않은 사용자는 요청 접속 차단 
			}
				
	}
	
	
}
*/
