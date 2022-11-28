<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>

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
								pty = 1;
							case '2':
								break;
							case '3':
								$('.pty').text('🌨');
								pty = 1;
								break;
							case '4':
								$('.pty').text('⛈');
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
							break;
						case 9:
						case 10:
							$('.pty').text('☁');
							break;
						default:
							$('.pty').text('☀');
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
												<li class="float-right"><c:if test="${educationCourse.status == 0}">
																<div class="text-blue-600">진행중</div>
														</c:if> <c:if test="${educationCourse.status == 1}">
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
<div>
		<div class="flex flex-wrap justify-center">
				<div class="solid-border-box weather-box rounded-3xl flex m-3 flex justify-around">
						<div class="weather-1 flex flex-col justify-center items-center">
								<div class="pty text-8xl">☀</div>
								<div class="text-3xl inline-block">
								<div class="tmp text-3xl inline-block"></div>
								℃
								</div>
						</div>
						<div class="weather-2 flex flex-col justify-around items-center">
								<div></div>
								<div class="text-3xl inline-block">
										<i class="fa-solid fa-wind"></i>
										<div class="vec text-3xl inline-block"></div>
								</div>
								<div class="text-3xl inline-block">
								<div class="wsd text-3xl inline-block"></div>
								m/s
								</div>
								<div class="text-3xl inline-block">
										강수확률
										<div class="pop text-3xl inline-block"></div>
										%
								</div>
								<div></div>
						</div>
				</div>
		</div>
</div>
</body>
</html>