<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../resources/css/findId.css">
<title>WITH</title>
</head>

<%@ include file="../header.jsp"%>

<body>
	<form id="findForm" action="${contextPath }/account/findIdResult" method="post">
		<div class="signup-container">
			<div class="title">FIND ID</div>
			<div class="name">
				<span class="s">이름</span>
				<input id="user_name" name="user_name" type="text" placeholder="이름을 입력해 주세요.">
			</div>
			<div class="email">
				<span class="s">이메일</span>
				<input id="user_email" name="user_email" type="text" placeholder="이메일을 입력해 주세요.">
			</div>
			<div class="phone">
				<span class="s">전화번호</span>
				<input id="user_phone" name="user_phone" type="text" placeholder="-를 뺀 전화번호를 입력해 주세요." maxlength="11">
			</div>
			
			<%-- <div class="result-box">
				<c:choose>
					<c:when test="${empty findId}">
					<p class="inquiry">조회결과가 없습니다.</p>
					</c:when>
			        <c:otherwise>
			            <p>${findId.id}</p>
			        </c:otherwise>
				</c:choose>
			</div> --%>
						
			<button type="submit" id="idfind" onclick="return findSubmit()">FIND</button>
			
			<div>
				<ul class="join-login">
					<li><a href="${contextPath }/account/signUp">회원가입하기</a></li>
					<li><a href="${contextPath }/account/login">로그인하기</a></li>
				</ul>
			</div>
		</div>
	</form>
	<script type="text/javascript">
let path = "${pageContext.request.contextPath }";
let email_rule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

/* const formElement = document.querySelector("form"); */
const formElement = document.getElementById("findForm");
const userName = document.getElementById("user_name");
const userEmail = document.getElementById("user_email");
const userPhone = document.getElementById("user_phone");

function findSubmit() {
	if (userName.value == null || userName.value === "") {
		alert('이름을 입력해 주세요.');
		userName.focus();
		return false;
	}

	else if (userEmail.value == null || userEmail.value === "") {
		alert('이메일을 입력해 주세요.');
		userEmail.focus();
		return false;
	}
	
	else if (userPhone.value == null || userPhone.value === "") {
		alert('핸드폰번호을 입력해 주세요.');
		userPhone.focus();
		return false;
	}

	else if (!email_rule.test(userEmail.value)) {
		alert('올바른 이메일 형식이 아닙니다.');
		return false;
	}

	else if (confirm("아이디를 찾으시겠습니까?")) {

		formElement.submit();
		/* return false; */
	}

}
</script>
	<!-- <script src="../resources/js/findId.js"></script> -->
</body>