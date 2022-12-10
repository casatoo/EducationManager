<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="eduDetail" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>

<%-- 현재상태 변경 --%>
<script>
const statusSelected = () =>{
	if(${educationCourse.status == 0}){
		
		$('#status').val('0').prop("selected",true);
	}
	if(${educationCourse.status == 1}){
		
		$('#status').val('1').prop("selected",true);
	}
}
setTimeout(statusSelected,100);
</script>
<%-- 인증코드 생성 --%>
<script>
const createAuthKey = () => {
$.get('../member/genEducationCourseModifyAuthKey',{
	ajaxMode : 'Y'
}, function(AuthKey){
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
	$('#managerMemberId').removeAttr('disabled').removeClass('bg-gray-300').removeClass('hidden');
	$('#extra__managerName').removeAttr('disabled').removeClass('bg-gray-300').addClass('hidden');
	$('#modifyBtn').addClass('hidden');
	$('#doModify').removeClass('hidden');
	$('#cancleModify').removeClass('hidden');
}
</script>
<%-- 교육과정 수정 취소 --%>

<script>
const educationCourseCancleModify =()=>{
	$('#title').attr("disabled", true).val('${educationCourse.title}').addClass('bg-gray-300');
	$('#startOfEducation').attr("disabled", true).val('${member.englishName}').addClass('bg-gray-300');
	$('#place').attr("disabled", true).val('${member.cellphoneNum}').addClass('bg-gray-300');
	$('#email').attr("disabled", true).val('${member.email}').addClass('bg-gray-300');
	$('#modifyBtn').removeClass('hidden');
	$('#doModify').addClass('hidden');
	$('#cancleModify').addClass('hidden');
}
</script>
<section class="flex justify-center mt-14">
	<div class="w-full max-w-lg">
		<form action="../educationCourse/domodify"
			onsubmit="educationCourseModify__submitForm(this); return false;">
			<input type="hidden" name="educationCourseModifyAuthKey" id="educationCourseModifyAuthKey" />
			<input type="hidden" name="managerMemberId" id="managerMemberId" value="${educationCourse.managerMemberId}"/>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="id"> 과정 번호 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="id" id="id" autocomplete="off"
						value="${educationCourse.id}" required disabled>
				</div>
			</div>
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
						for="extra__managerName"> 담당자 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="extra__managerName" id="extra__managerName"
						autocomplete="off" value="${educationCourse.extra__managerName}"
						required disabled>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 hidden"
						for="extra__managerName"> 담당자 회원번호 </label> <input
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="managerMemberId" id="managerMemberId"
						autocomplete="off" value="${educationCourse.managerMemberId}"
						required disabled>
				</div>
			</div>

			<div class="flex flex-wrap -mx-3">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="status"> 현재상태 </label> <select name="status" id="status"
						class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" required disabled>
						<option value="0" >진행중</option>
						<option value="1" >종료됨</option>
					</select>
				</div>
			</div>
			<c:if test="${rq.loginedMember.authLevel == 1 || rq.loginedMember.authLevel == 2}">
			<button
				class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
				type="submit" id="doModify">수정 완료</button>
			<button
				class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
				type="button" id="cancleModify" onclick="educationCourseCancleModify()">취소</button>
			<button
				class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
				type="button" id="modifyBtn"
				onclick="educationCourseModify(); createAuthKey();">교육과정 수정</button>
			</c:if>	
		</form>
	</div>
</section>
<%@ include file="../common/foot.jspf"%>