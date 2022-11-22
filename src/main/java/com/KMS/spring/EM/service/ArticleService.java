package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.ArticleRepository;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Article;
import com.KMS.spring.EM.vo.ResultData;


@Service
public class ArticleService {
	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	public Article getForPrintArticle(int actorId, int id) {
		Article article = articleRepository.getForPrintArticle(id);
		updateForPrintData(actorId, article);
		return article;
	}

	private void updateForPrintData(int actorId, Article article) {
		if (article == null) {
			return;
		}

		ResultData actorCanDeleteRd = actorCanDelete(actorId, article);
		article.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());

	}
	
	public int getTotalArticle(int boardId ,String searchItem,String searchFrom) {
		return articleRepository.getTotalArticle(boardId, searchItem, searchFrom);
	}

	public List<Article> getForPrintArticles(int actorId, int boardId, int limitFrom, int itemsInAPage, String searchWord, String searchFrom) {
		List<Article> articles = articleRepository.getArticles(boardId,limitFrom,itemsInAPage, searchWord, searchFrom);
		
		for (Article article : articles) {
			updateForPrintData(actorId, article);
		}
		
		return articles;
	}

	public ResultData<Integer> writeArticle(int memberId, String title, String body, int boardId) {
		articleRepository.writeArticle(memberId, title, body, boardId);
		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다", id), "id", id);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);

		Article article = getForPrintArticle(0, id);

		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정했습니다", id), "article", article);
	}

	public ResultData actorCanDelete(int actorId, Article article) {

		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다");
		}

		if (article.getMemberId() != actorId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다");
		}

		return ResultData.from("S-1", "삭제 가능");
	}
	public ResultData<Integer> increseHit(int id) {
		int incresedHitRd = articleRepository.increseHit(id);
		if (incresedHitRd == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다", "addHitRd", incresedHitRd);
		}
		return ResultData.from("S-1", "게시물 조회수 증가", "addHitRd", incresedHitRd);
	}
	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}
	
	
	

}
