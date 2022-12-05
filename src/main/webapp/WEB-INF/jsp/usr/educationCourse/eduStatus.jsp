<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="eduStatus" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<script>
const totalRate = () =>{
var startDate = new Date('${myeduStatus[0].start}');
var endDate = new Date('${myeduStatus[0].end}');
const diffDate = startDate.getTime() - endDate.getTime();
return Math.abs(diffDate / (1000 * 60 * 60 * 24)); // 밀리세컨 * 초 * 분 * 시 = 일
}
console.log(totalRate());
const nowDate = () =>{
	var nowDate = new Date();
	var year = nowDate.getFullYear().toString();
	var month = nowDate.getMonth() + 1;
	month = month < 10 ? '0' + month.toString() : month.toString();

	var day = nowDate.getDate();
	day = day < 10 ? '0' + day.toString() : day.toString();

	return year +'-'+ month +'-'+ day ;
}
console.log(nowDate());


const nowRate = () =>{
	var startDate = new Date('${myeduStatus[0].start}');
	var nowDate = new Date('nowDate()');
	var totalRate = totalRate();
	const diffDate = startDate.getTime() - nowDate.getTime();
	const rateDay = Math.abs(diffDate / (1000 * 60 * 60 * 24)); // 밀리세컨 * 초 * 분 * 시 = 일
	var percent = totalRate / 100 * rateDay;
	return percent;
}
console.log(nowRate(),'%');
</script>


<%@ include file="../common/foot.jspf"%>