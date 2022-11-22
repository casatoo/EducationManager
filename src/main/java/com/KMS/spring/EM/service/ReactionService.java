package com.KMS.spring.EM.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.ReactionRepository;
import com.KMS.spring.EM.vo.Article;
import com.KMS.spring.EM.vo.ResultData;


@Service
public class ReactionService {
	@Autowired
	private ReactionRepository reactionRepository;
	
	public ResultData<Integer> doReaction(int relId, int memberId, int point){
		int reactionPointRd = reactionRepository.doReaction(relId,memberId,point);
		if(point == -1) {
			return ResultData.from("S-1", "싫어요", "reactionPointRd", reactionPointRd);
		}
		return ResultData.from("S-2", "좋아요", "reactionPointRd", reactionPointRd);
	}
	
	public ResultData<Integer> getReactionResult(int relId, int memberId){
		return ResultData.from("S-1", "리엑션조회성공", "reactionPointRd", reactionRepository.getReactionResult(relId, memberId));
	}

	public ResultData<Integer> changeReaction(int relId, int memberId, int point) {
		
		if(point == -1) {
			return ResultData.from("S-1", "싫어요", "reactionPointRd",reactionRepository.changeReaction(relId, memberId, point));
		}
		return ResultData.from("S-2", "좋아요", "reactionPointRd",reactionRepository.changeReaction(relId, memberId, point));
	}

	public void updateReaction(int relId) {
		reactionRepository.updateReaction(relId);
	}
	
	public Article getReactionPoint(int relId) {
		return reactionRepository.getReactionPoint(relId);
	}

}
