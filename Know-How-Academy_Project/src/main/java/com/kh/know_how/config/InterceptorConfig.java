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
		        .addPathPatterns("/myPage/memberDeleteForm")
		        .addPathPatterns("/reservation/list")
		        .addPathPatterns("/reservation/counselor/list")
		        .addPathPatterns("/reservation/counselorList");
				
		        
		// 직원용
		registry.addInterceptor(counselorInterceptor)
		        .addPathPatterns("/myPageCounselor")
		        .addPathPatterns("/myPageCounselor/counselorInformationSelectForm")
		        .addPathPatterns("/myPageCounselor/counselorInformationChangeForm")
		        .addPathPatterns("/myPageCounselor/myStudentClassList");
		
		
		
		//관리자페이지 인터셉터와 연결되는 곳
		registry.addInterceptor(adminInterceptor)
        .addPathPatterns("/admin/**")
        .excludePathPatterns(
                "/admin/loginForm",  //*** 로그인관련페이지 생성되면 주소 확인 후 수정하기(-)
                "/admin/login",
                "/admin/logout",
                "/resources/**",
                "/css/**",
                "/js/**",
                "/image/**"
        );
       
	}
	
	
}

