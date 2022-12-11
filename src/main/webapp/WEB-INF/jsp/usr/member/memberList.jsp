<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="memberList" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>


<div class="member-list-box">
	<div class="member-list-title">회원 관리</div>
	<div class="search-box">
		<div>
			<span class="member-badge">회원 수: ${getTotalMember}명</span>
		</div>
		<div>
			<form action="../member/list">
				<select class="input-member-select rounded-lg" data-value="${param.searchFrom}" name="searchFrom" required>
					<option value="memberName" selected>이름</option>
				</select> <input class="input-member-search rounded-lg" type="text"
					placeholder="검색어를 입력해주세요" name="searchWord"
					value="${param.searchWord}" />
				<div class="member-list-search-btn">
					<button type="submit">검색</button>
				</div>
			</form>
		</div>
	</div>
	<table class="member-list-table">
		<colgroupo>
		<col width="5%">
		<col width="15%">
		<col width="15%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="10%">
		<col width="5%">
		</colgroupo>
		<thead class="member-list-thead">
			<tr>
				<th>번호</th>
				<th>가입일자</th>
				<th>생년월일</th>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th><input type="checkbox" class="checkbox-all-member-id" /></th>
			</tr>
		</thead>
		<tbody class="member-list-tbody">
			<c:forEach var="member" items="${memberList}">
				<tr>
					<td>${member.id}</td>
					<td>${member.regDate.substring(5,16)}</td>
					<td>${member.birthDay}</td>
					<td>${member.loginId}</td>
					<td>${member.name}</td>
					<td>${member.cellphoneNum}</td>
					<td>${member.email}</td>
					<th><input type="checkbox" class="checkbox-member-id" value="${member.id }" /></th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="flex justify-center mb-11">

		<div class="mt-4">
			<c:set var="pageMenuLen" value="4" />
			<c:set var="startPage"
				value="${page-pageMenuLen >=1 ? page-pageMenuLen : 1}" />
			<c:set var="endPage"
				value="${page + pageMenuLen <= pageCount ? page + pageMenuLen : pageCount}" />
			<c:set var="pageBaseUri" value="?searchWord=${param.searchWord}" />
			<c:set var="pageBaseUri" value="${pageBaseUri}&searchFrom=${param.searchFrom}" />
			<c:if test="${startPage > 1}">
				<button class="page-move-btn"
					onclick="location.href='../member/memberList${pageBaseUri}&page=1';">1</button>
			</c:if>
			<c:if test="${startPage > 2}">
				<button class="page-move-btn page-move-btn-not-active">...</button>
			</c:if>
			<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
				<button
					class="page-move-btn ${page == pageNum ? 'page-move-btn-active' : '' }"
					onclick="location.href='../member/memberList${pageBaseUri}&page=${pageNum}';">${pageNum}</button>
			</c:forEach>
			<c:if test="${endPage < pageCount-1}">
				<button class="page-move-btn page-move-btn-not-active">...</button>
			</c:if>
			<c:if test="${endPage < pageCount}">
				<button class="page-move-btn"
					onclick="location.href='../member/memberList${pageBaseUri}&page=${pageCount}';">${pageCount}</button>
			</c:if>
		</div>
	</div>
</div>
<%@ include file="../common/foot.jspf"%>


