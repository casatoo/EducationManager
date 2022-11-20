<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%-- 제이쿼리 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<%-- 테일윈드 불러오기 --%>
<script src="https://unpkg.com/tailwindcss-jit-cdn"></script>

<%-- 폰트 어썸 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

<script src="/resource/common.js" defer="defer"></script>
<link rel="stylesheet" href="/resource/common.css" />


<meta charset="UTF-8">
<title>EM</title>
</head>
<body>
<div>메인 페이지</div>
<a href="${rq.joinUri}"><span>회원가입</span></a>
<a href="${rq.loginUri}"><span>로그인</span></a>
<a href="${rq.logoutUri}"><span>로그아웃</span></a>
</body>
</html>