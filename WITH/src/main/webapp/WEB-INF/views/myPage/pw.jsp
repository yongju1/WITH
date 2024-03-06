<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/pw.css">
</head>
<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>
<body>
	<section>
		<div class="myinfo">
			<div style="margin: 0 0 15px 150px;">
				<h2>비밀번호 수정</h2>
				<br>
			</div>
			<form action="/myPage/changePw" method="POST" name="mypageForm">
			<input type="hidden" name="user_no" value="${info.user_no}">
			<div class="mypage">
				<div class="form">
					<label class="te">현재 비밀번호</label>
					<div class="in">
						<input type="password" id="pwd" class="form-control" name="currentPw">
						<i id="eye" class="fa-regular fa-eye"></i>
					</div>
				</div>
				<div class="form" style="margin-top: 60px;">
					<label class="te">새 비밀번호</label>
					<div class="in">
						<input type="password" class="form-control" name="newPw" />
						<i id="eye" class="fa-regular fa-eye"></i>
					</div>
				</div>
				<div class="form" style="margin-top: 60px;">
					<label class="te">비밀번호 확인</label>
					<div class="in">
						<input type="password" class="form-control" name="newPwConfirm"/>
						<i id="eye" class="fa-regular fa-eye"></i>
					</div>
				</div>
			</div>
			<div class="btn">
				<button type="submit" class="modifybtn">수정하기</button>
				<div>
					<button class="cancelbtn" onclick="location.href='${pageContext.request.contextPath}/myPage/myPage'">취소</button>
				</div>
			</div>
			</form>
		</div>
	</section>
</body>

<script type="text/javascript">
	document.getElementById('eye').addEventListener('click', function() {
		var pwd = document.getElementById('pwd');
		if (pwd.type === "password") {
			pwd.type = "text";
		} else {
			pwd.type = "password";
		}
	});
</script>

<!--<script src="pw.js"></script>-->