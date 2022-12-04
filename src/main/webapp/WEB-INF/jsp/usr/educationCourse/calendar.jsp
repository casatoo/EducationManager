<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="calender" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<script>

	function getEducationCourse() {
		$.get('../educationCourse/schedule', {
			ajaxMode : 'Y'
			}, function(data) {
				return data;
				});
	}
	
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
                select: function (arg) {
                    Swal.fire({
                        html: "<div class='mb-7'>Create new event?</div><div class='fw-bold mb-5'>Event Name:</div><input type='text' class='form-control' name='event_name' />",
                        icon: "info",
                        showCancelButton: true,
                        buttonsStyling: false,
                        confirmButtonText: "Yes, create it!",
                        cancelButtonText: "No, return",
                        customClass: {
                            confirmButton: "btn btn-primary",
                            cancelButton: "btn btn-active-light"
                        }
                    }).then(function (result) {
                        if (result.value) {
                            var title = document.querySelector("input[name=;event_name']").value;
                            if (title) {
                                calendar.addEvent({
                                    title: title,
                                    start: arg.start,
                                    end: arg.end,
                                    allDay: arg.allDay
                                })
                            }
                            calendar.unselect()
                        } else if (result.dismiss === "cancel") {
                            Swal.fire({
                                text: "Event creation was declined!.",
                                icon: "error",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: {
                                    confirmButton: "btn btn-primary",
                                }
                            });
                        }
                    });
                },

                // Delete event
                eventClick: function (arg) {
                    Swal.fire({
                        text: "Are you sure you want to delete this event?",
                        icon: "warning",
                        showCancelButton: true,
                        buttonsStyling: false,
                        confirmButtonText: "Yes, delete it!",
                        cancelButtonText: "No, return",
                        customClass: {
                            confirmButton: "btn btn-primary",
                            cancelButton: "btn btn-active-light"
                        }
                    }).then(function (result) {
                        if (result.value) {
                            arg.event.remove()
                        } else if (result.dismiss === "cancel") {
                            Swal.fire({
                                text: "Event was not deleted!.",
                                icon: "error",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: {
                                    confirmButton: "btn btn-primary",
                                }
                            });
                        }
                    });
                },
                dayMaxEvents: true, // allow "more" link when too many events
                // 이벤트 객체 필드 document : https://fullcalendar.io/docs/event-object
                events: [
                    {
                    title: 'All Day Event',
                    start: '2022-07-01'
                    },
                    {
                    title: 'Long Event',
                    start: '2022-07-07',
                    end: '2022-07-10'
                    },
                    {
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2022-07-09T16:00:00'
                    },
                    {
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2022-07-16T16:00:00'
                    },
                    {
                    title: 'Conference',
                    start: '2022-07-11',
                    end: '2022-07-13'
                    },
                    {
                    title: 'Meeting',
                    start: '2022-07-12T10:30:00',
                    end: '2022-07-12T12:30:00'
                    },
                    {
                    title: 'Lunch',
                    start: '2022-07-12T12:00:00'
                    },
                    {
                    title: 'Meeting',
                    start: '2022-07-12T14:30:00'
                    },
                    {
                    title: 'Happy Hour',
                    start: '2022-07-12T17:30:00'
                    },
                    {
                    title: 'Dinner',
                    start: '2022-07-12T20:00:00'
                    },
                    {
                    title: 'Birthday Party',
                    start: '2022-07-13T07:00:00'
                    },
                    {
                    title: 'Click for Google',
                    url: 'http://google.com/',
                    start: '2022-07-28'
                    }
                ]
            });

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