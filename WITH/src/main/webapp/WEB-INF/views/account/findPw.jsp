<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/findPw.css">
<title>WITH</title>
</head>

<%@ include file="../header.jsp"%>

<body>
<form id="findForm" action="${contextPath }/account/findPwResult" method="post">
	<div class="signup-container">
		<div class="title">FIND PW</div>
		<div class="name">
			<span class="s">이름</span>
			<input id="user_name" name="user_name" type="text" placeholder="이름을 입력해 주세요.">
		</div>
		<div class="id">
			<span class="s">아이디</span>
			<input id="user_id" name="user_id" type="text" placeholder="id를 입력해 주세요.">
		</div>
		<div class="email">
			<span class="s">이메일</span>
			<input id="user_email" name="user_email" type="text" placeholder="이메일을 입력해 주세요.">
		</div>
		<!-- <div class="phone">
			<span class="s">전화번호</span>
			<input id="user_phone" name="user_phone" type="text" placeholder="-를 뺀 전화번호를 입력해 주세요." maxlength="11">
		</div> -->
		<button type="submit" id="pwfind" onclick="return findPwdSubmit()">FIND</button>
	</div>
	</form>
	<script type="text/javascript">
	let path = "${pageContext.request.contextPath }";
	/* const pwFind = document.getElementById("pwfind");
	pwFind.addEventListener("click", findPwdSubmit); */

	function findPwdSubmit(e) {
		e.preventDefault();
		const formElement = document.getElementById("pwfind");
		const userId = document.getElementById("user_id");
		const userName = document.getElementById("user_name");
		const userEmail = document.getElementById("user_email");

		let email_rule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (userId.value == null || userId.value === "") {
			alert('아이디를 입력해 주세요.');
			userId.focus();
			return false;
		}

		if (userName.value == null || userName.value === "") {
			alert('이름을 입력해 주세요.');
			userName.focus();
			return false;
		}

		if (userEmail.value == null || userEmail.value === "") {
			alert('이메일을 입력해 주세요.');
			userEmail.focus();
			return false;
		}
		if (!email_rule.test(userEmail.value)) {
			alert('올바른 이메일 형식이 아닙니다.');
			return false;
		}

		if (confirm("비밀번호를 찾으시겠습니까?")) {
			formElement.submit();
			return false;
		}
	}
	</script>
</body>