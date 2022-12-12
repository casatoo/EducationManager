package com.KMS.spring.EM.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.KMS.spring.EM.service.MemberService;
import com.KMS.spring.EM.utill.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode=ScopedProxyMode.TARGET_CLASS)
public class Rq {
	/**
	 * 로그인 여부
	 * @return boolean
	 */
	@Getter
	private boolean isLogined;
	/**
	 * 로그인회원 회원번호
	 * @return int
	 */
	@Getter
	private int loginedMemberId;
	/**
	 * 로그인한 멤버
	 * @return Member
	 */
	@Getter
	private Member loginedMember;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	private Map<String, String> paramMap;
	
	/**
	 * Rq 생성자
	 * 맴버가 로그인, 로그아웃할때 변화
	 * 한번만 생성해서 다른곳에서 사용할 수 있도록 컴포넌트화
	 * @param req
	 * @param resp
	 * @param memberService
	 */
	public Rq(HttpServletRequest req, HttpServletResponse resp,MemberService memberService) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		
		paramMap = Ut.getParamMap(req);
		
		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		
		this.req.setAttribute("rq", this);
	}


/**
 * 메세지 출력하고 뒤로가기
 * @param msg
 */
	public void printHistoryBackJs(String msg) {
		resp.setContentType("text/html; charset=UTF-8");
		println(Ut.jsHistoryBack(msg));
	}
	/**
	 * 메시지 츨력하고 uri로 이동
	 * @param msg
	 * @param replaceUri
	 */
	public void printjsReplace(String msg,String replaceUri) {
		resp.setContentType("text/html; charset=UTF-8");
		println(Ut.jsReplace(msg,replaceUri));
	}
	/**
	 * 받은 문자열을 html 형식으로 만든다.
	 * historyBack, Replace 에서 사용
	 * @param str
	 */
	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 받은 문자열에 줄바꿈해서 print로 전달
	 * @param str
	 */
	public void println(String str) {
		print(str + "\n");
	}
	
	/**
	 * 로그인처리
	 * 세션에 변수 저장 key : member
	 * @param member
	 */
	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}
	/**
	 * 로그인 안했으면 true
	 * @return boolean
	 */
	public boolean isNotLogined() {
		return !isLogined;
	}
	/**
	 * 로그아웃
	 * 세션에서 값 제거 Key
	 */
	public void logout() {
		session.removeAttribute("loginedMemberId");
	}
	
	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}
	
	/**
	 * 현재 uri 와 쿼리 스트링을 연결해서 반환
	 * @return String
	 */
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}
	/**
	 * uri, 쿼리스트링을 받아서 encoding 해서 반환
	 * @return String
	 */
	public String getEncodedCurrentUri() {
		return Ut.getUriEncoded(getCurrentUri());
	}
	
	/**
	 * 로그인페이지로 이동할 때 그 전 주소를 기억
	 * @return String
	 */
	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}
	/**
	 * 회원가입패이지로 이동할 때 주소값 기억
	 * @return String
	 */
	public String getJoinUri() {
		return "../member/join?afterLoginUri=" + getAfterLoginUri();
	}
	/**
	 * 로그아웃 했을 때 글쓰기, 글수정, 내정보 페이지는 "/" 로 반환하고
	 * 아닐경우에는 인코딩된 uri 를 로그아웃 이후 이동하도록 반환
	 * @return String
	 */
	public String getLogoutUri() {
		String requestUri = req.getRequestURI();

		switch (requestUri) {
		case "/usr/member/info":
		case "/usr/member/memberList":
			return "../member/doLogout?afterLogoutUri=" + "/";
		}

		return "../member/doLogout?afterLogoutUri=" + getEncodedCurrentUri();
	}

	/**
	 * 로그인 후 돌아갈 uri
	 * 로그인페이지에서 로그인페이지로 갈 경우 uri 가 중첩되는 현상 방지
	 * login이나 join페이지에서 로그인으로 갈 경우 그 값을 변경하지 않도록함.
	 * @return
	 */
	public String getAfterLoginUri() {
		String requestUri = req.getRequestURI();

		// 로그인 후 다시 돌아가면 안되는 URL
		switch (requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
		case "/usr/member/findLoginId":
		case "/usr/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", ""));
		}

		return getEncodedCurrentUri();
	}
	
	public String getArticleDetailUriFromArticleList(Article article) {
		return "../article/detail?id=" + article.getId() + "&listUri=" + getEncodedCurrentUri();
	}
	public String getArticleWriteUriFromArticleList(int boardId) {
		return "../article/write?listUri=" + getEncodedCurrentUri() + "&boardId="+ boardId;
	}
	public String getProfileImgUri(int membeId) {
		return "/common/genFile/file/member/" + membeId + "/extra/profileImg/1";
	}

	public String getProfileFallbackImgUri() {
		return "https://via.placeholder.com/150/?text=*^_^*";
	}

	public String getProfileFallbackImgOnErrorHtml() {
		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}
}
