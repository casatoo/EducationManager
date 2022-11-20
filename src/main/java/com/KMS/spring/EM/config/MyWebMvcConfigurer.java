package com.KMS.spring.EM.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.KMS.spring.EM.interceptor.BeforeActionInterceptor;
import com.KMS.spring.EM.interceptor.NeedLoginInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// BeforeActionInterceptor 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	// NeedLoginInterceptor 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	// /resource/common.css
	// 인터셉터 적용
	public void addInterceptors(InterceptorRegistry registry) {
		
		InterceptorRegistration ir;
		
		ir = registry.addInterceptor(beforeActionInterceptor)
			.addPathPatterns("/**")
			.addPathPatterns("/favicon.ico")
			.excludePathPatterns("/resource/**")
			.excludePathPatterns("/error");
		
		ir = registry.addInterceptor(needLoginInterceptor)
			.addPathPatterns("/usr/member/doLogout")
			.addPathPatterns("/usr/member/userInfo")
			.addPathPatterns("/usr/member/doModify")
			.addPathPatterns("/usr/member/quitMember");
	}

}
