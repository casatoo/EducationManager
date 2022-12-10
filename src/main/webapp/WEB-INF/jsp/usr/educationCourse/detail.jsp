<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="eduDetail" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<%-- 인증코드 생성 --%>
<script>
const createAuthKey = () => {
$.get('../educationCourse/createAuthKey',{
	educationCourseId : ${educationCourse.id},
	ajaxMode : 'Y'
}, function(AuthKey){
	console.log(AuthKey);
	$('#educationCourseModifyAuthKey').val(AuthKey);
});
}
</script>
<%-- 교육과정 수정 --%>

<script>
const educationCourseModify =()=>{
	$('#title').removeAttr('disabled').removeClass('bg-gray-300');
	$('#startOfEducation').removeAttr('disabled').removeClass('bg-gray-300');
	$('#endOfEducation').removeAttr('disabled').removeClass('bg-gray-300');
	$('#place').removeAttr('disabled').removeClass('bg-gray-300');
	$('#status').removeAttr('disabled').removeClass('bg-gray-300');
	$('#managerMemberId').removeAttr('disabled').removeClass('bg-gray-300');
	$('#modifyBtn').addClass('hidden');
	$('#doModify').removeClass('hidden');
	$('#cancleModify').removeClass('hidden');
}
</script>
<%-- 교육과정 수정 취소 --%>

<script>
const educationCourseCancleModify =()=>{
	$('#title').attr("disabled", true).val('${educationCourse.title}').addClass('bg-gray-300');
	$('#startOfEducation').attr("disabled", true).val('${educationCourse.startOfEducation}').addClass('bg-gray-300');
	$('#endOfEducation').attr("disabled", true).val('${educationCourse.endOfEducation}').addClass('bg-gray-300');
	$('#place').attr("disabled", true).val('${educationCourse.place}').addClass('bg-gray-300');
	$('#status').attr("disabled", true).addClass('bg-gray-300').val("${educationCourse.status}").prop("selected", true);
	$('#managerMemberId').attr("disabled", true).addClass('bg-gray-300').val("${educationCourse.managerMemberId}").prop("selected", true);
	$('#modifyBtn').removeClass('hidden');
	$('#doModify').addClass('hidden');
	$('#cancleModify').addClass('hidden');
}
</script>
<section class="flex justify-center mt-16">
	<div class="w-full max-w-lg">
		<form action="../educationCourse/doModify">
			<input type="hidden" name="educationCourseModifyAuthKey" id="educationCourseModifyAuthKey" />
			<input type="hidden" name="educationCourseId" id="educationCourseId" value="${educationCourse.id}"/>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="title"> 과정명 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="title" id="title" autocomplete="off"
						value="${educationCourse.title}" required disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="regDate"> 과정 등록일 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="date" name="regDate" id="regDate" autocomplete="off"
						value="${educationCourse.regDate.substring(0,10)}" required
						disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="startOfEducation"> 교육시작일 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="date" id="startOfEducation" name="startOfEducation"
						value="${educationCourse.startOfEducation}" autocomplete="off"
						required disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="endOfEducation"> 교육죵료일 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="date" name="endOfEducation" id="endOfEducation"
						autocomplete="off" value="${educationCourse.endOfEducation}"
						required disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="place"> 교육장소 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="place" id="place" autocomplete="off"
						value="${educationCourse.place}" required disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="managerMemberId"> 담당자 </label> <select name="managerMemberId"
						id="managerMemberId"
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						required disabled>
						<c:if test="${educationCourse.managerMemberId == 1}">
							<option value="1" selected>관리자</option>
							<option value="2">직원</option>
						</c:if>
						<c:if test="${educationCourse.managerMemberId == 2}">
							<option value="1">관리자</option>
							<option value="2" selected>직원</option>
						</c:if>
					</select>
				</div>
			</div>

			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="status"> 현재상태 </label> <select name="status" id="status"
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						required disabled>
						<c:if test="${educationCourse.status == 0}">
							<option value="0" selected>진행중</option>
							<option value="1">종료됨</option>
						</c:if>
						<c:if test="${educationCourse.status == 1}">
							<option value="0">진행중</option>
							<option value="1" selected>종료됨</option>
						</c:if>
					</select>
				</div>
			</div>
			<c:if
				test="${rq.loginedMember.authLevel == 1 || rq.loginedMember.authLevel == 2}">
				<button
					class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
					type="submit" id="doModify">수정 완료</button>
				<button
					class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
					type="button" id="cancleModify"
					onclick="educationCourseCancleModify()">취소</button>
				<button
					class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
					type="button" id="modifyBtn"
					onclick="educationCourseModify(); createAuthKey();">교육과정
					수정</button>
			</c:if>
		</form>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>