<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>

<script>
	const API_KEY = 'UDknKWMcEt2j1IlOazmpJzieEdhjjaSOMbGQwmF0nEXiBUE2QKGJosC8yLqyllGhvAVgbU3JrtQDaWwPQYfE4w%3D%3D';
	var TMP;
	var POP;
	var PTY;
	var SKY;
	var VEC;
	var WSD;
	async function getData() {
		const url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey='+API_KEY+'&numOfRows=10&pageNo=1&base_date=20221125&base_time=1700&nx=36&ny=127&dataType=JSON';
		const response = await fetch(url);
		const data = await response.json();
		for(var weather of data.response.body.items.item){
			if(weather.category == 'TMP'){
				TMP = weather.fcstValue;
			}
			if(weather.category == 'POP'){
				POP = weather.fcstValue;
			}
			if(weather.category == 'PTY'){
				PTY = weather.fcstValue;
			}
			if(weather.category == 'SKY'){
				SKY = weather.fcstValue;
			}
			if(weather.category == 'VEC'){
				VEC = weather.fcstValue;
			}
			if(weather.category == 'WSD'){
				WSD = weather.fcstValue;
			}
		}
		$('.tmp').html(TMP);	
		$('.pop').html(POP);	
		$('.pty').html(PTY);	
		$('.sky').html(SKY);	
		$('.vec').html(VEC);	
		$('.wsd').html(WSD);	
	}
	getData();
</script>

<img src="/resource/main.jpg" class="main-img" />


<div class="educationCourses-box mt-6">
	<div class="flex flex-wrap text-2xl">
		<div class="text-blue-600">최신 교육과정</div>
	</div>
</div>
<div class="educationCourses-box ">
	<div class="flex flex-wrap justify-center">
		<c:if test="${empty educationCourses}">
			<div>진행중인 교육과정이 없습니다.</div>
		</c:if>
		<c:forEach var="educationCourse" items="${educationCourses}">
			<div class="solid-border-box w-60 h-36 rounded-3xl flex m-3">
				<a href="../educationCourse/detail?id=${educationCourse.id}">
					<ul>
						<li class="font-bold m-3 text-2xl">${educationCourse.title}</li>
						<li class="ml-3 mb-3">${educationCourse.startOfEducation}~${educationCourse.endOfEducation}</li>
						<li class="ml-3">담당자:${educationCourse.extra__managerName}</li>
						<li class="float-right">
						<c:if test="${educationCourse.status == 0}">
							<div class="text-blue-600">진행중</div>
						</c:if> 
						<c:if test="${educationCourse.status == 1}">
							<div class="text-red-600">종료됨</div>
						</c:if></li>
					</ul>
				</a>
			</div>
		</c:forEach>
	</div>
</div>
<div class="educationCourses-box mt-6">
	<div class="flex flex-wrap text-2xl">
		<div class="text-blue-600">최신 소식</div>
	</div>
</div>
<div class="educationCourses-box ">
	<div class="flex flex-wrap justify-center">
		<c:if test="${empty articles}">
			<div>게시물이 없습니다.</div>
		</c:if>
		<c:forEach var="article" items="${articles}">
			<div class="solid-border-box w-44 h-60 rounded-3xl flex m-3">
				<a href="${rq.getArticleDetailUriFromArticleList(article)}">
					<ul>
						<li class="font-bold m-3 text-2xl">${article.title}</li>
						<li class="ml-3 h-32">${article.body}</li>
						<li class="ml-3">작성자:${article.extra__writerName}</li>
						<li class="ml-3">${article.regDate.substring(5,16)}</li>
					</ul>
				</a>
			</div>
		</c:forEach>
	</div>
</div>
<div class="educationCourses-box mt-6">
	<div class="flex flex-wrap text-2xl">
		<div class="text-blue-600">날씨정보</div>
	</div>
</div>
<div class="educationCourses-box ">
	<div class="flex flex-wrap justify-center">
		<c:if test="${empty articles}">
			<div>날씨정보를 불러오지 못합니다.</div>
		</c:if>
		<div>
				<div class="solid-border-box weather-box rounded-3xl flex m-3">
					<ul>
						<li class="ml-3">기온: <div class="tmp"></div></li>
						<li class="ml-3">강수확률: <div class="pop"></div></li>
						<li class="ml-3">현재상태:<div class="pty"></div></li>
						<li class="ml-3">구름: <div class="sky"></div></li>
						<li class="ml-3">풍향: <div class="vec"></div></li>
						<li class="ml-3">풍속: <div class="wsd"></div></li>
					</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>