package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.CommentRepository;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Comment;
import com.KMS.spring.EM.vo.ResultData;


@Service
public class CommentService {
	
	@Autowired
	private CommentRepository commentRepository;

	public List<Comment> getForPrintComments(int id) {
		List<Comment> comments = commentRepository.getComments(id);
		
		return comments;
	}

	public ResultData doWrite(int id, int memberId ,String comment, String relTypeCode) {
		
		commentRepository.doWrite(id,memberId,comment, relTypeCode);
		
		return ResultData.from("S-1", Ut.f("댓글 작성 성공"));
	}

	public ResultData doDelete(int id) {
		
		int deleteRd = commentRepository.doDelete(id);
		
		return ResultData.from("S-1", "삭제성공", "deleteRd", deleteRd);
	}

	public ResultData doModify(int id, String comment) {
		
		int modifyRd = commentRepository.doModify(id,comment);
		
		return ResultData.from("S-1", "수정성공", "modifyRd", modifyRd);
	}
	
}
