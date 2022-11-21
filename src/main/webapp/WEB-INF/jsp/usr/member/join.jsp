<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
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