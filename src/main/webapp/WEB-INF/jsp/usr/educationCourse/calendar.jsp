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
                    left: 'prevYear,prev,next,nextYear today',
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
    					calendar.addEvent({title:i.title,start:i.start,end:i.end});
    				}
    			});
    		};
    		getEducationCourse();
            calendar.render();
        });

    </script>
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