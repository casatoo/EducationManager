<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>
	<div>로그인 페이지</div>
	<form action="../member/doLogin?">
		<input type="hidden" name="afterLoginUri" id="afterLoginUri"
			value="${param.afterLoginUri}" /> <label> id </label> <input
			id="loginId" name="loginId" type="text"> <label>Password</label>
		<input id="loginPw" name="loginPw" type="password">
		<button type="submit">로그인</button>
	</form>

	<a href="../member/join">회원가입 </a>

	<form action="../member/findLoginId">
		<label>name</label> <input id="name" name="name" type="text">
		<label>email</label> <input id="email" name="email" type="email">
		<button type="submit">아이디 찾기</button>
	</form>

	<form action="../member/findLoginPw">
	<input type="hidden" name="afterFindLoginPwUri" value="${param.afterLoginUri}"/>
		<label>name</label> <input id="name" name="name" type="text">
		<label>loginId</label> <input id="loginId" name="loginId" type="text">
		<label>email</label> <input id="email" name="email" type="email">
		<button type="submit">비밀번호 찾기</button>
	</form>

</body>
</html>