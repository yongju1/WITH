<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/resources/css/signUp.css">
    <title>WITH</title>
</head>

<%@ include file="../header.jsp"%>

<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cancle").on("click", function(){
				
				location.href = "/login";
						    
			})
		
			$("#signup").on("click", function(){
				if($("#user_id").val()==""){
					alert("아이디를 입력해주세요.");
					$("#user_id").focus();
					return false;
				}
				if($("#user_pw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#user_pw").focus();
					return false;
				}
				
				if($("#passwordCheck").val()==""){
					alert("비밀번호 확인을 해주세요.");
					$("#password").focus();
					return false;
				}
				if($("#user_name").val()==""){
					alert("성명을 입력해주세요.");
					$("#user_name").focus();
					return false;
				}
				if($("#user_email").val()==""){
					alert("이메일을 입력해주세요.");
					$("#user_email").focus();
					return false;
				}
				if($("#user_phone").val()==""){
					alert("전화번호을 입력해주세요.");
					$("#user_phone").focus();
					return false;
				}
				if($("#user_birth").val()==""){
					alert("생년월일을 입력해주세요.");
					$("#user_birth").focus();
					return false;
				}
				
				var idChkVal = $("#idCheck").val();
				if(idChkVal == "N"){
					alert("중복확인 버튼을 눌러주세요.");
				}
				else if(idChkVal == "Y"){
					if (confirm("회원가입을 하시겠습니까?")) {
						$("#signUpForm").submit();
					}
				}
			});
		})
		
		function idChk(){
			$.ajax({
				url : "/account/idChk",
				type : "post",
				dataType : "json",
				data : {"user_id" : $("#user_id").val()},
				success : function(data){
					if(data == 1){
						alert("중복된 아이디입니다.");
					}else if(data == 0){
						$("#idCheck").attr("value", "Y");
						alert("사용가능한 아이디입니다.");
					}
				}
			})
		}
		
		function passConfrim() {
				var password = document.getElementById('user_pw');
				var passwordCheck = document.getElementById('passwordCheck');
				var confrimMsg = document.getElementById('confirmMsg');
				var correctColor = "#1BCC00";
				var wrongColor ="#ff0000";
				
				if(password.value == passwordCheck.value){
					confirmMsg.style.color = correctColor;
					confirmMsg.innerHTML ="비밀번호 일치";
				}else{
					confirmMsg.style.color = wrongColor;
					confirmMsg.innerHTML ="비밀번호 불일치";
				}
			}
	</script>

<body>
	<form action="/account/signUp" method="post" id="signupForm">
    	<div class="signup-container">
	        <div class="title">SIGN UP</div>
	        
		        <div class="name">
		            <span class="s">이름</span>
		            <input id="user_name" name="user_name" type="text" placeholder="이름을 입력해 주세요.">
		        </div>
		        <div class="id">
		            <span class="s">아이디</span>
		            <input id="user_id" name="user_id" type="text" placeholder="아이디를 입력해 주세요.">
		            <button type="button" id="idCheck" onclick="idChk();" value="N">중복확인</button>
		        </div>
		        <div class="email">
		            <span class="s">이메일</span>
		            <input id="user_email" name="user_email" type="text" placeholder="이메일을 입력해 주세요.">
		        </div>
		        <div class="password">
		            <span class="s">비밀번호</span>
		            <input id="user_pw" name="user_pw" type="password" placeholder="비밀번호를 입력해 주세요.">
		        </div>
		        <div class="passwordCheck">
		            <span class="s">비밀번호 확인</span>
		            <input id="passwordCheck" type="password" placeholder="비밀번호를 다시 입력해 주세요." onkeyup="passConfrim()">
		            <span class="s1" id="confirmMsg"></span>
		        </div>
		        <div class="phone">
		            <span class="s">전화번호</span>
		            <input id="user_phone" name="user_phone" type="text" oninput="hypenTel(this)" placeholder="-를 뺀 전화번호를 입력해 주세요." maxlength="13">
		        </div>
		        <div class="birth">
		            <span class="s">생년월일</span>
		            <input id="user_birth" name="user_birth" type="text" placeholder="생년월일을 입력해 주세요." maxlength="6">
		        </div>
		        <div class="btn-area">
			        <input type="submit" id="signup" value="SIGN UP">
			        <input type="button" class="cancle" value="취소">
		        </div> 
    		</div>
    	</form>
    </body>
    
    <script type="text/javascript">

    const hypenTel = (target) => {
	   target.value = target.value
	     .replace(/[^0-9]/g, '')
	     .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	  }

    </script>