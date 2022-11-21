<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
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
				<a onclick="if(confirm('정말 탈퇴하시겠습니까?') == false) return false;"
					href="../member/quitMember?id=${member.id }">탈퇴</a>
</body>
</html>