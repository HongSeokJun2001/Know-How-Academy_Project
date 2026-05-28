package com.kh.know_how.common.intercepter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

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
		        // 1. 우선 session 객체 부터 얻어내기 (request 객체로부터)
				HttpSession session = request.getSession();
				
				// 2. session 으로 부터 로그인한 회원의 정보를 꺼내오기
				Member loginUser = (Member)session.getAttribute("loginUser");
				
				// 3. 로그인 여부 판별
				if(loginUser != null) {
					// > 로그인이 된 상황
					
					return true; // 로그인된 사용자만 접속 가능하도록 true
					
				} else {
					// > 로그인이 안된 상황
					
					// 이왕이면 1회성 알림 문구를 담아서 메인페이지로 url 재요청까지 하고싶음!!
					// (안그러면 흰 화면이 나오기 때문)
					
					session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
					
					response.sendRedirect("/know-how");
					// > 오버라이딩된 메소드라 문자열 타입으로 리턴이 불가!!
					//   그래서 response 객체에서 제공하는 sendRedirect 메소드를 통해서 url 재요청을 진행
					
					return false; // 로그인하지 않은 사용자는 요청 접속 차단 false
				}
				
	}
}
