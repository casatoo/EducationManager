package com.KMS.spring.EM.controllr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KMS.spring.EM.service.AttrService;
import com.KMS.spring.EM.service.GenFileService;
import com.KMS.spring.EM.service.MemberService;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Attr;
import com.KMS.spring.EM.vo.Member;
import com.KMS.spring.EM.vo.ResultData;
import com.KMS.spring.EM.vo.Rq;

/**
 * 맴버 컨트롤러
 * @author Administrator
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
	
	@Autowired
	private AttrService attrService;
	
	@Autowired
	private GenFileService genFileService;
	
	/**
	 * 회원가입
	 * 아이디 중복 체크 
	 * 이름, 이메일 중복체크
	 * 가입성공 메세지 출력 로그인 페이지로 이동
	 * @param loginId
	 * @param loginPw
	 * @param birthDay
	 * @param name
	 * @param englishName
	 * @param cellphoneNum
	 * @param email
	 * @param model
	 * @param afterLoginUri
	 * @return
	 */
	@RequestMapping("/usr/member/dojoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String birthDay, String name, String englishName,
			String cellphoneNum, String email, Model model, @RequestParam(defaultValue = "/") String afterLoginUri, MultipartRequest multipartRequest) {

		ResultData doJoinRd = memberService.doJoin(loginId, loginPw, birthDay, name, englishName, cellphoneNum, email);

		if (doJoinRd.isFail()) {
			if (doJoinRd.getResultCode().equals("F-1")) {
				return Ut.jsHistoryBack(Ut.f("이미 사용중인 아이디 입니다."));
			}
			if (doJoinRd.getResultCode().equals("F-2")) {
				return Ut.jsHistoryBack(Ut.f("이미 가입된 회원입니다."));
			}
		}
		int newMemberId = (int) doJoinRd.getBody().get("id");
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, newMemberId);
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
			return Ut.jsReplace(resultRd.getMsg(), Ut.f("../member/login?afterLoginUri=%s",afterLoginUri));
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
	/**
	 * 로그아웃
	 * rq에 로그아웃 명령
	 * 로그아웃 후 uri 로 이동
	 * @param afterLogoutUri
	 * @return
	 */
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/")String afterLogoutUri) {
		if(rq.isNotLogined()){
			return Ut.jsReplace(Ut.f("로그인이 필요한 서비스입니다."),Ut.getUriEncoded(afterLogoutUri));
		}
		rq.logout();

		return Ut.jsReplace("로그아웃 되었습니다", afterLogoutUri);
	}
	/**
	 * 로그인 회원정보 조회
	 * @param req
	 * @param model
	 * @return String
	 */
	@RequestMapping("usr/member/userInfo")
	public String memberInfo(HttpServletRequest req, Model model) {
		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		String level = "";
		if(member.getAuthLevel() == 1) {
			level = "관리자";
		}else if(member.getAuthLevel() == 2) {
			level = "직원";
		}else if(member.getAuthLevel() == 3) {
			level = "원생";
		}
		
		model.addAttribute("member",member);
		model.addAttribute("level",level);
		
		return "/usr/member/userInfo";
	}
	/**
	 * 회원 탈퇴
	 * 맴버의 delStatus 를 1로 바꿈
	 * @param id
	 * @return String
	 */
	@RequestMapping("/usr/member/quitMember")
	@ResponseBody
	public String quitMember(int id) {
		
		ResultData rd =  memberService.quitMember(id);
		
		rq.logout();
		
		return Ut.jsReplace(rd.getMsg(), "/");
	}
	
	
	/**
	 * 아이디 찾기
	 * 일치하는 회원이 없을 경우 일치하는 회원이 없다고 출력
	 * 아이디에 생성제한 조건을 최소 4글자 이상으로 주고 뒷 세글자는 ***로 표시
	 * @param name
	 * @param email
	 * @return String
	 */
	@RequestMapping("/usr/member/findLoginId")
	@ResponseBody
	public ResultData findLoginId(String name , String email) {
		
		ResultData rd = memberService.findLoginId(name,email);
		
		return rd;
	}
	/**
	 * 비밀번호 찾기
	 * 이름, 아이디 이메일 검사
	 * 임시비밀번호 서비스로 member 전달.
	 * @param name
	 * @param loginId
	 * @param email
	 * @param accessCode
	 * @return String(afterloginUri)
	 */
	@RequestMapping("/usr/member/findLoginPw")
	@ResponseBody
	public String findLoginPw(String name , String loginId, String email , @RequestParam(defaultValue = "/") String afterLoginUri) {
		
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("일치하는 회원이 없습니다.");
		}
		if (member.getName() == null) {
			return Ut.jsHistoryBack("이름이 일치하지 않습니다.");
		}
		
		if (member.getEmail().equals(email) == false) {
			return Ut.jsHistoryBack("이메일이 일치하지 않습니다.");
		}

		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmailRd(member);

		return Ut.jsReplace(notifyTempLoginPwByEmailRd.getMsg(), Ut.f("../member/login?afterLoginUri=%s",afterLoginUri));
	}
	/**
	 * 인증 코드 생성
	 * @return String
	 */
	@RequestMapping("/usr/member/createAuthKey")
	@ResponseBody
	public String createAuthKey() {
		
		String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());
		
		return memberModifyAuthKey;
	}
	
	/**
	 * 관리자페이지
	 * 회원목록 set
	 * @param model
	 * @return String
	 */
	@RequestMapping("usr/member/memberList")
	public String memberList(
			@RequestParam(defaultValue = "1")Integer page,
			@RequestParam(defaultValue = "")String searchWord,
			@RequestParam(defaultValue = "") String searchFrom,
			Model model) {
		
		int itemsInAPage = 10;
		int limitFrom = (page - 1) * itemsInAPage;
		
		List<Member> memberList = memberService.getMemberList(limitFrom,itemsInAPage, searchWord, searchFrom);
		
		int getTotalMember = memberService.getTotalMember(searchWord, searchFrom);
		int pageCount = (int) Math.ceil((double)getTotalMember/itemsInAPage);
		
		model.addAttribute("memberList",memberList);
		model.addAttribute("searchFrom",searchFrom);
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("getTotalMember",getTotalMember);
		model.addAttribute("page",page);
		model.addAttribute("pageCount",pageCount);
		return "/usr/member/memberList";
	}
	/**
	 * 회원정보 수정
	 * 인증코드 확인
	 * 입력값 존재 확인
	 * 변경 성공, 실패 메세지 출력
	 * @param birthDay
	 * @param name
	 * @param englishName
	 * @param cellphoneNum
	 * @param email
	 * @param memberModifyAuthKey
	 * @param model
	 * @return String
	 */
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String birthDay, String name, String englishName,  String cellphoneNum, String email,String memberModifyAuthKey, MultipartRequest multipartRequest , Model model) {
		
		if(memberModifyAuthKey == null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 생성되지 않았습니다."));
		}
		
		Attr getAttr = attrService.get("member", rq.getLoginedMemberId(), "extra", "memberModifyAuthKey");
		
		if(getAttr==null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 만료되었습니다. 다시 시도해주세요"));
		}
		if(!getAttr.getValue().equals(memberModifyAuthKey)) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 일치하지 않습니다. 다시 시도해주세요"));
		}
		birthDay = birthDay.replaceAll("-","");
		
		if(Ut.empty(birthDay)) {
			return Ut.jsHistoryBack(Ut.f("생년월일을 입력해주세요"));
		}
		if(Ut.empty(cellphoneNum)) {
			return Ut.jsHistoryBack(Ut.f("전화번호를 입력해주세요"));
		}
		if(Ut.empty(englishName)) {
			return Ut.jsHistoryBack(Ut.f("영문이름을 입력해주세요"));
		}
		if(Ut.empty(email)) {
			return Ut.jsHistoryBack(Ut.f("이메일을 입력해주세요"));
		}
		
		ResultData doModifyRd = memberService.doModify( birthDay, name, englishName,cellphoneNum, email, rq.getLoginedMemberId());

		if(doModifyRd.isFail()) {
			if(doModifyRd.getResultCode().equals("F-1")) {
				return Ut.jsHistoryBack(doModifyRd.getMsg());
			}
		}
		Member member = memberService.getMemberById((int) doModifyRd.getData1());
		ResultData resultRd = ResultData.newData(doModifyRd,"member",member);
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, rq.getLoginedMemberId());
			}
		}
		
		return Ut.jsReplace("개인정보 수정완료","../member/userInfo");
	}
	/**
	 * 인증코드 확인
	 * 기존 비밀번호 일치 확인
	 * 비밀번호 수정
	 * @param loginPwCheck
	 * @param loginPw
	 * @param memberPasswordAuthKey
	 * @return String
	 */
	@RequestMapping("/usr/member/doChangePassword")
	@ResponseBody
	public String doChangePassword(String loginPwCheck, String loginPw, String memberPasswordAuthKey) {
		
		if(memberPasswordAuthKey == null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 생성되지 않았습니다."));
		}
		
		Attr getAttr = attrService.get("member", rq.getLoginedMemberId(), "extra", "memberModifyAuthKey");
		
		if(getAttr==null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 만료되었습니다. 다시 시도해주세요"));
		}
		
		if(!getAttr.getValue().equals(memberPasswordAuthKey)) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 일치하지 않습니다.다시 시도해주세요"));
		}
		
		Member member = memberService.getMemberById(rq.getLoginedMemberId());
		
		
		if(!member.getLoginPw().equals(Ut.sha256(loginPwCheck))) {
			return Ut.jsReplace(Ut.f("비밀번호가 틀렸습니다."), "../member/userInfo");
		}
		ResultData doChangePasswordRd = memberService.doChangePassword(member.getId() , loginPw);
		
		return Ut.jsReplace(Ut.f("비밀번호가 수정되었습니다!"), "../member/userInfo");
	}
	/**
	 * 아이디 중복 방지
	 * 비동기 데이터 전송을 위한 코드
	 * @param loginId
	 * @return ResultData
	 */
	@RequestMapping("/usr/member/checkLoginId")
	@ResponseBody
	public ResultData checkLoginId(String loginId) {
		
		ResultData rd = memberService.doCheckLoginId(loginId);
		
		return rd;
	}
	
	@RequestMapping("usr/member/doDeleteMembers")
	@ResponseBody
	public String doDeleteMembers(@RequestParam(defaultValue = "") String ids,
			@RequestParam(defaultValue = "/adm/member/list") String replaceUri) {
		List<Integer> memberIds = new ArrayList<>();

		for (String idStr : ids.split(",")) {
			memberIds.add(Integer.parseInt(idStr));
		}

		memberService.deleteMembers(memberIds);

		return Ut.jsReplace("해당 회원이 삭제되었습니다.", replaceUri);
	}

}
