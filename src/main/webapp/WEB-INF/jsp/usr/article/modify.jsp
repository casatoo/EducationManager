<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="detail" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>

<div>
		<div>${article.id}번글수정</div>
		<c:set var="article" value="${article}" />
		<form action="../article/doModify">
				<div>
						<input type="hidden" id="id" name="id" value="${article.id}" /> 
						<input type="hidden" id="body" name="body" />
						<input type="hidden" id="listUri" name="listUri" value="${listUri}"/>
				</div>
				<div>
						<label for="title">글 제목</label> <input type="text" id="title" name="title" size="30" value="${article.title}" />
				</div>
				<div class="mt-11">
						<label for="body">글 내용</label>
						<textarea name="body" id="body" cols="30" rows="10">${article.body}</textarea>
				</div>
				<button type="submit">글 수정</button>
		</form>
</div>
</body>
</html>