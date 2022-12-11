package com.KMS.spring.EM.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import com.KMS.spring.EM.vo.Member;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String birthDay, String name, String englishName, String cellphoneNum, String email);

	public Member getMemberById(int id);

	public Member getMemberByNameAndEmail(String name, String email);
	
	public Member getMemberByLoginId(String loginId);

	public int getLastInsertId();
	
	public String getLoginPwByLoginId(String loginId);

	public void quitMember(int id);

	public List<Member> getMemberList(int limitFrom,int itemsInAPage,String searchWord,String searchFrom);
	
	public void doModify(String birthDay, String englishName ,String cellphoneNum, String email, int memberId);
	
	public void doChangePassword(int memberId, String loginPw);
	
	public int matchLoginId(String loginId);

	public int getTotalMember(String searchWord, String searchFrom);

	public void deleteMember(int id);
	
}