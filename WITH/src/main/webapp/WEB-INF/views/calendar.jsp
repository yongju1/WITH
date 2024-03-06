<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ include file="./header.jsp"%>
<%@ include file="./mySidebar.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html lang="ko">
<head>
<title>캘린더</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<!-- jquery datepicker -->
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- jquery datepicker 끝 -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<%-- <script src="${path}/resources/js/board.js"></script>
 --%>
<script type="text/javaScript" language="javascript"></script>
<script
	src="https://www.lgkids.co.kr/es_all/plugins/jscolor-2.0.5/jscolor.js"></script>

<script>
	var schedule_no; // 스케줄 번호
	var user_no; // 사용자 번호
	var place_no; // 장소 번호
	var schedule_title; // 스케줄 제목
	var schedule_date; // 스케줄 날짜
	var schedule_memo; // 스케줄 메모
	var schedule_mycolor; // 스케줄 색상
</script>
<link rel="stylesheet" href="/resources/css/calendar.css">
</head>

<body>

	<form name="calendarFrm" id="calendarFrm" action="" method="GET">
		<input type="hidden" name="year" value="${today_info.search_year}" />
		<input type="hidden" name="month" value="${today_info.search_month-1}" />
		
		<script>
			/* 스케줄 등록시 등록완료 팝업창 */
			var message = "${message}";
			console.log(message);
			if (message != "") {
				alert(message);
			}
		</script>
		<div class="calendar">

			<!--날짜 네비게이션  -->
			<div class="navigation">
				<a class="before_after_year"
					href="./calendar?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
					&lt;&lt; <!-- 이전해 -->
				</a> <a class="before_after_month"
					href="./calendar?year=${today_info.before_year}&month=${today_info.before_month}">
					&lt; <!-- 이전달 -->
				</a> <span class="this_month"> &nbsp;${today_info.search_year}. <c:if
						test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
				</span> <a class="before_after_month"
					href="/calendar?year=${today_info.after_year}&month=${today_info.after_month}">
					<!-- 다음달 --> &gt;
				</a> <a class="before_after_year"
					href="/calendar?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
					<!-- 다음해 --> &gt;&gt;
				</a>
			</div>
			<div class="today_button_div">
				<button type="button" class="buttonstyle"
					onclick="javascript:location.href='/calendar'"
					style="height: 30px; width: 80px;">Today</button>
				<button type="button"
					class="buttonstyle board_move openMask_board_move pointer"
					style="height: 30px; width: 130px;">일정추가하기</button>
			</div>
			<table class="calendar_body">

				<thead>
					<tr bgcolor="000">
						<td class="day sun">Sun</td>
						<td class="day">Mon</td>
						<td class="day">Tue</td>
						<td class="day">Wed</td>
						<td class="day">Thu</td>
						<td class="day">Fri</td>
						<td class="day sat">Sat</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="dateList" items="${dateList}"
							varStatus="date_status">
							<c:choose>
								<c:when test="${dateList.value=='today'}">
									<c:if test="${date_status.index%7==0}">
										<tr>
									</c:if>
									<td class="today">
										<div class="date">
								</c:when>
								<c:when test="${date_status.index%7==6}">
									<td class="sat_day">
										<div class="sat">
								</c:when>
								<c:when test="${date_status.index%7==0}">
					</tr>
					<tr>
						<td class="sun_day">
							<div class="sun">
								</c:when>
								<c:otherwise>
									<td class="normal_day">
										<div class="date">
								</c:otherwise>
								</c:choose>
								${dateList.date}
							</div>
							<div>
								<!-- 달력에 일정 띄우고 클릭 시 수정/삭제 창 띄우는 코드 -->
								<c:forEach var="scheduleList"
									items="${dateList.schedule_data_arr}"
									varStatus="schedule_data_arr_status">

									<a
										href="/schedule_show?schedule_no=${scheduleList.schedule_no}"
										onclick="window.open(this.href, '_blank', 'width=550,height=600,left=680%, top=200%, toolbars=no,scrollbars=no'); return false;"
										class="date_subject"
										style="color: ${scheduleList.schedule_mycolor}">
										${scheduleList.schedule_title}
										${schedule.place_name} </a>
									<br>

								</c:forEach>
							</div>
						</td>
						</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
	<div id="mask_board_move"></div>
	<div class="normal_move_board_modal">
		<script>
			$(function() {
				$("#testDatepicker")
						.datepicker(
								{

									dateFormat : "yy-mm-dd",
									changeMonth : true,
									changeYear : true,
									dayNames : [ '일요일','월요일', '화요일', '수요일', '목요일',
											'금요일', '토요일' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									monthNamesShort : [ '1', '2', '3', '4',
											'5', '6', '7', '8', '9', '10',
											'11', '12' ]
								});
			});
			function scheduleAdd() {
				var schedule_add_form = document.schedule_add;
				if (schedule_add_form.schedule_date.value == ""
						|| schedule_add_form.schedule_date.value == null) {
					alert("날짜를 입력해주세요.");
					schedule_add_form.schedule_date.focus();
					return false;
				} else if (schedule_add_form.schedule_title.value == ""
						|| schedule_add_form.schedule_title.value == null) {
					alert("제목을 입력해주세요.");
					schedule_add_form.schedule_date.focus();
					return false;
				}
				schedule_add_form.submit();
			}
		</script>
		<div class="top" style="">
			<div class="close">x</div>
			<div class="subject">일정추가하기</div>
		</div>

		<div class="bottom">
			<div class="info">* 순번은 해당 날짜안에서 순서대로 입력이 됩니다.(하루에 최대 4개의 스케줄만
				등록할 수 있습니다.)</div>
			<form name="schedule_add" action="/schedule_add">
				<div class="contents">
					<ul>
						<li>
							<div class="text_subject">장소 :</div>
							<div class="text_desc">
								<select name="place_no" class="text_type1" >
								<c:forEach var="i" begin="0" end="${place.size()-1}">
									<option value="${place[i].PLACE_NO}">${place[i].place_name}</option>
								</c:forEach>
								</select>
							</div>
						</li>
						<li>
							<div class="text_subject">날짜 :</div>
							<div class="text_desc">
								<input type="text" name="schedule_date" class="text_type1"
									id="testDatepicker" readonly="readonly" />
							</div>
						</li>
						<li>
							<div class="text_subject">제목 :</div>
							<div class="text_desc">
								<input type="text" name="schedule_title" class="text_type1" />
							</div>
						</li>
						<li style="margin-bottom: 70px;">
							<div class="text_subject">내용 :</div>
							<div class="text_area_desc">
								<textarea name="schedule_memo" class="textarea_type1" rows="5"></textarea>
							</div>
						</li>
						<li>
							<div class="text_subject">색상 :</div> <input class="colorbox"
							type='color' name='schedule_mycolor' value='' />
						</li>
						<li class="button_li">
							<button type="button" class="buttonstyle board_move_go pointer"
								onclick="scheduleAdd();">등록하기</button>
						</li>
					</ul>
				</div>
			</form>
		</div>

	</div>
	<script>
		$(function() {
			// 모달 열기 버튼에 클릭 이벤트 추가
			$(".board_move").click(function() {
				$("#mask_board_move").fadeIn(1000);
				$("#mask_board_move").fadeTo("slow", 0.8);
				// 모달 창 보이기
				$(".normal_move_board_modal").fadeIn(1000);
				return false;
			});

			// 모달 닫기 버튼에 클릭 이벤트 추가
			$(".close").click(function() {
				$("#mask_board_move").fadeOut();
				$(".normal_move_board_modal").fadeOut();
				return false;
			});
		});
	</script>
</body>
</html>