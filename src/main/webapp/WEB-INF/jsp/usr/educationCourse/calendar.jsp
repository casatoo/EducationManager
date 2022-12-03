<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="calender" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<section class="dashboard">
	<div class="top">
		<i class="uil uil-bars sidebar-toggle"></i>
	</div>
	<div class="calendar-box">
		<div id='calendar' class="calendar"></div>
	</div>
</section>
</body>
</html>