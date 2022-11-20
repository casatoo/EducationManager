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
	<div>회원가입 페이지</div>
	<form action="../member/dojoin?">
		<input type="hidden" name="afterLoginUri" value="${afterLoginUri}" />
		<label for="">id</label>
		<input type="text" name="loginId" required>
		<label for="">pw</label>
		<input type="text" name="loginPw" required>
		<label for="">birthDay</label>
		<input type="text" name="birthDay" required>
		<label for="">name</label>
		<input type="text" name="name" required>
		<label for="">englishName</label>
		<input type="text" name="englishName" required>
		<label for="">cellphoneNum</label>
		<input type="tel" name="cellphoneNum" placeholder="01012341234" pattern="[0-9]{11}" required> 
		<label for="">email</label>
		<input type="email" name="email" required>
		<button type="submit">Sign up</button>
	</form>
</body>
</html>