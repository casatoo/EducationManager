<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="calender" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<%-- 아이디 찾기, 비밀번호 찾기 모달 창 --%>
<script>

const createEducationCourseModal = () =>{
	$('.createEducationCourse-modal-bg').removeClass('hidden');
}
const createEducationCourseCancleBtn = () =>{
	$('.createEducationCourse-modal-bg').addClass('hidden');
}
</script>

<div class="createEducationCourse-modal-bg hidden"
	onclick="createEducationCourseCancleBtn()">
	<div class="createEducationCourse-modal"
		onclick="event.stopPropagation()">
		<section class="flex justify-center mt-14">
			<div class="w-full w-96">
				<form action="../educationCourse/create"
					class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
					<div class="flex flex-wrap -mx-3">
						<div class="w-full px-3">
							<label
								class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
								for="title"> 과정명 </label> <input
								class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
								type="text" name="title" id="title" autocomplete="off" required>
						</div>
					</div>
					<div class="flex flex-wrap -mx-3">
						<div class="w-full px-3">
							<label
								class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
								for="startOfEducation"> 교육시작일 </label> <input
								class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
								type="date" id="startOfEducation" name="startOfEducation"
								autocomplete="off" required>
						</div>
					</div>
					<div class="flex flex-wrap -mx-3">
						<div class="w-full px-3">
							<label
								class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
								for="endOfEducation"> 교육죵료일 </label> <input
								class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
								type="date" name="endOfEducation" id="endOfEducation"
								autocomplete="off" required>
						</div>
					</div>
					<div class="flex flex-wrap -mx-3">
						<div class="w-full px-3">
							<label
								class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
								for="place"> 교육장소 </label> <input
								class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
								type="text" name="place" id="place" autocomplete="off" required>
						</div>
					</div>
					<div class="flex flex-wrap -mx-3">
						<div class="w-full px-3">
							<label
								class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
								for="managerMemberId"> 담당자 </label> <select
								name="managerMemberId" id="managerMemberId"
								class="appearance-none block w-full text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
								required>
								<option value="1">관리자</option>
								<option value="2">직원</option>
							</select>
						</div>
					</div>
					<div class="flex items-center justify-between">
						<button class="loginPage-btn bg-blue-200" type="submit">
							<i class="fa-solid fa-magnifying-glass"></i>&nbsp;추가
						</button>
						<button class="loginPage-btn bg-blue-200" type="button"
							onclick="createEducationCourseCancleBtn()">
							<i class="fa-regular fa-circle-xmark"></i>&nbsp;닫기
						</button>
					</div>
				</form>
			</div>
		</section>
	</div>
</div>
<script>
    	document.addEventListener('DOMContentLoaded', function() {
        	var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
                headerToolbar: {
                    left: 'prev,next,today',
                    center: 'title',
                    right: 'dayGridMonth,dayGridWeek,dayGridDay'
                },
                selectable: true,
                selectMirror: true,

                navLinks: true, // can click day/week names to navigate views
                editable: true,
                locale: 'ko',
                // Create new event
                dayMaxEvents: true, // allow "more" link when too many events
                // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
                events:[]
				
            });
    		function getEducationCourse() {
    			$.get('../educationCourse/schedule', {
    				ajaxMode : 'Y'
    				}, function(data) {
    				for(var i of data.data1){
    					var courseUrl = 'http://127.0.0.1:8081/usr/educationCourse/detail?id='+i.id
    					calendar.addEvent({title:i.title,start:i.start,end:i.end,url:courseUrl});
    				}
    			});
    		};
    		getEducationCourse();
            calendar.render();
        });

    </script>
<div class="calendar-box">
	<div id='calendar' class="calendar"></div>
	<c:if test="${rq.loginedMember.authLevel <= 2}">
		<div class="educationCourse-add-btn">
			<button type="button" onClick="createEducationCourseModal()">
				<span class="link-name"><i
					class="fa-regular fa-calendar-plus"></i>&nbsp;&nbsp;새 교육과정</span>
			</button>
		</div>
	</c:if>
</div>
<%@ include file="../common/foot.jspf"%>