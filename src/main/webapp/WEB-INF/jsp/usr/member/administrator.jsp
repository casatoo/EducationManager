<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="administrator" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<form action="../member/administrator">
				<input type="text" placeholder="검색어를 입력해주세요" name="searchName"/>
				<button type="submit">검색</button>
			</form>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>가입일자</th>
				<th>아이디</th>
				<th>생년월일</th>
				<th>이름</th>
				<th>영문이름</th>
				<th>전화번호</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="member" items="${memberList}">
				<tr class="hover:bg-black transition duration-300 hover:text-white">
					<th>${member.id}</th>
					<td>${member.regDate.substring(5,16)}</td>
					<td>${member.loginId}</td>
					<td>${member.birthDay}</td>
					<td>${member.name}</td>
					<td>${member.englishName}</td>
					<td>${member.cellphoneNum}</td>
					<td>${member.email}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
<%@ include file="../common/foot.jspf"%>


