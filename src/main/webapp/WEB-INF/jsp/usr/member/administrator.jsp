<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%-- 제이쿼리 --%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<%-- 테일윈드 불러오기 --%>
<script src="https://unpkg.com/tailwindcss-jit-cdn"></script>

<%-- 폰트 어썸 --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

<script src="/resource/common.js" defer="defer"></script>
<link rel="stylesheet" href="/resource/common.css" />


<meta charset="UTF-8">
<title>join</title>
</head>
<body>
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
	</div>
</body>
</html>


