<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="detail" />
<%@ include file="../common/head.jspf"%>
<body>
	<div>과정 상세보기</div>
		<div>과정번호: ${educationCourse.id}</div>
		<div>과정명: ${educationCourse.title}</div>
		<div>과정등록일: ${educationCourse.regDate.substring(0,10)}</div>
		<div>교육시작일: ${educationCourse.startOfEducation.substring(0,10)}</div>
		<div>교육죵료일: ${educationCourse.endOfEducation.substring(0,10)}</div>
		<div>교육장소: ${educationCourse.place}</div>
		<div>담당자: ${educationCourse.extra__managerName}</div>
		<div>현재상태: ${educationCourse.status}</div>
</body>
</html>