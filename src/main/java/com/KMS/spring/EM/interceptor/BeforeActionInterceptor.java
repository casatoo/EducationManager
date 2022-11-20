package com.KMS.spring.EM.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.KMS.spring.EM.vo.Rq;


@Component
public class BeforeActionInterceptor implements HandlerInterceptor {
	private Rq rq;
	/**
	 * 생성자
	 * @param rq
	 */
	public BeforeActionInterceptor(Rq rq) {
		this.rq = rq;
	}
	/**
	 * 시작 전에 작동하는 인터셉터
	 * rq 셋
	 */
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		
		req.setAttribute("rq", rq);
		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}
