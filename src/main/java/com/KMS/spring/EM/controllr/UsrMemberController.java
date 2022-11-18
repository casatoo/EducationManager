package com.KMS.spring.EM.controllr;

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

/**
 * @author Administrator 컨트롤러 어노테이션 써주기
 */
@Controller
public class UsrMemberController {
	
	/**
	 * 멤버서비스 객체
	 */
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/usr/member/dojoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email,@RequestParam(defaultValue = "/") String afterLoginUri ,Model model) {

		ResultData doJoinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

		if(doJoinRd.isFail()) {
			if(doJoinRd.getResultCode().equals("F-1")) {
				return Ut.jsHistoryBack(Ut.f("이미 사용중인 아이디 입니다."));
			}
			if(doJoinRd.getResultCode().equals("F-2")) {
				return Ut.jsHistoryBack(Ut.f("이미 가입된 회원입니다."));
			}
		}
		Member member = memberService.getMember((int) doJoinRd.getData1());
		resultRd = ResultData.newData(doJoinRd,"member",member);
		return Ut.jsReplace(Ut.f("회원가입 성공!"),Ut.f("../member/login?afterLoginUri=%s",Ut.getUriEncoded(afterLoginUri)));
	}

	
}
