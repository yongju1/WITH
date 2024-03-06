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
<link rel="stylesheet" href="/resources/css/findIdResult.css">
<title>WITH</title>
</head>

<%@ include file="../header.jsp"%>


<body>
		<div class="signup-container">	
			<div class="result-box">
				<%-- <c:if test="${empty findId}">
					<p>${findId.id}</p>
				</c:if>
				<c:if test="${!empty findId}">
					<p class="inquiry">조회결과가 없습니다.</p>
				</c:if> --%>
				<c:choose>
					<c:when test="${empty findId}">
					<p>조회결과가 없습니다.</p>
					</c:when>
			        <c:otherwise>
			            <p>${findId.user_id}</p>
			        </c:otherwise>
				</c:choose>
			</div>
			
			<div class="login-pwd">
				<ul class="join-login cf">
					<li><a href="${contextPath }/account/login">로그인하기</a></li>
					<li><a href="${contextPath }/account/findPw">비밀번호찾기</a></li>
				</ul>
			</div>
		</div>
	
</body>