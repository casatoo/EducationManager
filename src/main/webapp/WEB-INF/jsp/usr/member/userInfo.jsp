<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/status.jspf"%>
<%@ include file="../common/top-bar.jspf"%>
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
	
	console.log(AuthKey);
	$('#memberModifyAuthKey').val(AuthKey);
	$('#memberPasswordAuthKey').val(AuthKey);
});
}
</script>
<%-- 회원정보 수정 --%>

<script>
const memberInfoModify =()=>{
	$('#birthDay').removeAttr('disabled');
	$('#englishName').removeAttr('disabled');
	$('#cellphoneNum').removeAttr('disabled');
	$('#email').removeAttr('disabled');
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
	$('#birthDay').attr("disabled", true).val('${member.birthDay}');
	$('#englishName').attr("disabled", true).val('${member.englishName}');
	$('#cellphoneNum').attr("disabled", true).val('${member.cellphoneNum}');
	$('#email').attr("disabled", true).val('${member.email}');
	$('#modifyBtn').removeClass('hidden');
	$('#doModify').addClass('hidden');
	$('#cancleModify').addClass('hidden');
}
</script>

		<label> 회원 등급 </label> 
		<div>${level} 회원</div>
		<label> 가입일자 </label> 
		<div>${member.regDate.substring(0,16)}</div>
		<label> ID </label> 
		<input disabled type="text" name="loginId" id="loginId" autocomplete="off" value="${member.loginId}" required>
		
		<form action="../member/doChangePassword" onsubmit="changePassword__submitForm(this); return false;">
			<input type="hidden" name="memberPasswordAuthKey" id="memberPasswordAuthKey"/>
			<label class="hidden" id="password-check-label" for="grid-last-name"> 현재 비밀번호 </label> 
			<input disabled type="hidden" name="loginPwCheck" id="loginPwCheck" autocomplete="off" required>
			<label class="hidden" id="new-password-label" for="grid-last-name"> 새 비밀번호 </label> 
			<input disabled type="hidden" name="loginPw" id="loginPw" value="${member.loginPw}" autocomplete="off" required>
			<button type="button" id="changePasswordBtn" onclick="passwordChange(); createAuthKey();">비밀번호 변경하기 </button>
			<button class="hidden" type="submit" id="changePasswordConfirm">변경</button>
			<button class="hidden" type="button" id="changePasswordCancle" onclick="passwordChangeCancle()">취소</button>
		</form>
		
		<form action="../member/doModify?" onsubmit="memberInfoModify__submitForm(this); return false;">
			<label for="grid-password"> 생년월일 </label> 
			<input type="text" name="birthDay" id="birthDay" value="${member.birthDay}" required disabled>
			<label for="grid-password"> NAME </label> 
			<input type="text" name="name" id="name"  value="${member.name}" required disabled>
			<input type="hidden" name="memberModifyAuthKey" id="memberModifyAuthKey"/>
			<label for="grid-password"> ENGLISH NAME </label> 
			<input type="text" name="englishName" id="englishName" value="${member.englishName}" required disabled>
			<label for="grid-password"> PHONE NUMBER </label> 
			<input type="tel" id="cellphoneNum" name="cellphoneNum" value="${member.cellphoneNum}" pattern="[0-9]{11}" autocomplete="off" required disabled>
			<label for="grid-password"> E-MAIL </label> 
			<input type="email" name="email" id="email" value="${member.email}" required disabled>
			<button class="hidden" type="submit" id="doModify">수정 완료</button>
			<button class="hidden" type="button" id="cancleModify" onclick="memberCancleModify()">취소</button>
			<button type="button" id="modifyBtn" onclick="memberInfoModify(); createAuthKey();">회원정보 수정</button>
		</form>
		<a onclick="if(confirm('정말 탈퇴하시겠습니까?') == false) return false;" href="../member/quitMember?id=${member.id }">탈퇴</a>
</body>
</html>