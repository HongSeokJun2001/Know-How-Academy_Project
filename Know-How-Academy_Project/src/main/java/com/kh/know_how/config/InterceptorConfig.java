package com.kh.know_how.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.know_how.admin.model.service.AdminService;
import com.kh.know_how.common.intercepter.LoginIntercepter;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
    
	@Autowired
	private LoginIntercepter loginInterceptor;
	
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(loginInterceptor)
		        .addPathPatterns("/member/myPage");
		
		// 계정별 유무 직급체크후 접속할 url 판단
		// ....
	}
	
	public void adminInterceptors() {
		AdminService as; as.selectAlarmCount();
	}
}
