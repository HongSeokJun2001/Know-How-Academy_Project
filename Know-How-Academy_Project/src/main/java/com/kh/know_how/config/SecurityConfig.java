package com.kh.know_how.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SecurityConfig<SecurityFilterChain> {

	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		
		return http.authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
				   .csrf(csrf -> csrf.disable())
				   .build();
	}
}
