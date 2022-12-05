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
public class registeInfo {
	private int id;
	private String regDate;
	private String updateDate;
	private int courseId;
	private int memberId;
	private int status;
	
	private String extra__managerName;
	private String start;
	private String end;
}
