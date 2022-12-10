<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="articleListPage" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<div class="article-list-box">
	<div class="article-list-boardName">${board.name} 게시판</div>
	<div class="search-box">
		<div>
			<span class="article-badge">게시글: ${getTotalArticle}개</span>
		</div>
		<div>
			<form action="../article/list?">
				<input type="hidden" name="boardId" value="${param.boardId}" /> <select
					class="input-article-select rounded-lg"
					data-value="${param.searchFrom}" name="searchFrom" required>
					<option disabled selected>검색조건</option>
					<option value="A.title">제목</option>
					<option value="A.body">내용</option>
					<option value="M.name">작성자</option>
				</select> <input class="input-article-search rounded-lg" type="text"
					placeholder="검색어를 입력해주세요" name="searchWord"
					value="${param.searchWord}" />
				<div class="article-list-search-btn">
					<button type="submit">검색</button>
				</div>
			</form>
		</div>
	</div>
	<table class="article-list-table">
		<colgroupo>
		<col width="5%">
		<col width="20%">
		<col width="30%">
		<col width="20%">
		<col width="10%">
		<col width="15%">
		</colgroupo>
		<thead class="article-list-thead">
			<tr>
				<th>번호</th>
				<th>작성일시</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>추천</th>
			</tr>
		</thead>
		<tbody class="article-list-tbody">
			<c:forEach var="article" items="${articles}">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate.substring(5,16)}</td>
					<td
						onClick="location.href='${rq.getArticleDetailUriFromArticleList(article)}'"
						style="cursor: pointer;">${article.title}</td>
					<td>${article.extra__writerName}</td>
					<td>${article.hit}</td>
					<td><span class="article-badge"><i
							class="fa-solid fa-thumbs-up"></i>&nbsp;&nbsp;${article.goodReactionPoint}</span>&nbsp;<span
						class="article-badge"><i class="fa-solid fa-thumbs-down"></i>&nbsp;&nbsp;${article.badReactionPoint}</span></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${rq.isLogined()}">
	<div class="article-write-btn">
		<button type="button" onClick="location.href='${rq.getArticleWriteUriFromArticleList()}'">
			<i class="uil uil-edit"></i> <span class="link-name">글 작성</span>
		</button>
	</div>
	</c:if>
	<div class="flex justify-center mb-11">

		<div class="mt-4">
			<c:set var="pageMenuLen" value="4" />
			<c:set var="startPage"
				value="${page-pageMenuLen >=1 ? page-pageMenuLen : 1}" />
			<c:set var="endPage"
				value="${page + pageMenuLen <= pageCount ? page + pageMenuLen : pageCount}" />
			<c:set var="pageBaseUri" value="?boardId=${boardId}" />
			<c:set var="pageBaseUri"
				value="${pageBaseUri}&searchWord=${param.searchWord}" />
			<c:set var="pageBaseUri"
				value="${pageBaseUri}&searchFrom=${param.searchFrom}" />

			<c:if test="${startPage > 1}">
				<button class="page-move-btn"
					onclick="location.href='../article/list${pageBaseUri}&page=1';">1</button>
			</c:if>
			<c:if test="${startPage > 2}">
				<button class="page-move-btn page-move-btn-not-active">...</button>
			</c:if>
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<button
					class="page-move-btn ${page == pageNum ? 'page-move-btn-active' : '' }"
					onclick="location.href='../article/list${pageBaseUri}&page=${pageNum}';">${pageNum}</button>
			</c:forEach>
			<c:if test="${endPage < pageCount-1}">
				<button class="page-move-btn page-move-btn-not-active">...</button>
			</c:if>
			<c:if test="${endPage < pageCount}">
				<button class="page-move-btn"
					onclick="location.href='../article/list${pageBaseUri}&page=${pageCount}';">${pageCount}</button>
			</c:if>
		</div>

	</div>

</div>
<%@ include file="../common/foot.jspf"%>