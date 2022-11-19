package com.KMS.spring.EM.repository;

import org.apache.ibatis.annotations.Mapper;

import com.KMS.spring.EM.vo.Member;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String birthDay, String name, String englishName, String cellphoneNum, String email);

	public Member getMemberById(int id);

	public Member getMemberByNameAndEmail(String name, String email);
	
	public Member getMemberByLoginId(String loginId);

	public int getLastInsertId();


}