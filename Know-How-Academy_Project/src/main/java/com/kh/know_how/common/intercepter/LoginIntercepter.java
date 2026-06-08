package com.kh.know_how.common.intercepter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.member.model.dao.MemberDao;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Component
public class LoginIntercepter implements HandlerInterceptor {
    

	// 1. preHandle 메소드 (선처리용)
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, 
			                  Object handler) throws Exception {
		     
		    HttpSession session = request.getSession();
				
		    // session 으로 부터 로그인한 회원의 정보를 꺼내오기
		    Member loginUser = (Member)session.getAttribute("loginUser");
			
	        // 세션이 없거나 로그인 정보가 없으면 차단
	        if (session == null || session.getAttribute("loginUser") == null) {
	            response.sendRedirect(request.getContextPath() + "/myPage");
	            return false;
	        }
	        
	        // 회원/학생(student) 권한 검사
	        if (!"STUDENT".equals(loginUser.getRoleCode())) {
	        	// redirect 후 보여줄 메시지
	            request.getSession().setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
	           
	            response.sendRedirect(request.getContextPath() + "/myPage");
	            return false;
	        }

	        return true; // 학생이라면 통과
	}
	        
			
}
	
	

