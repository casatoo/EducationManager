package com.KMS.spring.EM.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KMS.spring.EM.vo.Comment;


@Mapper
public interface CommentRepository {

	@Select("""
			SELECT C.*, M.name AS
			extra__writerName
			FROM `comment` AS C
			INNER JOIN
			`member` AS M
			ON C.memberId
			= M.id
			WHERE C.relId = #{relId}
			AND C.delStatus = 0
			ORDER BY C.id ASC;
						""")
	public List<Comment> getComments(int relId);

	@Insert("""
			INSERT INTO `comment`
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			relId = #{relId},
			relTypeCode = #{relTypeCode},
			`comment` = #{comment}
				""")
	public int doWrite(int relId, int memberId, String comment, String relTypeCode);

	@Delete("""
			UPDATE comment SET 
			delStatus = 1 
			WHERE id = #{id}
			""")
	public int doDelete(int id);
	@Update("""
			<script>
			UPDATE `comment`
			<set>
				<if test="comment != null and comment != ''">`comment` = #{comment},</if>
			updateDate = NOW()
			</set>
				WHERE id = #{id}
			</script>
			""")

	public int doModify(int id, String comment);
}
