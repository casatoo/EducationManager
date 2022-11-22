package com.KMS.spring.EM.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KMS.spring.EM.vo.Article;


@Mapper
public interface ReactionRepository {

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			relTypeCode = 'article',
			relId = #{relId},
			`point` = #{point}
				""")
	public int doReaction(int relId, int memberId, int point);

	@Select("""
			SELECT `point` FROM
			reactionPoint WHERE
			relId = #{relId}
			AND memberId = #{memberId};
			""")
	public Integer getReactionResult(int relId, int memberId);

	@Delete("""
			UPDATE reactionPoint SET
			`point` = #{point},
			updateDate = NOW()
			WHERE relId= #{relId}
			AND memberId = #{memberId};
			""")
	public Integer changeReaction(int relId, int memberId, int point);

	@Update("""
			UPDATE article AS A
			INNER JOIN (
				SELECT RP.relTypeCode, RP.relId,
				SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
				SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
				FROM reactionPoint AS RP
				WHERE RP.relId = #{relId}
				GROUP BY RP.relTypeCode, RP.relId
			) AS RP_SUM
			ON A.id = RP_SUM.relId
			SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
			A.badReactionPoint = RP_SUM.badReactionPoint;
						""")
	public void updateReaction(int relId);
	
	@Select("""
			SELECT goodReactionPoint, badReactionPoint FROM
			article WHERE
			id = #{relId}
			""")
	public Article getReactionPoint(int relId);
}
