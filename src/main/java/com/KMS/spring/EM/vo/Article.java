package com.KMS.spring.EM.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String title;
	private String body;
	private int boardId;
	private int hit;
	private int delStatus;
	private int goodReactionPoint;
	private int badReactionPoint;

	private String extra__writerName;
}
