<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
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
<%-- 모달창 외부 클릭 닫기 --%>
<script>

</script>

	<div class="findLoginId-modal-bg hidden" onclick="findLoginIdCancleBtn()">
		<div class="findLoginId-modal" onclick="event.stopPropagation()">
			<section class="flex justify-center mt-14">
				<div class="w-full w-96">
					<form action="../member/findLoginId"
						class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<div class="text-center text-3xl">
							<h1>아이디 찾기</h1>
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 text-sm font-bold mb-2"
								for="username"> 이름 </label> <input
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								name="name" type="text" placeholder="아름을 입력해주세요">
						</div>
						<div class="mb-6">
							<label class="block text-gray-700 text-sm font-bold mb-2"
								for="email"> 이메일 </label> <input
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								name="email" type="email" placeholder="이메일을 입력해주세요">
						</div>
						<div class="flex items-center justify-between">
							<button
								class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
								type="button" onclick="findLoginId(this.form)">찾기</button>
							<button
								class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
								type="button" onclick="findLoginIdCancleBtn()">닫기</button>
						</div>
						<div class="findLoginIdMessage"></div>
					</form>
				</div>
			</section>
		</div>
	</div>
	<div class="findPassword-modal-bg hidden" onclick="findPasswordCancleBtn()">
		<div class="findPassword-modal " onclick="event.stopPropagation()">
			<section class="flex justify-center mt-14">
				<div class="w-full w-96">
					<form action="../member/findLoginPw"
						class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<input type="hidden" name="afterLoginUri"
							value="${param.afterLoginUri}" />
						<div class="text-center text-3xl">
							<h1>비밀번호 찾기</h1>
						</div>
						<div class="mb-4">
							<label class="block text-gray-700 text-sm font-bold mb-2"
								for="loginId"> 아이디 </label> <input
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								name="loginId" type="text" placeholder="아이디를 입력해주세요">
						</div>
						<div class="mb-6">
							<label class="block text-gray-700 text-sm font-bold mb-2"
								for="username"> 이름 </label> <input
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								name="name" type="text" placeholder="이름을 입력해주세요">
						</div>
						<div class="mb-6">
							<label class="block text-gray-700 text-sm font-bold mb-2"
								for="email"> 이메일 </label> <input
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
								name="email" type="email" placeholder="이메일을 입력해주세요">
						</div>
						<div class="flex items-center justify-between">
							<button
								class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
								type="submit">찾기</button>
							<div
								class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
								onclick="findPasswordCancleBtn()">닫기</div>
						</div>
					</form>
				</div>
			</section>
		</div>
	</div>
	<section class="flex justify-center mt-14">
		<div class="w-full w-96">
			<form action="../member/doLogin?"
				class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
				<div class="text-center text-3xl">
					<h1>
						<i class="uil uil-signin"></i>로그인
					</h1>
				</div>
				<input type="hidden" name="afterLoginUri"
					value="${param.afterLoginUri}" />
				<div class="mb-4">
					<label class="block text-gray-700 text-sm font-bold mb-2"
						for="username"> 아이디 </label> <input
						class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						id="loginId" name="loginId" type="text" placeholder="아이디를 입력해주세요">
				</div>
				<div class="mb-6">
					<label class="block text-gray-700 text-sm font-bold mb-2"
						for="password"> 비밀번호 </label> <input
						class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						id="loginPw" name="loginPw" type="password"
						placeholder="비밀번호를 입력해주세요">
				</div>
				<div class="flex flex-col justify-center">
					<button
						class="loginPage-btn bg-blue-200"
						type="submit">로그인</button>
					<a
						class="loginPage-btn bg-blue-200"
						type="button" href="../member/join"> 회원가입 </a>
					<div
						class="loginPage-btn bg-blue-200"
						onClick="findLoginIdModal()">아이디 찾기</div>
					<div
						class="loginPage-btn bg-blue-200"
						onClick="findPasswordModal()">비밀번호 찾기</div>
				</div>
			</form>
		</div>
	</section>
</section>
</body>
</html>