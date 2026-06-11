package com.kh.know_how.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.know_how.admin.interceptor.AdminInterceptor;
import com.kh.know_how.common.intercepter.CounselorInterceptor;
import com.kh.know_how.common.intercepter.LoginIntercepter;



@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
    
	@Autowired
	private LoginIntercepter loginInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	@Autowired
	private CounselorInterceptor counselorInterceptor;
	
	
	public void addInterceptors(InterceptorRegistry registry) {
		// 계정별 유무 직급체크후 접속할 url 판단
				// ....
		
		// 회원용 
		registry.addInterceptor(loginInterceptor)
		        .addPathPatterns("/myPage/myInformationSelectForm")
		        .addPathPatterns("/myPage/myInformationChangeForm")
		        .addPathPatterns("/myPage/checkPasswordForm")
		        .addPathPatterns("/myPage/memberDeleteForm");
		        
		// 직원용
		registry.addInterceptor(counselorInterceptor)
		        .addPathPatterns("/myPageCounselor")
		        .addPathPatterns("/myPageCounselor/counselorInformationSelectForm")
		        .addPathPatterns("/myPageCounselor/counselorInformationChangeForm")
		        .addPathPatterns("/myPageCounselor/myStudentClassList")
				//상담사회원가입용페이지 예외처리
				.excludePathPatterns(
		                "/myPageCounselor/counselor/signup",
		                "/myPageCounselor/counselor/signup/**");
		
		
		
		//관리자페이지 인터셉터와 연결되는 곳
		registry.addInterceptor(adminInterceptor)
        .addPathPatterns("/admin/**")
        .excludePathPatterns(
                "/admin/loginForm", 
                "/admin/login",
                "/admin/logout",
                "/resources/**",
                "/css/**",
                "/js/**",
                "/image/**"
        );
       
	}
	
	
}

