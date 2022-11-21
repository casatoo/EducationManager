<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<body>
	<div>메인 페이지</div>
	<div>
		<a href="${rq.joinUri}"><span>회원가입</span></a> <a href="${rq.loginUri}"><span>로그인</span></a>
		<a href="${rq.logoutUri}"><span>로그아웃</span></a> <a
			href="../member/userInfo"><span>내 정보</span></a> <a
			href="../member/administrator"><span>관리자 페이지</span></a>
	</div>
	<c:if test="${empty educationCourses}">
		<div>진행중인 교육과정이 없습니다.</div>
	</c:if>
	<c:forEach var="educationCourse" items="${educationCourses}">
		<div class="educationCourse">
			<a href="../educationCourse/detail?id=${educationCourse.id}">
				<div>과정명: ${educationCourse.title}</div>
				<div>교육시작일: ${educationCourse.startOfEducation}</div>
				<div>교육장소: ${educationCourse.place}</div>
				<div>담당자: ${educationCourse.extra__managerName}</div>
			</a>
		</div>
	</c:forEach>
</body>
</html>