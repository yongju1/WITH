<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/myPage.css">
</head>

<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>
<body>
	<section>
		<div class="myinfo">
		   <form name="readForm" role="form" method="post">
		        <input type="hidden" name="user_email" value="${info.user_email}">
				<input type="hidden" id="user_name" name="user_name" value="${info.user_name}">
				<input type="hidden" id="user_id" name="user_id" value="${info.user_id}">
				<input type="hidden" id="user_phone" name="user_phone" value="${info.user_phone}">
				<input type="hidden" id="user_birth" name="user_birth" value="${info.user_birth}"> 
			</form>
			
			<div class="container-wrapper">

				<div>
					<h2 style="margin: 0 0 15px 200px;">내 정보</h2>
				</div>

				<div class="mypage">
				
					<div class="detail">
						<p>이메일</p>
						<div>
							<h4> ${info.user_email} </h4>
						</div>
					</div>
					
					<div class="detail">
						<p>이름</p>			
							<h4> ${info.user_name} </h4>
					</div>

					<div class="detail">
						<p>아이디</p>
							<h4> ${info.user_id} </h4>
					</div>

					<div class="detail">
						<p>전화번호</p>
							<h4> ${info.user_phone} </h4>
					</div>

					<div class="detail">
						<p>생년월일</p>
							<h4> ${birth} </h4>
					</div>
					
					<br>
					
				</div>
				
				<div class="btn">
					<button class="modifybtn" onclick="location.href='../myPage/myPageUpdate'">수정하기</button>
					<div>
						<button class="pwbtn" onclick="updatePw()">PW수정</button>
					</div>
				</div>
				
			</div>
		</div>
	</section>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$(".pwbtn").on("click", function(){
			location.href="../myPage/changePw";
		})
	});
</script>