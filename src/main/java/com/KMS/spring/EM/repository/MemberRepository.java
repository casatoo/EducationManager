package com.KMS.spring.EM.repository;

import org.apache.ibatis.annotations.Mapper;

import com.KMS.spring.EM.vo.Member;

@Mapper
public interface MemberRepository {

	public void Join(String loginId, String loginPw, String birthDay, String name, String englishName, String cellphoneNum, String email);

	public Member getMemberById(int id);

	public Member getMemberByNameAndEmail(String name, String email);
	
	public Member getMemberByLoginId(String loginId);

	public int getLastInsertId();
	
	public int matchLoginId(String loginId);
	
	public String getLoginPw(String loginId);
	
	public void doModify(String nickname, String cellphoneNum, String email, int memberId);

	public void doChangePassword(int memberId, String loginPw);

}