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
	
	/*  ------------------------------로그인 전처리 --> 로그인페이지 생성되면 되살리기(-)
	// 1. 전처리: 관리자 권한 체크
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        
        
        // 세션이 없거나 로그인 정보가 없으면 차단
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login"); //****컨트롤러매핑에맞춰수정필요(-)
            return false;
        }

        // 로그인 유저 정보 꺼내기 (Member 객체로 형변환)
        Member loginUser = (Member) session.getAttribute("loginUser");
		
        // 관리자(admin) 권한 검사
        if (!"admin".equals(loginUser.getRoleCode())) {
        	// redirect 후 보여줄 메시지
            request.getSession().setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
            // 리다이렉트할 페이지 지정
            //http://localhost:8002/know_how -> request.getContextPath() 값은 /know_how
            response.sendRedirect(request.getContextPath() + "/admin/login");//****컨트롤러매핑에맞춰수정필요(-)
            return false;
        }

        return true; // 관리자라면 통과
    }
    
    ----------------------------------------------------------------------------- */
	
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