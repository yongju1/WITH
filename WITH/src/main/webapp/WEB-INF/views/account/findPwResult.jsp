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
<link rel="stylesheet" href="/resources/css/findPwResult.css">
<title>WITH</title>
</head>

<%@ include file="../header.jsp"%>


<body>
		<div class="signup-container">	
		<div class="find-box">
			<p class="title">회원님의 임시 비밀번호 입니다</p>
			<div class="result-box">
			
			<p>${newPwd}</p>
				
			</div>
			<div class="announce">
				<p class="color2">&#8251;안전을 위해 비밀번호를 변경해 주세요.</p>
			</div>
			</div>
			
			<div class="login-pwd">
				<ul class="join-login cf">
					<li><a href="${contextPath }/account/login">로그인하기</a></li>
					<li><a href="${contextPath }/account/signUp">회원가입</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>