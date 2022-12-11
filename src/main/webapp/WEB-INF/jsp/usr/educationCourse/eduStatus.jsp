<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="eduStatus" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<div class="edu-status">
	<div class="edu-status-nav-box">
		<div class="edu-status-nav-item">수강중인 교육 리스트</div>
	</div>
	<c:forEach var="myeduStatus" items="${myeduStatus}">
		<form action="../educationCourse/doDelete">
			<input type="hidden" name="educationCourseId" id="educationCourseId" value="${myeduStatus.courseId}" />
			<div class="edu-status-card"
				onclick="location.href='../educationCourse/detail?id=${myeduStatus.courseId}';">
				<div>
					<div class="edu-status-title">${myeduStatus.title}</div>
					<div class="edu-status-date">교육기간:${myeduStatus.start}~${myeduStatus.end}</div>
					<c:if test="${myeduStatus.status == 0}">
						<span class="text-status text-blue-600">진행중</span>
					</c:if>
					<c:if test="${myeduStatus.status == 1}">
						<span class="text-status text-red-400">종료됨</span>
					</c:if>
					<div class="edu-status-manager">담당자:
						${myeduStatus.extra__managerName}</div>
					<div class="edu-status-cellphone">담당자 연락처:
						${myeduStatus.extra__managerCellphoneNum}</div>

				</div>
				<div onclick="event.stopPropagation()">
					<button
						class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline myeduStatusCancle"
						type="submit" id="delete"
						onclick="if(confirm('정말 취소하시겠습니까?') == false) return false;">수강
						취소</button>
				</div>
			</div>
		</form>
	</c:forEach>
</div>

<%@ include file="../common/foot.jspf"%>