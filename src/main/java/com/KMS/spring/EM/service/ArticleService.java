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

	/**
	 * 생성자
	 * @param articleRepository
	 */
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}

	/**
	 * 글 번호로 게시글 조회
	 * @param id
	 * @return Article
	 */
	public Article getForPrintArticle(int id) {
		Article article = articleRepository.getForPrintArticle(id);
		
		return article;
	}

	/**
	 * 검색 조건에 해당되는 전체 글 갯수 조회
	 * @param boardId
	 * @param searchItem
	 * @param searchFrom
	 * @return int 해당하는 글 갯수
	 */
	public int getTotalArticle(int boardId ,String searchItem,String searchFrom) {
		return articleRepository.getTotalArticle(boardId, searchItem, searchFrom);
	}
	/**
	 * 조건에 해당하는 글 목록 조회
	 * @param actorId
	 * @param boardId
	 * @param limitFrom
	 * @param itemsInAPage
	 * @param searchWord
	 * @param searchFrom
	 * @return List<Article> 게시글 리스트
	 */
	public List<Article> getForPrintArticles(int actorId, int boardId, int limitFrom, int itemsInAPage, String searchWord, String searchFrom) {
		List<Article> articles = articleRepository.getArticles(boardId,limitFrom,itemsInAPage, searchWord, searchFrom);
		
		return articles;
	}
	
	/**
	 * 글 작성
	 * @param memberId
	 * @param title
	 * @param body
	 * @param boardId
	 * @return ResultData<Integer> 글 작성 결과
	 */
	public ResultData<Integer> writeArticle(int memberId, String title, String body, int boardId) {
		articleRepository.writeArticle(memberId, title, body, boardId);
		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다", id), "id", id);
	}
	
	/**
	 * 글 삭제
	 * @param id
	 */
	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}
	
	/**
	 * 글 수정
	 * @param id
	 * @param title
	 * @param body
	 * @return ResultData<Article> 수정된 게시글
	 */
	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);

		Article article = getForPrintArticle(id);

		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정했습니다", id), "article", article);
	}
	
	/**
	 * 조회수 증가
	 * 게시글 존재 여부 확인
	 * @param id
	 * @return ResultData<Integer> 조회수증가 성공, 실패
	 */
	public ResultData<Integer> increseHit(int id) {
		int incresedHitRd = articleRepository.increseHit(id);
		if (incresedHitRd == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다", "addHitRd", incresedHitRd);
		}
		return ResultData.from("S-1", "게시물 조회수 증가", "addHitRd", incresedHitRd);
	}
	
	/**
	 * 조회수 조회
	 * @param id
	 * @return int 조회수
	 */
	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}
	
	
	

}
