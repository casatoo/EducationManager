<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="modify"/>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<%@ include file="../common/toastUi.jspf"%>

<script>
	let submitWriteFormDone = false;
	function submitWriteForm(form) {
		if (submitWriteFormDone) {
			alert('처리중입니다');
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		// find(찾는 엘리먼트).data(불러오는 데이터의 key 값)
		// find 가 제이쿼리이기 때문에 $로 가져와야함.
		const markdown = editor.getMarkdown().trim();
		// 폼 테그 안에 에디터 안에 데이터토스트에디터의 value 값을 마크다운으로 가져온다.
		if (markdown.length == 0) {
			alert('내용을 입력해주세요');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		form.submit();

		submitWrtieFormDone = true;
	}
</script>

<script>
	const editor = new toastui.Editor({
		el : document.querySelector('#editor'),
		height : '500px',
		initialValue : content,
		initialEditType : 'wysiwyg'
	});
</script>
<c:set var="article" value="${article}" />
<div class="article-write-box">
	<form onsubmit="submitWriteForm(this); return false;" action="../article/doModify">
		<input type="hidden" id="id" name="id" value="${article.id}" /> 
		<input type="hidden" id="body" name="body" />
		<input type="hidden" id="listUri" name="listUri" value="${listUri}"/>
		<div class="article-write-title-box">
			<input type="text" id="title" name="title" size="30"  value="${article.title}" />
		</div>
		<div class="article-write-body-box">
			<div class="toast-ui-editor">
				<script type="text/x-template">${article.body}</script>
			</div>
		</div>
		<div class="article-write-submit-btn"><button type="submit">글 작성</button></div>
	</form>
</div>

<%@ include file="../common/foot.jspf"%>