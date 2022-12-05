<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="calender" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<script>

</script>
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
	</div>
<%@ include file="../common/foot.jspf"%>