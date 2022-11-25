<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>
<img src="/resource/main.jpg" class="main-img" />


<div class="educationCourses-box mt-6">
	<div class="flex flex-wrap text-2xl">
		<div class="text-blue-600">최신 교육과정</div>
	</div>
</div>
<div class="educationCourses-box ">
	<div class="flex flex-wrap justify-center">
		<c:if test="${empty educationCourses}">
			<div>진행중인 교육과정이 없습니다.</div>
		</c:if>
		<c:forEach var="educationCourse" items="${educationCourses}">
			<div class="solid-border-box w-60 h-36 rounded-3xl flex m-3">
				<a href="../educationCourse/detail?id=${educationCourse.id}">
					<ul>
						<li class="font-bold m-3 text-2xl">${educationCourse.title}</li>
						<li class="ml-3 mb-3">${educationCourse.startOfEducation}~${educationCourse.endOfEducation}</li>
						<li class="ml-3">담당자:${educationCourse.extra__managerName}</li>
						<li class="float-right">
						<c:if test="${educationCourse.status == 0}">
							<div class="text-blue-600">진행중</div>
						</c:if> 
						<c:if test="${educationCourse.status == 1}">
							<div class="text-red-600">종료됨</div>
						</c:if></li>
					</ul>
				</a>
			</div>
		</c:forEach>
	</div>
</div>
<div class="educationCourses-box mt-6">
	<div class="flex flex-wrap text-2xl">
		<div class="text-blue-600">최신 소식</div>
	</div>
</div>
<div class="educationCourses-box ">
	<div class="flex flex-wrap justify-center">
		<c:if test="${empty articles}">
			<div>게시물이 없습니다.</div>
		</c:if>
		<c:forEach var="article" items="${articles}">
			<div class="solid-border-box w-44 h-60 rounded-3xl flex m-3">
				<a href="${rq.getArticleDetailUriFromArticleList(article)}">
					<ul>
						<li class="font-bold m-3 text-2xl">${article.title}</li>
						<li class="ml-3 h-32">${article.body}</li>
						<li class="ml-3">작성자:${article.extra__writerName}</li>
						<li class="ml-3"><div class="">${article.regDate.substring(5,16)}</div></li>
					</ul>
				</a>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>