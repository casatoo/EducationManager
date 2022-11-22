<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="detail" />
<%@ include file="../common/head.jspf"%>
<body>
<script>
	let ArticleModify__submitDone = false;
	function ArticleModify__submit(form) {
		if (ArticleModify__submitDone) {
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용을 입력해주세요');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		ArticleModify__submitDone = true;

		form.submit();
	}
	
</script>

<div class="mt-11 ml-11">
		<div class="text-4xl mb-11 ml-11">${article.id}번글수정</div>
		<c:set var="article" value="${article}" />
		<form action="../article/doModify" onsubmit="ArticleModify__submit(this); return false;">
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
						<div class="toast-ui-editor">
						
								<script type="text/x-template">${article.body}</script>
						</div>
				</div>
				<button class="mt-11 btn btn-outline" type="submit">글 수정</button>
		</form>
</div>
</body>
</html>