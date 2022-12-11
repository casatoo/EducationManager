package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.MemberRepository;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Member;
import com.KMS.spring.EM.vo.ResultData;

/**
 * 
 * @author Administrator
 * 서비스 어노테이션 추가
 */
@Service
public class MemberService {

/**
 * 리포지토리에 연결해야되니까 인스턴스 객체 만들기
 */
	@Autowired
	public MemberRepository memberRepository;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	@Autowired
	private AttrService attrService;
	
	private MailService mailService;

	public MemberService( MailService mailService,AttrService attrService, MemberRepository memberRepository) {
		this.mailService = mailService;
		this.attrService = attrService;
		this.memberRepository = memberRepository;
	}

	/**
	 * 회원가입
	 * @param loginId
	 * @param loginPw
	 * @param birthDay
	 * @param name
	 * @param englishName
	 * @param cellphoneNum
	 * @param email
	 * @return
	 */
	public ResultData doJoin(String loginId, String loginPw, String birthDay, String name, String englishName, String cellphoneNum, String email) {
	
		Member existsMember  = memberRepository.getMemberByLoginId(loginId);
		
		if(existsMember != null) {
			return ResultData.from("F-1",Ut.f("이미 사용중인 아이디 %s 입니다.",loginId));
		}
		existsMember = memberRepository.getMemberByNameAndEmail(name, email);
		
		if(existsMember != null) {
			return ResultData.from("F-2",Ut.f("이미 가입된 회원입니다. %s, %s",name, email));
		}
		
		loginPw = Ut.sha256(loginPw);
		memberRepository.doJoin(loginId, loginPw, birthDay, name, englishName, cellphoneNum, email);
		
		return ResultData.from("S-1","회원가입 성공");
	}
	/**
	 * 회원번호로 Member 검색
	 * @param id
	 * @return Member
	 */
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	/**
	 * 로그인 아이디로 Member 검색
	 * @param loginId
	 * @return
	 */
	public Member getMemberByLoginId(String loginId) {
		return  memberRepository.getMemberByLoginId(loginId);
	}
	
	/**
	 * 아이디 체크
	 * 탈퇴여부 체크
	 * 비밀번호 체크
	 * 후 로그인
	 * @param loginId
	 * @param loginPw
	 * @return ResultData
	 */
	public ResultData<Integer> doLogin(String loginId, String loginPw) {
		
		Member existsMember = memberRepository.getMemberByLoginId(loginId);
		
		if(existsMember == null) {
			return ResultData.from("F-4",Ut.f("아이디가 틀렸습니다."));
		}
		if(existsMember.getDelStatus() == 1) {
			return ResultData.from("F-5",Ut.f("탈퇴한 회원입니다."));
		}
		
		if(!existsMember.getLoginPw().equals(Ut.sha256(loginPw))) {
			return ResultData.from("F-6",Ut.f("비밀번호가 틀렸습니다."));
		}
		return ResultData.from("S-1",Ut.f("로그인 성공"));
		
	}
	
	/**
	 * 회원번호 가져와서 실행
	 * 
	 * @param id
	 */
	public ResultData quitMember(int id) {
		memberRepository.quitMember(id);
		return ResultData.from("S-1","탈퇴 성공");
	}
	/**
	 * 아이디 찾기
	 * 일치 회원 검색
	 * member가 null 이면 일치회원 없음
	 * 있으면 loginId 를 반환
	 * @param name
	 * @param email
	 * @return
	 */
	public ResultData findLoginId(String name, String email) {
		Member existsMember = memberRepository.getMemberByNameAndEmail(name, email);
		if(existsMember == null) {
			return ResultData.from("F-1",Ut.f("일치하는 회원이 없습니다."));
		}
		return ResultData.from("S-1","아이디 조회 성공","loginId",existsMember.getLoginId());
	}
	/**
	 * 10자리 인증코드 생성
	 * attrService에 값 생성
	 * @param loginMemberId
	 * @return String
	 */
	public String genMemberModifyAuthKey(int loginMemberId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);

		attrService.setValue("member", loginMemberId, "extra", "memberModifyAuthKey", memberModifyAuthKey,
				Ut.getDateStrLater(60 * 5));

		return memberModifyAuthKey;
	}
	/**
	 *  memberlist 가져오기
	 * @return List<Member>
	 */
	public List<Member> getMemberList(int limitFrom,int itemsInAPage,String searchWord,String searchFrom) {
		
		return memberRepository.getMemberList(limitFrom,itemsInAPage,searchWord,searchFrom);
	}
	
	/**
	 * 맴버 객체 actor 받음
	 * 전역변수 사이트 이름, 주소 설정
	 * utill.getTempPassword에서 무작위 난수6자리 받음
	 * 이메일 내용 작성
	 * 메일서비스.send로 메일 전송하고 ResultData 받음
	 * 메일 발송 실패 메세지일 경우 결과값 그냥 리턴
	 * 임시 비밀번호로 비밀번호 변경
	 * @param actor
	 * @return ResultData(성공메세지,코드)
	 */
	public ResultData notifyTempLoginPwByEmailRd(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData;
		}

		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
	}
	
	/**
	 * 맴버와 임시비밀번호 받아서 해당 맴버의 비밀번호 임시비밀번호로 변경
	 * @param actor
	 * @param tempPassword
	 */
	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.doChangePassword(actor.getId(), Ut.sha256(tempPassword));
	}
	
	/**
	 * 개인정보 수정
	 * 
	 * @param name
	 * @param nickname
	 * @param cellphoneNum
	 * @param email
	 * @param memberId
	 * @return ResultData(memberId)
	 */
	public ResultData doModify(String birthDay, String name, String englishName, String cellphoneNum, String email, int memberId) {

		Member existsMember = memberRepository.getMemberByNameAndEmail(name, email);
		if(existsMember != null) {
			return ResultData.from("F-1",Ut.f("중복된 회원 정보입니다. %s, %s",name, email));
		}
		memberRepository.doModify(birthDay, englishName, cellphoneNum, email, memberId);
		return ResultData.from("S-1","회원정보 수정 성공","memberId",memberId);
	}
	
	/**
	 * 비밀번호 변경
	 * @param memberId
	 * @param loginPw
	 * @return ResultData
	 */
	public ResultData doChangePassword(int memberId ,String loginPw) {
		
		memberRepository.doChangePassword(memberId,Ut.sha256(loginPw));
		
		return ResultData.from("S-1","비밀번호 수정 성공");
	}
	/**
	 * 
	 * @param loginId
	 * @return ResultData
	 */
	public ResultData<String> doCheckLoginId(String loginId) {
		int matchLoginId = memberRepository.matchLoginId(loginId);
		
		if(matchLoginId == 1) {
			return ResultData.from("F-1",Ut.f("이미 사용중인 아이디 입니다."));
		}
		return ResultData.from("S-1",Ut.f("사용가능한 아이디 입니다."));
	}

	public int getTotalMember(String searchWord, String searchFrom) {
		return memberRepository.getTotalMember(searchWord,searchFrom);
	}
	
}
