<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
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
		memberJoin__submitFormDone = true;
		form.submit();
	}
</script>
	<section class="flex justify-center mt-14">
		<form action="../member/dojoin?" class="w-full max-w-lg"
			onsubmit="memberJoin__submitForm(); return false;">
			<div class="text-center text-3xl">
				<h1>
					<i class="uil uil-user-plus"></i>회원가입
				</h1>
			</div>
			<input type="hidden" name="afterLoginUri" value="${afterLoginUri}" />
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
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
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="grid-last-name"> 비밀번호 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="loginPw" id="loginPw" autocomplete="off"
						required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="grid-password"> 생년월일 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="date" name="birthDay" id="birthDay" autocomplete="off"
						placeholder="20221212" required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="grid-password"> 이름 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="name" id="name" autocomplete="off" required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="grid-password"> 영문이름 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="text" name="englishName" id="englishName" autocomplete="off"
						required>
				</div>
			</div>
			<div class="flex flex-wrap -mx-3 mb-6">
				<div class="w-full px-3">
					<label
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
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
						class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2"
						for="grid-password"> 이메일 </label> <input
						class="appearance-none block w-full  text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
						type="email" name="email" id="email" autocomplete="off" required>
				</div>
			</div>
			<button
				class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
				type="submit">Sign up</button>
		</form>
	</section>
<%@ include file="../common/foot.jspf"%>