package com.KMS.spring.EM.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 
 * @author Administrator
 * 데이타 어노테이션 생성
 * 생성자 No, All 붙이기
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String startOfEducation;
	private String endOfEducation;
	private String loginId;
	private String loginPw;
	private String birthDay;	
	private int authLevel;
	private String name;
	private String englishName;
	private String nickname;
	private String cellphoneNum;
	private String email;
	private String subject;	
	private int delStatus;
	private String delDate;
}
