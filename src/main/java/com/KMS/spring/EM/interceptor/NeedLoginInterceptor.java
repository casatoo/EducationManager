package com.KMS.spring.EM.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Rq;


@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	
	@Autowired
	private Rq rq;

	/**
	 * 로그인이 필요한 서비스에 로그인이 되지않았을때 로그인 페이지로 이동시킴
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		
		String afterUrl = req.getRequestURI();
		String params = req.getQueryString();
		
		afterUrl += "?"+params;
		if (!rq.isLogined()) {
//			resp.getWriter().append("<script>")...

			rq.printjsReplace("로그인 후 이용해주세요",Ut.f("../member/login?afterUrl=%s", afterUrl));
			
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}
