<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>FrmPopup.htm : 팝업창</title>
<link rel="stylesheet" href="/resources/css/schedule_show.css">
</head>

<body>
<div class="normal_manage_board_modal">
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
    </script>

    <div class="top">
        <div class="subject">Schedule</div>
    </div>

    <div class="bottom">
        <div class="info">* 변경 혹은 삭제된 일정은 복구할 수 없습니다.</div>

        <form role="form" name="schedule_modify" action="modify" method="post">
            <input type="hidden" name="year" value="${today_info.search_year}" />
            <input type="hidden" name="month" value="${today_info.search_month-1}" />
            <div class="contents">
                <ul>
                    <input type="hidden" name="schedule_no" value="${schedule_show.schedule_no}" />
                    <li>
						<div class="text_subject">장소 :</div>
						<div class="text_desc">
							<select name="place_no" class="text_type1">
							<option value="${schedule_show.place_no}">${schedule_show.place_name}</option>
							<c:forEach var="i" begin="0" end="${place.size()-1}">
								<option value="${place[i].PLACE_NO}">${place[i].place_name}</option>
							</c:forEach>
							</select>
						</div>
					</li>
                    <li>
                        <div class="text_subject">날짜 :</div>
                        <div class="text_desc">
                            <input type="text" name="schedule_date" class="text_type1" id="testDatepicker" readonly="readonly" value="${schedule_show.schedule_date}" />
                        </div>
                    </li>
                    <li>
                        <div class="text_subject">제목 :</div>
                        <div class="text_desc">
                            <textarea name="schedule_title" class="textarea_type1" rows="1" style="resize: none;">${schedule_show.schedule_title}</textarea>
                        </div>
                    </li>
                    <li style="margin-bottom: 75px;">
                        <div class="text_subject">내용 :</div>
                        <div class="text_area_desc">
                            <textarea name="schedule_memo" class="textarea_type1" rows="5">${schedule_show.schedule_memo}</textarea>
                        </div>
                    </li>
                    <li>
                        <div class="text_subject">색상 :</div> 
                        <input class="colorbox" type='color' name='schedule_mycolor' value="${schedule_show.schedule_mycolor}" />
                    </li>
                    <li class="button_li">
                        <div class="managebutton">
                            <button type="submit" class="buttonstyle board_manage_go pointer">수정하기</button>
                            <button type="button" onclick="location.href='/delete?schedule_no=${schedule_show.schedule_no}'" class="buttonstyle2 board_manage_go pointer">삭제하기</button>
                        </div>
                    </li>
                </ul>
            </div>
        </form>
    </div>
</div>
</body>
</html>
