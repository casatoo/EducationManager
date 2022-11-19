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
	
	public ResultData<Integer> doJoin(String loginId, String loginPw, String birthDay, String name, String englishName, String cellphoneNum, String email) {
		/**
		 * 맴버 생성
		 * 라스트생성 아이디 가져옴 반환함
		 */
		Member existsMember  = memberRepository.getMemberByLoginId(loginId);
		
		if(existsMember != null) {
			return ResultData.from("F-1",Ut.f("이미 사용중인 아이디 %s 입니다.",loginId));
		}
		existsMember = memberRepository.getMemberByNameAndEmail(name, email);
		
		if(existsMember != null) {
			return ResultData.from("F-2",Ut.f("이미 가입된 회원입니다. %s, %s",name, email));
		}
		memberRepository.Join(loginId, loginPw, birthDay, name, englishName, cellphoneNum, email);
		
		return ResultData.from("S-1","회원가입 성공");
	}
	
	
	
}
