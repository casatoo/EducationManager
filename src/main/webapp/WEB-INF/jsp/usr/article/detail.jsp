<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="detail" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<%@ include file="../common/toastUi.jspf"%>
<%-- 전역변수 설정 --%>
<script>
	var reaction = ${reactionRd};
	const params = {};
	params.id = parseInt('${param.id}');
	const isLogined = ${rq.isLogined()};
</script>

<%-- 
댓글작성 제한사항 설정 스크립트 
작성된 벨류값을 가져와서 조건에 맞는지 확인하는 함수
--%>
<script>
	let CommentWrite__submitFormDone = false;
	
	function CommentWrite__submitForm(form){
		
		if(CommentWrite__submitFormDone){
			return;
		}
		form.comment.value = form.comment.value.trim();
		
		if (form.comment.value.length < 2) {
			alert('2글자 이상 입력해주세요');
			form.comment.focus();
			return;
		}
		
		CommentWrite__submitFormDone = true;
		form.submit();
	}
</script>

<%-- 
조회수 증가 비동기 통신 스크립트
get함수를 사용해서 컨트롤러와 맵핑된 주소로 연결
id 값을 파라미터로 값을 주고
받아온 데이터값(data)를 제이쿼리로 찾은 클래스요소 안에 empty로 비우고 html로 데이터를 넣는다.
실행은 2000ms 뒤에 실행
--%>
<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		localStorage.setItem(localStorageKey, true);
		$.get('../article/incresedHit', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit').empty().html(data.data1);
		}, 'json');
	}
	$(function() {
		// 실전코드
		//ArticleDetail__increaseHitCount();
		// 연습코드
		setTimeout(ArticleDetail__increaseHitCount, 2000);
	})
</script>

<%-- 
좋아요 버튼 클릭 작동 스크립트 
로그인했을때만 작동할 수있도록 경고창을 설정
파라미터값으로 게시물 id와 추천의 경우 point 를 1로 설정
받아온 데이터는 총 3가지로 로그인한 사람의 리엑션 결과, 좋아요 총 갯수, 싫어요 총 갯수 이다.
최초 상태에서 로그인한 사람의 리엑션 결과가 전역변수로 설정되어 좋아요 버튼을 눌렀을때
싫어요, 또는 아무리엑션이 없을 경우 좋아요가 될수 있도록 전역변수 변경
좋아요 상태에서 다시 좋아요 버튼을 눌렀을 때는 취소이기 때문에 전역변수를 0으로 설정
리엑션 상태에 따른 표시를 위해 설정한 함수를 실행시키는것으로 끝
--%>
<script>
const ArticleDetail__goodReactionPoint = () =>{
	if(!isLogined){
		loginAlert();
		return;
	}
	$.get('../reaction/doReaction',{
		relId : ${article.id},
		point : 1,
		ajaxMode : 'Y'
	}, function(data){
		$('.article-detail__goodReaction').empty().html(data.data2);
		$('.article-detail__badReaction').empty().html(data.data3);
		if(reaction == -1 || reaction == 0){
			reaction = 1;
		}else if(reaction == 1 ){
			reaction = 0;
		}
		reactionPick();
	}, 'json');
}
</script>

<%-- 
싫어요 버튼 클릭 작동 스크립트 
좋아요 버튼 클릭과 동일한 작동 방법
세부 조건만 조금 변경하였다.
--%>
<script>
const ArticleDetail__badReactionPoint = () =>{
	if(!isLogined){
		loginAlert();
		return;
	}
	$.get('../reaction/doReaction',{
		relId : ${article.id},
		point : -1,
		ajaxMode : 'Y'
	}, function(data){
		$('.article-detail__goodReaction').empty().html(data.data2);
		$('.article-detail__badReaction').empty().html(data.data3);
		if(reaction == 1 || reaction == 0){
			reaction = -1;
		}else if(reaction == -1 ){
			reaction = 0;
		}
		reactionPick();
	}, 'json');
}
</script>

<%-- 리엑션 결과에 따른 버튼 모양 변화 --%>
<script>
	const reactionPick = () =>{
		if(reaction == 1){
			$(".goodReaction").css("color","red");
			$(".badReaction").css("color","black");
		}else if(reaction == -1){
			$(".goodReaction").css("color","black");
			$(".badReaction").css("color","red");
		}else if(reaction == 0){
			$(".goodReaction").css("color","black");
			$(".badReaction").css("color","black");
		}
	}
	$(function() {
	reactionPick();
	})
</script>

<%-- 로그인 경고 --%>

<script>
const loginAlert = () => {
	alert("로그인해주세요");
}
</script>
<div class="article-detail-box">
	<div class="article-detail-status-box">
		<div class="article-detail-status-content">
			<div class="article-detail-status-img-box">
				<img src="${rq.getProfileImgUri(article.memberId)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt=""/>
			</div>
			<div class="article-detail-status-content-info">
				<div class="article-detail-status-content-title">
					<div>${article.title}</div>
				</div>
				<div class="article-detail-status-content-writer">
					<div>${article.extra__writerName}</div>
				</div>
				<div class="article-detail-status-content-attr">
					<div class="article-detail-status-content-attr-item">
						글번호:&nbsp;&nbsp;
						<div>${article.id}</div>
					</div>
					<div class="article-detail-status-content-attr-item">
						글 작성일:&nbsp;&nbsp;
						<div>${article.regDate}</div>
					</div>
					<div class="article-detail-status-content-attr-item">
						글 수정일:&nbsp;&nbsp;
						<div>${article.updateDate}</div>
					</div>
					<div class="article-detail-status-content-attr-item">
						조회수:&nbsp;&nbsp;
						<div class="article-detail__hit">${article.hit}</div>
					</div>
				</div>
				<div class="article-detail-status-reaction-box">
					<div>
						<button class="goodReaction"
							onclick="ArticleDetail__goodReactionPoint()">
							좋아요<i class="fa-solid fa-thumbs-up"></i>&nbsp;&nbsp;<span
								class="article-detail__goodReaction">${article.goodReactionPoint}</span>
						</button>
					</div>
					<div>
						<button class="badReaction"
							onclick="ArticleDetail__badReactionPoint()">
							싫어요<i class="fa-solid fa-thumbs-down"></i>&nbsp;&nbsp;<span
								class="article-detail__badReaction">${article.badReactionPoint}</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="toast-ui-viewer">
		<script type="text/x-template">${setBody}</script>
	</div>
</div>
<div class="article-detail-btn-box">
<button onclick="location.href='${param.listUri }'"><i class="fa-solid fa-rotate-left"></i>&nbsp;&nbsp;뒤로가기</button>
<c:if test="${rq.loginedMemberId eq article.memberId}">
	<button
		onclick="location.href='../article/modify?id=${article.id }&listUri=${listUri}';"><i class="fa-solid fa-screwdriver-wrench"></i>&nbsp;&nbsp;수정</button>
	<button
		onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false; location.href='../article/doDelete?id=${article.id }&boardId=${article.boardId}';"><i class="fa-solid fa-trash"></i>&nbsp;&nbsp;삭제</button>
</c:if>
</div>
<%@ include file="../article/comment.jspf"%>
<%@ include file="../common/foot.jspf"%>

