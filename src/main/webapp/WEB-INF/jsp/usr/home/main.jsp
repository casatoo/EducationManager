<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<script>
/** 현재 년월일 구하는 함수 */
function getCurrentDate()
{
    var date = new Date();
		var nowDate = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
		var yesterday = new Date(date.setDate(date.getDate() - 1));
    if(hours < 2){
        var year = yesterday.getFullYear().toString();
        var month = yesterday.getMonth() + 1;
        month = month < 10 ? '0' + month.toString() : month.toString();

        var day = yesterday.getDate();
        day = day < 10 ? '0' + day.toString() : day.toString();

        return year + month + day ;
    }
    
    var year = nowDate.getFullYear().toString();
    var month = nowDate.getMonth() + 1;
    month = month < 10 ? '0' + month.toString() : month.toString();

    var day = nowDate.getDate();
    day = day < 10 ? '0' + day.toString() : day.toString();

    return year + month + day ;
}
/** 현재 시간을 3시간 단위로 표현  */
function getCurrentTime()
{
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var currentTime = '2300';
    switch (hours){
   		case 2 :
    		if(minutes < 10){
    			break;
    		}
    	case 3 :
    	case 4 :
    		currentTime = '0200';
    		break;
   		case 5 :
    		if(minutes < 10){
    			currentTime = '0200';
    		}
    	case 6 :
    	case 7 :
    		currentTime = '0500';
    		break;
   		case 8 :
    		if(minutes < 10){
    			currentTime = '0500';
    		}
    	case 9 :
    	case 10 :
    		currentTime = '0800';
    		break;
   		case 11 :
    		if(minutes < 10){
    			currentTime = '0800';
    		}
    	case 12 :
    	case 13 :
    		currentTime = '1100';
    		break;
   		case 14 :
    		if(minutes < 10){
    			currentTime = '1100';
    		}
    	case 15 :
    	case 16 :
    		currentTime = '1400';
    		break;
   		case 17 :
    		if(minutes < 10){
    			currentTime = '1400';
    		}
    	case 18 :
    	case 19 :
    		currentTime = '1700';
    		break;
   		case 20 :
    		if(minutes < 10){
    			currentTime = '1700';
    		}
    	case 21 :
    	case 22 :
    		currentTime = '2000';
    		break;
   		case 23 :
    		if(minutes < 10){
    			currentTime = '2000';
    		}
    		break;
    }

    return currentTime;
}
	const API_KEY = 'UDknKWMcEt2j1IlOazmpJzieEdhjjaSOMbGQwmF0nEXiBUE2QKGJosC8yLqyllGhvAVgbU3JrtQDaWwPQYfE4w%3D%3D';
	async function getData() {

		var base_date = getCurrentDate();
		var base_time = getCurrentTime();
		const url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey='+API_KEY+'&numOfRows=10&pageNo=1&base_date='+base_date+'&base_time='+base_time+'&nx=36&ny=127&dataType=JSON';
		const response = await fetch(url);
		const data = await response.json();
		var pty = 0;
		for(var weather of data.response.body.items.item){
			switch(weather.category){
				case 'PTY' :
						switch (weather.fcstValue){
							case '1':
								$('.pty').text('🌧');
								$('.weatherMsg').text('비');
								pty = 1;
							case '2':
								break;
							case '3':
								$('.pty').text('🌨');
								$('.weatherMsg').text('눈');
								pty = 1;
								break;
							case '4':
								$('.pty').text('⛈');
								$('.weatherMsg').text('눈비');
								pty = 1;
								break;
						}
					break;
				case 'SKY' :
					if(pty != 0){
						break;
					}else{
						switch (weather.fcstValue){
						case 6:
						case 7:
						case 8:
							$('.pty').text('⛅');
							$('.weatherMsg').text('조금흐림');
							break;
						case 9:
						case 10:
							$('.pty').text('☁');
							$('.weatherMsg').text('흐림');
							break;
						default:
							$('.pty').text('☀');
							$('.weatherMsg').text('맑음');
						}
					}
					$('.tmp').html(weather.fcstValue);
					break;
				case 'TMP' :
					$('.tmp').html(weather.fcstValue);
					break;
				case 'POP' :
					$('.pop').html(weather.fcstValue);
					break;
				case 'VEC' :
					const vec = parseInt(weather.fcstValue);
					if(vec >= 337 || vec <= 22){
						$('.vec').text('북');
					}else if( 23 <= vec <= 67){
						$('.vec').text('북동');
					}
					else if( 68 <= vec <= 112){
						$('.vec').text('동');
					}
					else if( 113 <= vec <= 157){
						$('.vec').text('남동');
					}
					else if( 158 <= vec <= 202){
						$('.vec').text('남');
					}
					else if( 203 <= vec <= 247){
						$('.vec').text('남서');
					}
					else if( 248 <= vec <= 292){
						$('.vec').text('서');
					}
					else if( 293 <= vec <= 336){
						$('.vec').text('북서');
					}
					break;
				case 'WSD' :
					$('.wsd').html(weather.fcstValue);
					break;
				}
		}
	}
	getData();
