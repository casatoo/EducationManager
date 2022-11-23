package com.KMS.spring.EM.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String comment;
	private int relId;
	private int delStatus;
	
	private String extra__writerName;
}
