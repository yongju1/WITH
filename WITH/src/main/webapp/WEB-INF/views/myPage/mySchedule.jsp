<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/mySchedule.css">
</head>

<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>
<body>
	<!-- 바디 -->
	<div class="schedule">
		<div class="myschedule">일정</div>
		<div class="section">
			<input type="radio" name="slide" id="slide01" checked> <input
				type="radio" name="slide" id="slide02"> <input type="radio"
				name="slide" id="slide03"> <input type="radio" name="slide"
				id="slide04"> <input type="radio" name="slide" id="slide05">
			<input type="radio" name="slide" id="slide06"> <input
				type="radio" name="slide" id="slide07"> <input type="radio"
				name="slide" id="slide08"> <input type="radio" name="slide"
				id="slide09"> <input type="radio" name="slide" id="slide10">
			<input type="radio" name="slide" id="slide11"> <input
				type="radio" name="slide" id="slide12">
			<div class="slidewrap">
				<div class="slide-control">
					<div class="control01">
						<label for="slide12" class="left"></label>
						<li><a>1월</a></li> <label for="slide02" class="right"></label>
					</div>
					<div class="control02">
						<label for="slide01" class="left"></label>
						<li><a>2월</a></li> <label for="slide03" class="right"></label>
					</div>
					<div class="control03">
						<label for="slide02" class="left"></label>
						<li><a>3월</a></li> <label for="slide04" class="right"></label>
					</div>
					<div class="control04">
						<label for="slide03" class="left"></label>
						<li><a>4월</a></li> <label for="slide05" class="right"></label>
					</div>
					<div class="control05">
						<label for="slide04" class="left"></label>
						<li><a>5월</a></li> <label for="slide06" class="right"></label>
					</div>
					<div class="control06">
						<label for="slide05" class="left"></label>
						<li><a>6월</a></li> <label for="slide07" class="right"></label>
					</div>
					<div class="control07">
						<label for="slide06" class="left"></label>
						<li><a>7월</a></li> <label for="slide08" class="right"></label>
					</div>
					<div class="control08">
						<label for="slide07" class="left"></label>
						<li><a>8월</a></li> <label for="slide09" class="right"></label>
					</div>
					<div class="control09">
						<label for="slide08" class="left"></label>
						<li><a>9월</a></li> <label for="slide10" class="right"></label>
					</div>
					<div class="control10">
						<label for="slide09" class="left"></label>
						<li><a>10월</a></li> <label for="slide11" class="right"></label>
					</div>
					<div class="control11">
						<label for="slide10" class="left"></label>
						<li><a>11월</a></li> <label for="slide12" class="right"></label>
					</div>
					<div class="control12">
						<label for="slide11" class="left"></label>
						<li><a>12월</a></li> <label for="slide01" class="right"></label>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="calendar">달력들어갈자리</div>
	<h2>1월어느날</h2>
	<div class="scheduleDetail1">
		<img src="/resources/img/1.jpg">
		<h3>장소</h3>
		<h3>위치	<input type="submit" id="update" value="수정"> 
		<input type="submit" id="delete" value="삭제"></h3>
		<h3>일정메모</h3>
	</div>
		<div class="scheduleDetail2">
		<img src="/resources/img/1.jpg">
		<h3>장소</h3>
		<h3>위치	<input type="submit" id="update" value="수정"> 
		<input type="submit" id="delete" value="삭제"></h3>
		<h3>일정메모</h3>
	</div>



</body>