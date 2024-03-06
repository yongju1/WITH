<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/login.css">
    <title>WITH</title>
</head>

<%@ include file="../header.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#signup").on("click", function(){
			location.href="/account/signUp";
		})
		
		$("#findId").on("click", function(){
			location.href="/account/findId";
		})
		
		$("#findPw").on("click", function(){
			location.href="/account/findPw";
		})
	});
</script>

<body>
<form name='loginForm' action="/account/login" method="post">
        <div class="login-container">
            <div class="title">SIGN IN</div>
            <input type="text" id="user_id" name="user_id" placeholder="id">
            <input type="password" id="user_pw" name="user_pw" placeholder="password">
            <input type="button" id="signup" value="아직 회원이 아니신가요? 회원가입">
            <input type="submit" id="signin" value="SIGN IN" onclick="return loginSubmit()">
            <!-- <input type="submit" id="signin" value="SIGN IN"> -->
            <div class="social">
	            <a href="https://kauth.kakao.com/oauth/authorize?client_id=9715044fd472ff0b6ad4696c58fe73ef&redirect_uri=http://localhost:8080/account/login/oauth2/code/kakao&response_type=code">
					<img src="/resources/img/social_kakao_icon.svg" style="margin-right: 5px;">
				</a>
				<img src="/resources/img/social_naver_icon.svg" onclick="naverBtnClick()" id="naverIdLogin">
            </div>
            <div class="find">
                <input type="button" id="findId" value="아이디 찾기 /">
                <input type="button" id="findPw" value=" 비밀번호 찾기">
            </div>
        </div>
</form>

<script type="text/javascript">
let path = "${pageContext.request.contextPath }";

const formElement = document.getElementById("loginForm");
const id = document.getElementById("user_id");
const pw = document.getElementById("user_pw");

function loginSubmit() {
	if (id.value == null || id.value === "") {
		alert('아이디를 입력해 주세요.');
		id.focus();
		return false;
	}

	else if (pw.value == null || pw.value === "") {
		alert('비밀번호를 입력해 주세요.');
		pw.focus();
		return false;
	}

	else {
		formElement.submit();
	}

}

function naverBtnClick() {
	document.getElementById("naverIdLogin").firstChild.click();
}

var naverLogin = new naver.LoginWithNaverId(
        {
            clientId: "Lhss0_klqmPUr2XB7kQ1",
              // 본인의 Client ID로 수정, 띄어쓰기는 사용하지 마세요.
            callbackUrl: "http://localhost:8080/account/login/oauth2/code/naver",
              // 본인의 callBack url로 수정하세요.
            isPopup: false,
            loginButton: {color: "green", type: 3, height: 60}
              // 네이버 로그인버튼 디자인 설정. 한번 바꿔보세요:D
        }
    );
naverLogin.init();
</script>
</script>

</body>