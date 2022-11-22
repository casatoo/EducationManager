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

	public List<Member> getMemberList(String name);
	
	public void doModify(String birthDay, String englishName ,String cellphoneNum, String email, int memberId);
	
	public void doChangePassword(int memberId, String loginPw);
	
	@Update("""
			<script>
			UPDATE `member`
			<set>
				updateDate = NOW(),
				<if test="loginPw != null">
					loginPw = #{loginPw},
				</if>
				<if test="name != null">
					name = #{name},
				</if>
				<if test="nickname != null">
					nickname = #{nickname},
				</if>
				<if test="cellphoneNum != null">
					cellphoneNum = #{cellphoneNum},
				</if>
				<if test="email != null">
					email = #{email}
				</if>
			</set>
			WHERE id = #{id};
			</script>
				""")
	void modify(int id, String loginPw, String name, String nickname, String cellphoneNum, String email);
}