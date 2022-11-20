package com.KMS.spring.EM.controllr;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KMS.spring.EM.service.MemberService;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Member;
import com.KMS.spring.EM.vo.ResultData;
import com.KMS.spring.EM.vo.Rq;

/**
 * @author Administrator 컨트롤러 어노테이션 써주기
 */
@Controller
public class UsrMemberController {

	/**
	 * memberService 호출
	 */
	@Autowired
	MemberService memberService;
	/**
	 * rq 호출
	 */
	@Autowired
	Rq rq;
	
	
	@RequestMapping("/usr/member/dojoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String birthDay, String name, String englishName,
			String cellphoneNum, String email, Model model, @RequestParam(defaultValue = "/") String afterLoginUri) {

		ResultData doJoinRd = memberService.doJoin(loginId, loginPw, birthDay, name, englishName, cellphoneNum, email);

		if (doJoinRd.isFail()) {
			if (doJoinRd.getResultCode().equals("F-1")) {
				return Ut.jsHistoryBack(Ut.f("이미 사용중인 아이디 입니다."));
			}
			if (doJoinRd.getResultCode().equals("F-2")) {
				return Ut.jsHistoryBack(Ut.f("이미 가입된 회원입니다."));
			}
		}
		return Ut.jsReplace(Ut.f("회원가입 성공!"),
				Ut.f("../member/login?afterLoginUri=%s", Ut.getUriEncoded(afterLoginUri)));
	}

	@RequestMapping("/usr/member/join")
	public String joinForm(HttpServletRequest req, Model model, String afterLoginUri) {
		model.addAttribute("afterLoginUri", afterLoginUri);
		return "/usr/member/join";
	}
	
	/**
	 * 중복로그인 체크
	 * 아이디 입력 체크
	 * 비밀번호 입력 체크
	 * 로그인 성공하면  이름 검색해서 메세지 출력
	 * rq에 로그인 정보 전달
	 * @param loginId
	 * @param loginPw
	 * @param afterLoginUri
	 * @return String
	 */
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw,@RequestParam(defaultValue = "/")String afterLoginUri) {
		
		if(rq.isLogined()){
			return Ut.jsReplace(Ut.f("이미 로그인중입니다"),Ut.getUriEncoded(afterLoginUri));
		}
		if(Ut.empty(loginId)) {
			return Ut.jsHistoryBack(Ut.f("아이디를 입력해주세요"));
		}
		if(Ut.empty(loginPw)) {
			return Ut.jsHistoryBack(Ut.f("비밀번호를 입력해주세요"));
		}
		ResultData doLoginRd= memberService.doLogin(loginId,loginPw);
		
		if(doLoginRd.isFail()) {
			ResultData resultRd = ResultData.from(doLoginRd.getResultCode(),doLoginRd.getMsg());
			return Ut.jsReplace(resultRd.getMsg(), "../member/login");
		}
		Member member = memberService.getMemberByLoginId(loginId);
		rq.login(member);
		
		return Ut.jsReplace(Ut.f("%s 회원님 환영합니다.",member.getName()),afterLoginUri);
	}
	
	@RequestMapping("/usr/member/login")
	public String loginForm(String afterLoginUri, HttpServletRequest req, Model model) {
		
		model.addAttribute("afterLoginUri",afterLoginUri);
		return "/usr/member/login";
	}

}
