package com.KMS.spring.EM.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.KMS.spring.EM.interceptor.BeforeActionInterceptor;
import com.KMS.spring.EM.interceptor.NeedAdnimistratorInterceptor;
import com.KMS.spring.EM.interceptor.NeedLoginInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// BeforeActionInterceptor 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	// NeedLoginInterceptor 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	@Autowired
	NeedAdnimistratorInterceptor needAdnimistratorInterceptor;
	
	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/gen/**").addResourceLocations("file:///" + genFileDirPath + "/")
				.setCachePeriod(20);
	}
	
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
			.addPathPatterns("/usr/member/quitMember")
			.addPathPatterns("/usr/member/memberList")
			.addPathPatterns("/usr/article/doAdd")
			.addPathPatterns("/usr/article/write")
			.addPathPatterns("/usr/article/modify")
			.addPathPatterns("/usr/article/doModify")
			.addPathPatterns("/usr/article/doDelete")			
			.addPathPatterns("/usr/reaction/doReaction")
			.addPathPatterns("/usr/comment/doAdd")
			.addPathPatterns("/usr/comment/doDelete")
			.addPathPatterns("/usr/comment/doModify")
			.addPathPatterns("/usr/educationCourse/eduStatus")
			.addPathPatterns("/usr/educationCourse/doModify")
			.addPathPatterns("/usr/educationCourse/create");
			
		ir = registry.addInterceptor(needAdnimistratorInterceptor)
			.addPathPatterns("/usr/member/memberList")
			.addPathPatterns("/usr/educationCourse/doModify")
			.addPathPatterns("/usr/educationCourse/create");
		
		}

}
