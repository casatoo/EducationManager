<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
	
<%-- 아이디 중복 체크 비동기 조회 --%>
<script>
	function checkLoginIdDup() {
		if ($('#loginId').val().length > 2) {
			$.get('../member/checkLoginId', {
				loginId : $('#loginId').val(),
				ajaxMode : 'Y'
			}, function(data) {

				if (data.resultCode == 'F-1') {
					$('#check-loginId').css("color", "red");
				}
				if (data.resultCode == 'S-1') {
					$('#check-loginId').css("color", "green");
				}
				$('#check-loginId').empty().html(data.msg);
			}, 'json');
		} else {
			$('#check-loginId').empty().html("2자 이상 입력해주세요")
					.css("color", "red");
		}
	}
<%-- 0.5초 동안 입력이 없을 경우 동작 --%>
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 500);
</script>

<script>
	let memberJoin__submitFormDone = false;
	function memberJoin__submitForm(form) {
		alert(form.loginId.value.length);
		if (memberJoin__submitFormDone) {
			return;
		}
		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length <= 2) {
			alert('아이디는 2자 이상입니다.');
			form.loginId.focus();
			return;
		}
		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1204 * 1204;
		const profileImgFileInput = form["file__member__0__extra__profileImg__1"];
		if (profileImgFileInput.value) {
			if (profileImgFileInput.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();
				return;
			}
		}
		memberJoin__submitFormDone = true;
		form.submit();
	}
</script>
	<section class="flex justify-center mt-14">
		<form action="../member/dojoin" enctype="multipart/form-data" method="post" class="w-full max-w-lg"
			onsubmit="memberJoin__submitForm(); return false;">
			<div class="text-center text-3xl">
				<h1 class="join-label">
					<i class="uil uil-user-plus"></i>회원가입
				</h1>
			</div>
			<input type="hidden" name="afterLoginUri" value="${afterLoginUri}" />
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-first-name"> 아이디 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="loginId" id="loginId" autocomplete="off"
						onkeyup="checkLoginIdDupDebounced(this);" required>
					<p class="text-gray-600 text-s h-4" id="check-loginId"></p>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-last-name"> 비밀번호 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="loginPw" id="loginPw" autocomplete="off"
						required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 생년월일 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="date" name="birthDay" id="birthDay" autocomplete="off"
						placeholder="20221212" required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 이름 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="name" id="name" autocomplete="off" required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 영문이름 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="englishName" id="englishName" autocomplete="off"
						required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 전화번호 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="tel" id="cellphoneNum" name="cellphoneNum"
						placeholder="01012341234" pattern="[0-9]{11}" autocomplete="off"
						required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 이메일 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="email" name="email" id="email" autocomplete="off" required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-xs font-bold mb-2 join-label"
						for="grid-password"> 프로필 이미지 </label> <input accept="image/gif, image/jpeg, image/png" name="file__member__0__extra__profileImg__1"
								placeholder="프로필 이미지를 선택해주세요" type="file" class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500 join-label"
							/>
				</div>
			</div>
			<button
				class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
				type="submit">Sign up</button>
		</form>
	</section>
<%@ include file="../common/foot.jspf"%>