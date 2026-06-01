package com.kh.know_how.admin.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.service.AdminService;
// Member 클래스가 있는 올바른 패키지 경로를 임포트해줘야 해 (예시)
// import com.kh.know_how.member.model.vo.Member; 
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	// [필드부] @Autowired를 붙여주면 스프링이 AdminService 객체를 자동으로 주입(new)해줘!
	@Autowired
	private AdminService as;

	// [메소드부]
	
	// 1. 전처리: 관리자 전용 페이지 접근 권한 체크
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        // 세션이 없거나 로그인 정보가 없으면 차단
        if (session == null || session.getAttribute("loginUser") == null) {
            // 프로젝트 환경에 맞는 로그인 페이지 경로로 수정해줘 (예: request.getContextPath() + "/login.me")
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // 로그인 유저 정보 꺼내기 (Member 객체로 형변환)
        // ※ 이 부분에서 Member 클래스에 빨간줄이 뜨면 마우스를 대고 import를 수동으로 해줘야 해!
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 관리자(admin) 권한 검사 (getRoleCode() 메서드가 있다고 가정)
        if (!"admin".equals(loginUser.getRoleCode())) {
        	// redirect 후 보여줄 메시지가 필요하면 새 세션을 만들어 저장
            request.getSession().setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
            // 리다이렉트할 페이지 지정
            //http://localhost:8002/know_how -> request.getContextPath() 값은 /know_how
            response.sendRedirect(request.getContextPath() + "/admin/login");//****컨트롤러매핑에맞춰수정필요(-)
            return false;
        }

        return true; // 관리자라면 무사 통과!
    }
    
    
    // 2. 후처리: 컨트롤러 실행 후, 레이아웃에 뿌릴 신규가입자(알림) 숫자 심어주기
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		// 화면을 보여주는 정상적인 요청(Model과 View가 존재하고 리다이렉트가 아닐 때)만 실행
		if (modelAndView != null && modelAndView.getViewName() != null && !modelAndView.getViewName().startsWith("redirect:")) {
            
			// 1. 필드에 있는 AdminService(as)를 사용해서 DB로부터 알림 숫자를 조회한다!
			int alarmCount = as.selectAlarmCount();
			
			// 2. 레이아웃에서 사용할 수 있도록 ModelAndView에 "alarmCount"라는 이름으로 담아준다!
			modelAndView.addObject("alarmCount", alarmCount);
		}
	}
}