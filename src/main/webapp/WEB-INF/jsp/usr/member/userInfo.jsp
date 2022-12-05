<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="USERINFO" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/side-bar.jspf"%>
<%-- 개인정보 입력 제한사항 --%>
<script>
	let memberInfoModify__submitFormDone = false;
	
	function memberInfoModify__submitForm(form){
		
		if(memberInfoModify__submitFormDone){
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		form.email.value = form.email.value.trim();
		
		if (form.nickname.value.length < 2) {
			alert('2글자 이상 입력해주세요');
			form.nickname.focus();
			return;
		}
		if (form.cellphoneNum.value.length < 2) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		if (form.email.value.length < 2) {
			alert('이메일형식이 아닙니다.');
			form.email.focus();
			return;
		}
		
		memberInfoModify__submitFormDone = true;
		form.submit();
	}
</script>

<%-- 비밀번호 변경 체크 --%>
<script>
	let changePassword__submitFormDone = false;
	
	function changePassword__submitForm(form){
		
		if(changePassword__submitFormDone){
			return;
		}
		form.loginPwCheck.value = form.loginPwCheck.value.trim();
		form.loginPw.value = form.loginPw.value.trim();
		
		if (form.loginPwCheck.value.length < 1) {
			alert('기존의 패스워드를 입력해주세요');
			form.loginPwCheck.focus();
			return;
		}
		if (form.loginPw.value.length < 2) {
			alert('새로운 패스워드를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		
		changePassword__submitFormDone = true;
		form.submit();
	}
</script>
<%-- 인증코드 생성 --%>
<script>
const createAuthKey = () => {
$.get('../member/createAuthKey',{
	ajaxMode : 'Y'
}, function(AuthKey){
	$('#memberModifyAuthKey').val(AuthKey);
	$('#memberPasswordAuthKey').val(AuthKey);
});
}
</script>
<%-- 회원정보 수정 --%>

<script>
const memberInfoModify =()=>{
	$('#birthDay').removeAttr('disabled').removeClass('bg-gray-300');
	$('#englishName').removeAttr('disabled').removeClass('bg-gray-300');
	$('#cellphoneNum').removeAttr('disabled').removeClass('bg-gray-300');
	$('#email').removeAttr('disabled').removeClass('bg-gray-300');
	$('#modifyBtn').addClass('hidden');
	$('#doModify').removeClass('hidden');
	$('#cancleModify').removeClass('hidden');
}
</script>
<%-- 비밀번호 변경 --%>

<script>
const passwordChange = () =>{
	$('#password-check-label').removeClass('hidden');
	$('#new-password-label').removeClass('hidden');
	$('#loginPwCheck').attr("type","password").removeAttr('disabled').val("");
	$('#loginPw').attr("type","password").removeAttr('disabled').val("");
	$('#changePasswordBtn').addClass('hidden');
	$('#changePasswordConfirm').removeClass('hidden');
	$('#changePasswordCancle').removeClass('hidden');	
}
</script>
<%-- 비밀번호 변경 취소--%>

<script>
const passwordChangeCancle = () =>{
	$('#password-check-label').addClass('hidden');
	$('#new-password-label').addClass('hidden');
	$('#loginPwCheck').attr("type","hidden").attr("disabled", true);
	$('#loginPw').attr("type","hidden").attr("disabled", true);
	$('#changePasswordBtn').removeClass('hidden');
	$('#changePasswordConfirm').addClass('hidden');
	$('#changePasswordCancle').addClass('hidden');
}
</script>

<%-- 회원정보 수정 취소 --%>

<script>
const memberCancleModify =()=>{
	$('#birthDay').attr("disabled", true).val('${member.birthDay}').addClass('bg-gray-300');
	$('#englishName').attr("disabled", true).val('${member.englishName}').addClass('bg-gray-300');
	$('#cellphoneNum').attr("disabled", true).val('${member.cellphoneNum}').addClass('bg-gray-300');
	$('#email').attr("disabled", true).val('${member.email}').addClass('bg-gray-300');
	$('#modifyBtn').removeClass('hidden');
	$('#doModify').addClass('hidden');
	$('#cancleModify').addClass('hidden');
}
</script>
		<section class="flex justify-center mt-14">
				<div class="w-full max-w-lg">
						<div class="flex flex-wrap -mx-3">
								<div class="w-full px-3">
										<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
												회원 등급 </label>
										<div
												class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500">
												${level} 회원</div>
								</div>
						</div>
						<div class="flex flex-wrap -mx-3">
								<div class="w-full px-3">
										<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
												가입일자 </label>
										<div
												class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500">${member.regDate.substring(0,16)}</div>
								</div>
						</div>
						<div class="flex flex-wrap -mx-3">
								<div class="w-full px-3">
										<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
												아이디 </label> <input disabled
												class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
												type="text" name="loginId" id="loginId" autocomplete="off" value="${member.loginId}" required>
								</div>
						</div>
						<form action="../member/doChangePassword" onsubmit="changePassword__submitForm(this); return false;">
								<input type="hidden" name="memberPasswordAuthKey" id="memberPasswordAuthKey" />
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 hidden"
														id="password-check-label" for="grid-last-name"> 현재 비밀번호 </label> <input disabled
														class="appearance-none block w-full text-gray-700 border border-gray-500 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="hidden" name="loginPwCheck" id="loginPwCheck" autocomplete="off" required>
										</div>
								</div>
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2 hidden"
														id="new-password-label" for="grid-last-name"> 새 비밀번호 </label> <input disabled
														class="appearance-none block w-full text-gray-700 border border-gray-500 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="hidden" name="loginPw" id="loginPw" value="${member.loginPw}" autocomplete="off" required>
										</div>
								</div>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white  py-2 px-4 mt-3 rounded focus:outline-none focus:shadow-outline"
										type="button" id="changePasswordBtn" onclick="passwordChange(); createAuthKey();">비밀번호 변경</button>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white  py-2 px-4 mt-3 rounded focus:outline-none focus:shadow-outline hidden"
										type="submit" id="changePasswordConfirm">비밀번호 변경</button>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-3 rounded focus:outline-none focus:shadow-outline hidden"
										type="button" id="changePasswordCancle" onclick="passwordChangeCancle()">취소</button>
						</form>
						<div class="flex flex-wrap -mx-3">
								<div class="w-full px-3">
										<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
												이름 </label> <input
												class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
												type="text" name="name" id="name" autocomplete="off" value="${member.name}" required disabled>
								</div>
						</div>
						<form action="../member/doModify?" onsubmit="memberInfoModify__submitForm(this); return false;">
								<input type="hidden" name="memberModifyAuthKey" id="memberModifyAuthKey" />
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
														영문이름 </label> <input
														class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="text" name="englishName" id="englishName" autocomplete="off" value="${member.englishName}" required
														disabled>
										</div>
								</div>
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
														생년월일 </label> <input
														class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="date" name="birthDay" id="birthDay" autocomplete="off" value="${member.birthDay}" required disabled>
										</div>
								</div>
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
														PHONE NUMBER </label> <input
														class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="tel" id="cellphoneNum" name="cellphoneNum" value="${member.cellphoneNum}" pattern="[0-9]{11}"
														autocomplete="off" required disabled>
										</div>
								</div>
								<div class="flex flex-wrap -mx-3">
										<div class="w-full px-3">
												<label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
														E-MAIL </label> <input
														class="appearance-none block w-full bg-gray-300 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
														type="email" name="email" id="email" autocomplete="off" value="${member.email}" required disabled>
										</div>
								</div>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
										type="submit" id="doModify">수정 완료</button>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline hidden"
										type="button" id="cancleModify" onclick="memberCancleModify()">취소</button>
								<button
										class="bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline"
										type="button" id="modifyBtn" onclick="memberInfoModify(); createAuthKey();">회원정보 수정</button>
								<a type="button" class="bg-red-500 hover:bg-red-700 text-white py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="if(confirm('정말 탈퇴하시겠습니까?') == false) return false;" href="../member/quitMember?id=${member.id }">탈퇴하기</a>
						</form>
				</div>
		</section>
<%@ include file="../common/foot.jspf"%>