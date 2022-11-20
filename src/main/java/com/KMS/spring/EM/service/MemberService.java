package com.KMS.spring.EM.service;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	public MemberService(MemberRepository memberRepository) {
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
		String existsLoginPw = memberRepository.getLoginPwByLoginId(loginId);
		
		if(!existsLoginPw.equals(loginPw)) {
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
	 * @param loginMemberId
	 * @return
	 */
	public String genMemberModifyAuthKey(int loginMemberId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);


		return memberModifyAuthKey;
	}
	
}
