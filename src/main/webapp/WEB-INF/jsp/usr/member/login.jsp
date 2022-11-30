<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>
<script>
	<%-- 로그인 중 로그인 페이지 접속 제한 --%>
	if(${rq.isLogined()}){
		alert("이미 로그인중입니다.");
		history.back();
	}
</script>

<%-- 아이디 찾기, 비밀번호 찾기 모달 창 --%>
<script>

const findLoginIdModal = () =>{
	$('.findLoginId-modal-bg').removeClass('hidden');
}
const findLoginIdCancleBtn = () =>{
	$('.findLoginId-modal-bg').addClass('hidden');
}
const findPasswordModal = () =>{
	$('.findPassword-modal-bg').removeClass('hidden');
}
const findPasswordCancleBtn = () =>{
	$('.findPassword-modal-bg').addClass('hidden');
}
</script>
<%-- 아이디 찾기 비동기 처리 --%>
<script>
const findLoginId = (form) =>{
	$.get('../member/findLoginId', {
		name : form.name.value,
		email : form.email.value,
		ajaxMode : 'Y'
	}, function(data) {
		if(data.resultCode == "F-1"){
			$('.findLoginIdMessage').css('color','red').text(data.msg);
		}
		if(data.resultCode == "S-1"){
			const msg = data.msg + ':' + data.data1;
			$('.findLoginIdMessage').css('color','green').text(msg);
		}
	}, 'json');
}
</script>


<div class="findLoginId-modal-bg hidden">
		<div class="findLoginId-modal">
				<section class="flex justify-center mt-14">
						<div class="w-full max-w-xs">
								<form action="../member/findLoginId" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
										<div class="text-center text-3xl">
												<h1>아이디 찾기</h1>
										</div>
										<div class="mb-4">
												<label class="block text-gray-700 text-sm font-bold mb-2" for="username"> 이름 </label> <input
														class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
														id="name" name="name" type="text" placeholder="아름을 입력해주세요">
										</div>
										<div class="mb-6">
												<label class="block text-gray-700 text-sm font-bold mb-2" for="email"> 이메일 </label> <input
														class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
														id="email" name="email" type="email" placeholder="이메일을 입력해주세요">
										</div>
										<div class="flex items-center justify-between">
												<button class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800"
														type="button"onclick="findLoginId(this.form)">찾기</button>
												<div class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800 cursor-pointer"
														onclick="findLoginIdCancleBtn()">닫기</div>
										</div>
										<div class="findLoginIdMessage"></div>
								</form>
						</div>
				</section>
		</div>
</div>
<div class="findPassword-modal-bg hidden">
		<div class="findPassword-modal">
				<section class="flex justify-center mt-14">
						<div class="w-full max-w-xs">
								<form action="../member/findLoginPw" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
								<input type="hidden" name="afterLoginUri" id="afterLoginUri" value="${param.afterLoginUri}" />
										<div class="text-center text-3xl">
												<h1>비밀번호 찾기</h1>
										</div>
										<div class="mb-4">
												<label class="block text-gray-700 text-sm font-bold mb-2" for="loginId"> 아이디 </label> <input
														class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
														id="loginId" name="loginId" type="text" placeholder="아이디를 입력해주세요">
										</div>
										<div class="mb-6">
												<label class="block text-gray-700 text-sm font-bold mb-2" for="username"> 이름 </label> <input
														class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
														id="name" name="name" type="text" placeholder="이름을 입력해주세요">
										</div>
										<div class="mb-6">
												<label class="block text-gray-700 text-sm font-bold mb-2" for="email"> 이메일 </label> <input
														class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
														id="email" name="email" type="email" placeholder="이메일을 입력해주세요">
										</div>
										<div class="flex items-center justify-between">
												<button class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800"
														type="submit">찾기</button>
												<div class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800 cursor-pointer"
														onclick="findPasswordCancleBtn()">닫기</div>
										</div>
								</form>
						</div>
				</section>
		</div>
</div>
<section class="flex justify-center mt-14">
		<div class="w-full max-w-xs">
				<div class="text-center text-3xl">
						<h1>로그인</h1>
				</div>
				<form action="../member/doLogin?" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<input type="hidden" name="afterLoginUri" id="afterLoginUri" value="${param.afterLoginUri}" />
						<div class="mb-4">
								<label class="block text-gray-700 text-sm font-bold mb-2" for="username"> 아이디 </label> <input
										class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
										id="loginId" name="loginId" type="text" placeholder="아이디를 입력해주세요">
						</div>
						<div class="mb-6">
								<label class="block text-gray-700 text-sm font-bold mb-2" for="password"> 비밀번호 </label> <input
										class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
										id="loginPw" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요">
						</div>
						<div class="flex items-center justify-between">
								<button class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800" type="submit">로그인</button>
								<div
										class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800 cursor-pointer findLoginId-btn"
										onClick="findLoginIdModal()">아이디 찾기</div>

						</div>
						<div class="flex items-center justify-between">
								<a class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800" href="../member/join">
										회원가입 </a>
								<div
										class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800 cursor-pointer findLoginId-btn"
										onClick="findPasswordModal()">비밀번호 찾기</div>
						</div>
				</form>
		</div>
</section>
</body>
</html>