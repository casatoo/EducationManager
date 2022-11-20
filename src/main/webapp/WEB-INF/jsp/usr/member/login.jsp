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
<title>login</title>
</head>
<body>
	<div>로그인 페이지</div>
	<form action="../member/doLogin?">
		<input type="hidden" name="afterLoginUri" id="afterLoginUri" value="${param.afterLoginUri}" /> 
		<label> id </label> 
		<input id="loginId" name="loginId" type="text"> 
		<label>Password</label> 
		<input id="loginPw" name="loginPw" type="password">
		<button type="submit">로그인</button>
	</form>
		
		<a href="../member/join">회원가입 </a> 
		
	<form action="../member/findLoginId">
		<label>name</label> 
		<input id="name" name="name" type="text"> 
		<label>email</label> 
		<input id="email" name="email" type="email">
		<button type="submit">아이디 찾기</button>
	</form>
		<form action="../member/findLoginPw">
		<label>name</label> 
		<input id="name" name="name" type="text"> 
		<label>loginId</label> 
		<input id="loginId" name="loginId" type="text"> 
		<label>email</label>
		<input id="email" name="email" type="email">
		<a>인증코드 발송</a>
		<input type="text"  name="accessCode" placeholder="인증코드 입력"/>
		<button type="submit">비밀번호 찾기</button>
	</form>
</body>
</html>