package com.KMS.spring.EM.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KMS.spring.EM.vo.Article;


@Mapper
public interface ArticleRepository {

	public void writeArticle(int memberId, String title, String body, int boardId);

	public Article getForPrintArticle(int id);

	public List<Article> getArticles(int boardId, int limitFrom, int itemsInAPage, String searchWord, String searchFrom);
	
	public int getTotalArticle(int boardId, String searchWord,String searchFrom);

	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);

	public int getLastInsertId();
	
	public int increseHit(int id);
	
	public int getArticleHitCount(int id);
	
	public int increseGoodReactionPoint(int relId, int point);
	
	public int increseBadReactionPoint(int relId, int point);
}