</script>

<section class="dashboard">
	<div class="top">
		<i class="uil uil-bars sidebar-toggle"></i>
		<c:if test="${rq.isLogined()}">
			<img
				src="https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427__480.jpg"
				alt="">
		</c:if>
	</div>

	<div class="dash-content">
		<div class="overview">
			<div class="title">
				<i class="uil uil-location-arrow"></i> <span class="text">교육과정
					바로가기</span>
			</div>
			<c:if test="${empty educationCourses}">
				<div>진행중인 교육과정이 없습니다.</div>
			</c:if>
			<div class="boxes">

				<c:forEach var="educationCourse" items="${educationCourses}">
					<div class="box box1"
						onclick="location.href='../educationCourse/detail?id=${educationCourse.id}';">
						<span class="text-title"><i class="uil uil-pen"></i>${educationCourse.title}</span>
						<span class="text-date">${educationCourse.startOfEducation}~${educationCourse.endOfEducation}</span>
						<span class="text-manager">담당자:${educationCourse.extra__managerName}</span>
						<c:if test="${educationCourse.status == 0}">
							<span class="text-status text-blue-600">진행중</span>
						</c:if>
						<c:if test="${educationCourse.status == 1}">
							<span class="text-status text-red-400">종료됨</span>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="activity">
			<div class="title">
				<i class="uil uil-bell"></i><span class="text">최근 공지사항</span>
			</div>

			<div class="activity-data">
				<table class=" w-full table-fixed text-center">
					<thead class="bg-gray-400 text-white font-thin">
						<tr>
							<th class="w-11">번호</th>
							<th class="w-40">작성일시</th>
							<th class="w-64">제목</th>
							<th class="w-20">작성자</th>
							<th class="w-20">조회수</th>
							<th class="w-40">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles}">
							<tr
								class="hover:bg-gray-400 transition duration-75 hover:text-white">
								<th>${article.id}</th>
								<td>${article.regDate.substring(5,16)}</td>
								<td
									onClick="location.href='${rq.getArticleDetailUriFromArticleList(article)}'"
									style="cursor: pointer;">${article.title}</td>
								<td>${article.extra__writerName}</td>
								<td>${article.hit}</td>
								<td><span class="badge"><i
										class="fa-solid fa-thumbs-up"></i>&nbsp;&nbsp;${article.goodReactionPoint}</span>&nbsp;<span
									class="badge"><i class="fa-solid fa-thumbs-down"></i>&nbsp;&nbsp;${article.badReactionPoint}</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="weather">
			<div class="title">
				<i class="uil uil-sunset"></i> <span class="text">날씨</span>
			</div>
			<div class="boxes">
					<div class="box box3">
						<span class="text-pty pty"></span>
						<span class="text-weatherMsg weatherMsg"></span>
						<span class="text-tmp"><div class="tmp"></div>℃</span>
						<span class="text-vec vec"></span>
						<span class="text-wsd"><div class="wsd"></div>m/s</span>
					</div>
			</div>
		</div>
	</div>
</section>

<!--<script src="script.js"></script>-->
</body>
</html>