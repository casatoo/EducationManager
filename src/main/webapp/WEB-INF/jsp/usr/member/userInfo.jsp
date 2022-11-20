<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="INFO" />

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
<title>user info</title>
</head>
<body>
				<label> 회원 등급 </label> 
				<div>${level} 회원</div>
				<label> 가입일자 </label> 
				<div>${member.regDate.substring(0,16)}</div>
				<label> ID </label> 
				<div>${member.loginId}</div>
				<label>비밀번호 </label>
				<div>${member.loginPw}</div>
				<label>생년월일</label>
				<div>${member.birthDay}</div>
				<label> name </label>
				<div>${member.name}</div>
				<label> englishName </label>
				<div>${member.englishName}</div>
				<label> PHONE NUMBER </label> 
				<div>${member.cellphoneNum}</div>
				<label> E-MAIL </label>
				<div>${member.email}</div>
</body>
</html>