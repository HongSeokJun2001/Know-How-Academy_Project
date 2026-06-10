package com.kh.know_how.admin.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.service.AdminService;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	// [필드부]
	@Autowired
	private AdminService as;

	// [메소드부]
	

	// 1. 전처리: 관리자 권한 체크
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        // Ajax 확인변수 셋팅
        String ajaxHeader = request.getHeader("X-Requested-With");
    	boolean isAjax = "XMLHttpRequest".equals(ajaxHeader); 
    	// 접근하려던 주소(URI) 가져오기
    	String requestURI = request.getRequestURI();
    	
    	// [상황 1] 세션이 없거나 로그인 정보가 없으면 차단  
	    if (session == null || session.getAttribute("loginUser") == null) {
	    
	    	 // [로그 기록] 
        	System.out.println(" [Unauthorized] 세션 만료/미로그인 접근 - URI: " + requestURI + ", Ajax여부: " + isAjax);
        
	    
	        if (isAjax) {
	            // Ajax 요청이면 401 Unauthorized (인증 실패) --> 요청한 Ajax의 error 함수로 진입
	            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Ajax request unauthorized");
	        } else {
	            // 일반 요청이면 로그인 페이지로 리다이렉트
	            response.sendRedirect(request.getContextPath() + "/admin/loginForm");//****컨트롤러매핑에맞춰수정필요(-)
	        }
	        return false;
	    }

        // 로그인 유저 정보 꺼내기 (Member 객체로 형변환)
        Member loginUser = (Member) session.getAttribute("loginUser");
		
        // [상황 2] 관리자(admin) 권한 검사
        if (!"ADMIN".equals(loginUser.getRoleCode())) { 
        	
        	System.out.println(" [Forbidden] 관리자 권한 없는 유저 접근 시도 - 유저번호: " + loginUser.getUserNo() + ", URI: " + requestURI);
			
        	if (isAjax) {
            // Ajax 요청인데 관리자가 아니면 403 Forbidden (인가/권한 실패)
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ajax request forbidden");
        	} else {
        	// 일반 요청일경우 로그인 페이지로 연결
            request.getSession().setAttribute("alertMsg", "관리자 권한이 필요합니다. 로그인 후 다시 시도해주세요.");
            response.sendRedirect(request.getContextPath() + "/admin/loginForm");//****컨트롤러매핑에맞춰수정필요(-)
            //http://localhost:8002/know_how -> request.getContextPath() 값은 /know_how
            }
            
            return false;
        }

        return true; // 로그인한 관리자라면 통과
    }
    
	
    // 2. 후처리: 알람
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		// Model과 View가 존재하고 리다이렉트가 아닐 때만 실행
		if (modelAndView != null && modelAndView.getViewName() != null && !modelAndView.getViewName().startsWith("redirect:")) {
            
			// 1. DB로부터 알림 숫자를 조회
			int alarmCount = as.selectAlarmCount();
			
			// 2. ModelAndView에 저장
			modelAndView.addObject("alarmCount", alarmCount);
		}
	}
}