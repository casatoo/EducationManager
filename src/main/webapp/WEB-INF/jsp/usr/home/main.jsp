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
						<div class="box box1" onclick="location.href='../educationCourse/detail?id=${educationCourse.id}';">
							<span class="text-title"><i class="uil uil-pen"></i>${educationCourse.title}</span> <span
								class="text-date">${educationCourse.startOfEducation}~${educationCourse.endOfEducation}</span>
							<span class="text-manager">담당자:${educationCourse.extra__managerName}</span>
							<c:if
									test="${educationCourse.status == 0}">
									<span class="text-status color-green">진행중</span>
								</c:if> <c:if test="${educationCourse.status == 1}">
									<span class="text-status text-red">종료됨</span>
								</c:if>
						</div>
				</c:forEach>
			</div>
		</div>

		<div class="activity">
			<div class="title">
				<i class="uil uil-clock-three"></i> <span class="text">Recent
					Activity</span>
			</div>

			<div class="activity-data">
				<div class="data names">
					<span class="data-title">Name</span> <span class="data-list">Prem
						Shahi</span> <span class="data-list">Deepa Chand</span> <span
						class="data-list">Manisha Chand</span> <span class="data-list">Pratima
						Shahi</span> <span class="data-list">Man Shahi</span> <span
						class="data-list">Ganesh Chand</span> <span class="data-list">Bikash
						Chand</span>
				</div>
				<div class="data email">
					<span class="data-title">Email</span> <span class="data-list">premshahi@gmail.com</span>
					<span class="data-list">deepachand@gmail.com</span> <span
						class="data-list">prakashhai@gmail.com</span> <span
						class="data-list">manishachand@gmail.com</span> <span
						class="data-list">pratimashhai@gmail.com</span> <span
						class="data-list">manshahi@gmail.com</span> <span
						class="data-list">ganeshchand@gmail.com</span>
				</div>
				<div class="data joined">
					<span class="data-title">Joined</span> <span class="data-list">2022-02-12</span>
					<span class="data-list">2022-02-12</span> <span class="data-list">2022-02-13</span>
					<span class="data-list">2022-02-13</span> <span class="data-list">2022-02-14</span>
					<span class="data-list">2022-02-14</span> <span class="data-list">2022-02-15</span>
				</div>
				<div class="data type">
					<span class="data-title">Type</span> <span class="data-list">New</span>
					<span class="data-list">Member</span> <span class="data-list">Member</span>
					<span class="data-list">New</span> <span class="data-list">Member</span>
					<span class="data-list">New</span> <span class="data-list">Member</span>
				</div>
				<div class="data status">
					<span class="data-title">Status</span> <span class="data-list">Liked</span>
					<span class="data-list">Liked</span> <span class="data-list">Liked</span>
					<span class="data-list">Liked</span> <span class="data-list">Liked</span>
					<span class="data-list">Liked</span> <span class="data-list">Liked</span>
				</div>
			</div>
		</div>
	</div>
</section>

<!--<script src="script.js"></script>-->
</body>
</html>