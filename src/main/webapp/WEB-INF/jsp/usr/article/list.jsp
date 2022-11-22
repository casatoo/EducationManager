<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="detail" />
<%@ include file="../common/head.jspf"%>
<body>
<div class="text-center text-3xl mt-11">
	<h1>${board.name}게시판</h1>
</div>

<div class="overflow-x-auto mx-40 mt-11 text-center table-box-type-1">
	<div class="h-14 relative ">
		<div class="absolute"><span class="badge">게시글: ${getTotalArticle}개</span></div>
		<div class="relative w-3/5 left-80">
			<form action="../article/list?">
				<input type="hidden" name="boardId" value="${param.boardId}" /> <select
					data-value="${param.searchFrom}" name="searchFrom"
					class="select select-bordered w-fullw-32" required>
					<option disabled selected>검색조건</option>
					<option value="A.title">제목</option>
					<option value="A.body">내용</option>
					<option value="M.name">작성자</option>
				</select> <input type="text" placeholder="검색어를 입력해주세요" name="searchWord"
					class="input input-bordered input-primary w-full w-64"
					value="${param.searchWord}" />
				<button type="submit" class="btn btn-sm ">검색</button>
			</form>
		</div>
	</div>
	<table class=" w-full table-fixed">
		<thead class="bg-black text-white text-xl">
			<tr>
				<th class="w-11">번호</th>
				<th class="w-40">작성일시</th>
				<th class="w-64">제목</th>
				<th class="w-20">작성자</th>
				<th class="w-20">조회수</th>
				<th class="w-40">추천수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="article" items="${articles}">
				<tr class="hover:bg-black transition duration-300 hover:text-white">
					<th>${article.id}</th>
					<td>${article.regDate.substring(5,16)}</td>
					<td onClick="location.href='${rq.getArticleDetailUriFromArticleList(article)}'" style="cursor: pointer;">${article.title}</td>
					<td>${article.extra__writerName}</td>
					<td>${article.hit}</td>
					<td><span class="badge"><i
							class="fa-solid fa-thumbs-up"></i>&nbsp;&nbsp;${article.goodReactionPoint}</span>&nbsp;<span
						class="badge"><i class="fa-solid fa-thumbs-down"></i>&nbsp;&nbsp;${article.badReactionPoint}</span></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="flex justify-center mb-11">
		<div class="mt-4 btn-group">
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
				<button class="btn btn-sm"
					onclick="location.href='../article/list${pageBaseUri}&page=1';">1</button>
			</c:if>
			<c:if test="${startPage > 2}">
				<button class="btn btn-sm">...</button>
			</c:if>
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<button class="btn btn-sm ${page == pageNum ? 'btn-active' : '' }"
					onclick="location.href='../article/list${pageBaseUri}&page=${pageNum}';">${pageNum}</button>
			</c:forEach>
			<c:if test="${endPage < pageCount-1}">
				<button class="btn btn-sm">...</button>
			</c:if>
			<c:if test="${endPage < pageCount}">
				<button class="btn btn-sm"
					onclick="location.href='../article/list${pageBaseUri}&page=${pageCount}';">${pageCount}</button>
			</c:if>
		</div>
	</div>
</div>
</body>
</html>