<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="./header.jsp"%>
<%@page import="java.util.Calendar"%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<link rel="stylesheet" href="/resources/css/detail.css">
<script type="text/javascript">
	function confirmDelete() {
		var result = confirm("삭제하시겠습니까?");
		if (result) {
			// 확인 버튼을 눌렀을 때 처리
			alert("삭제가 완료되었습니다.");
			return true;
		} else {
			// 취소 버튼을 눌렀을 때 처리
			alert("취소되었습니다.");
			return false;
		}
	}
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=378312520ec4b7c39fcff4eb6a8a7310&libraries=services,clusterer,drawing"></script>
<script>
    $(document).ready(function(){

		var placeAddress = $("#place_address").data("address")/*  + $("#place_address2").data("address2") */;
    	
    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	
    	mapOption = {
    	    center: new kakao.maps.LatLng(33.25110701, 126.570667), // 지도의 중심좌표
    	    level: 3 // 지도의 확대 레벨
    	};  
    	
    	// 지도를 생성합니다    
    	var map = new kakao.maps.Map(mapContainer, mapOption); 
    	
    	// 주소-좌표 변환 객체를 생성합니다	
    	var geocoder = new kakao.maps.services.Geocoder();
    	
    	// 주소로 좌표를 검색합니다
    	geocoder.addressSearch(placeAddress, function(result, status) {
    	    // 정상적으로 검색이 완료됐으면 
    	     if (status === kakao.maps.services.Status.OK) {
    	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
    	        
    	        // 결과값으로 받은 위치를 마커로 표시합니다
    	        var marker = new kakao.maps.Marker({
    	            map: map,
    	            position: coords
    	        });
    	
    	        // 인포윈도우로 장소에 대한 설명을 표시합니다
    	        var infowindow = new kakao.maps.InfoWindow({
    	            content: '<div style="width:150px;text-align:center;padding:3px 0;">' + "${place.place_name}" + '</div>'
    	        });
    	        infowindow.open(map, marker);
    	
    	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    	        map.setCenter(coords);
    	        
    	        
    	        $(".placePosition").click(function(){
    	        	map.panTo(coords);  
    	        });
    	     }
    	});   	
    });
</script>


<script>
$(document).ready(function() {
        e.preventDefault();  // 기본적인 a 태그의 동작을 막습니다.
        
        var url = $(this).attr('href');
        var placeId = $(this).data('place-id');

        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                // 북마크 추가/삭제가 성공하면, 해당 페이지로 이동
                window.location.href = '/place/?place_no=' + placeId;
            },
            error: function(error) {
                // 에러 처리
                console.error(error);
            }
        });
    });
    
/* 	$(".add").on("click", function(){
		alert("로그인이 필요합니다.")
		location.href="../account/login";
	}) */
});
</script>
<body>

    <div class="detail">
    	<div style="margin-left: 17%; margin-right: 50px;">
	    	<div class="slideshow-container">
	
				<div class="mySlides fade">
				  <div class="numbertext">1 / 3</div>
				  <img src="/resources/img/${place.place_img1}"  width="400px" height="600px">
				  <!-- <div class="text">Caption One</div> -->
				</div>
	
				<div class="mySlides fade">
				  <div class="numbertext">2 / 3</div>
				  <img src="/resources/img/${place.place_img2}"  width="400px" height="600px">
				  <!-- <div class="text">Caption Two</div> -->
				</div>
	
				<div class="mySlides fade">
				  <div class="numbertext">3 / 3</div>
				  <img src="/resources/img/${place.place_img3}" width="400px" height="600px">
				  <!-- <div class="text">Caption Three</div> -->
				</div>
	
			</div>
			<br>
	
			<div style="margin-left: 33%; text-align:center">
			  <span class="dot"></span> 
			  <span class="dot"></span> 
			  <span class="dot"></span> 
			</div>
    	</div>
        <%-- <img src="/resources/img/${place.place_img}" width="25%"> --%>
        <%-- <div class="detail-header">
            <h2>${place.place_name}
            <!-- <i class="fa-regular fa-bookmark fa-sm" style="color: #000;"></i>
            <button>일정추가</button> -->
            </h2> --%>
            <div class="detail-header">
	            <div class="detailbox">
	           
	            	<h2>${place.place_name}</h2>
		            <c:choose>
								<c:when test="${not empty sessionScope.user}">
									<c:choose>
										<c:when test="${bookList.contains(place.PLACE_NO)}">
											<a
												href="${pageContext.request.contextPath}/place/bookmarkRemove?&place_no=${place.PLACE_NO}"
												class="bookmarkBtn" data-place-id="${place.PLACE_NO}"
												style="color: '#ff0000';">
												<i class="fa-solid fa-bookmark fa-xl" style="color: #000;"></i>
											</a>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/place/bookmarkAdd?&place_no=${place.PLACE_NO}"
												class="bookmarkBtn" data-place-id="${place.PLACE_NO}"
												style="color: '#ffffff';"> <i
												class="fa-regular fa-bookmark fa-xl" style="color: #000;"></i>
											</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a style="color: '#ffffff';" class="click" href="http://localhost:8080/account/login"><i class="fa-regular fa-bookmark fa-xl" style="color: #000;"></i></a>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty sessionScope.user}">
						            <button type="button"
									class="buttonstyle board_move openMask_board_move pointer"
									style="height: 30px; width: 130px;">일정 추가</button>
								</c:when>
								<c:otherwise>
								 	<button type="button" class="click" onclick='location.href="../account/login"'>일정 추가</button>
								</c:otherwise>
							</c:choose>
	        	</div>
	        	
	            <br>
	            <div class="placeinfo">
		            <h2 style="font-size: 20px; margin-top: 5%; margin-bottom: 30px;">${place.place_detail}</h2>
		            <br>
		            <h3>카테고리</h3>
		            <p>${place.place_type eq 0?'식당':'카페'}</p>
		            <br>
		            <h3>영업시간</h3>
		            <p>${place.place_bhours}</p>
		            <br>
		            <h3>휴무일</h3>
		            <p>${place.place_dayoff}</p>
		            <br>
		            <h3>추천 메뉴</h3>
		            <p>${place.place_menu}</p>
		            <br>
		            <h3>주소</h3>
		            <p>${place.place_adr1} ${place.place_adr2}</p>
	        	</div>
        	</div>
        <!-- <div class="detailbox">
            <i class="fa-regular fa-bookmark fa-lg" style="color: #000;"></i>
            <button>일정추가</button>
        </div> -->
    </div>
    <hr style="width: 90%; margin:6% auto; height:1px; background:#d3d3d3; border:0;">
    <div class="detail2">
        <div id="map_box">
        	<div id="map" style="width:500px; height:400px;"></div>
        	<button class="placePosition" ><i class="far fa-dot-circle" style="color:#fff;"></i> 가게 위치로</button>
        	<div id="place_address" data-address="${place.place_adr1}">${place.place_adr1} ${place.place_adr2}</div>
        	<div id="place_address2" data-address2="${place.place_adr2}"></div>
        </div>
        <div class="gbook" style="padding: 10px;">
            <table class="gbook-table">
				<label style="margin-left: 40%; font-size: 28px;">방명록</label>
				<thead class="table-title">
					<tr>
						<th scope="col">no</th>
						<th scope="col">작성자</th>
						<th scope="col">내용</th>
						<th scope="col">방문일</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${gbookList.size()-1 < 0 }">
							<!-- <h2 style="margin: 200px auto">해당 장소가 없습니다.</h2> -->
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="0" end="${gbookList.size()-1 }">

								<tr>
									<td>${i+1}</td>
									<td>${gbookList[i].user_name}</td>
									<td>${gbookList[i].gbook_content}</td>
									<td><fmt:formatDate value="${gbookList[i].gbook_date}"
											pattern="yyyy/MM/dd" /></td>
									<c:if
										test="${sessionScope.user.user_no eq gbookList[i].user_no}">
										<td>
											<button
												onclick="window.open('../myPage/gbookUpdate?gbook_no=${gbookList[i].gbook_no}', 'update_Gbook', 'width=500,height=300'); return false;"
												style="background-color: #fff; border: none;">
												<i class="fa-solid fa-pen" style="color: #000000;"></i>
											</button>
										</td>
									</c:if>
									<c:if
										test="${sessionScope.user.user_no eq gbookList[i].user_no}">
										<td>
											<form action="/place/gbookDelete" method="post"
												onsubmit="return confirmDelete()">
												<input type="hidden" name="place_no"
													value="${gbookList[i].place_no}" /> <input type="hidden"
													name="gbook_no" value="${gbookList[i].gbook_no}" />
												<button type="submit"
													style="background-color: #fff; border-color: #fff; border-style: none;">
													<i class="fa-solid fa-trash-can fa-lg"
														style="color: #000000;"></i>
												</button>
											</form>
										</td>
									</c:if>
								</tr>

							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<form action="/gbook/add" method="post">
				<div class="form">
				<c:choose>
				<c:when test="${not empty sessionScope.user}">
					<input type="hidden" name="user_no" value="${user.user_no}">
					<input type="hidden" name="place_no" value="${place.PLACE_NO}">
					<input type="text" name="gbook_content">
					<button type="submit">입력</button>
				</c:when>
				</c:choose>
				</div>
			</form>
        </div>
    </div>
    <script type="text/javascript">
    var slideIndex = 0;
    showSlides();

    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
           slides[i].style.display = "none";  
        }
        slideIndex++;
        if (slideIndex > slides.length) {slideIndex = 1}    
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }
        slides[slideIndex-1].style.display = "block";  
        dots[slideIndex-1].className += " active";
        setTimeout(showSlides, 3000); // Change image every 3 seconds
    }
    </script>
    <!-- 모달 창 -->
<div id="mask_board_move" style="display: none;"></div>
<div class="normal_move_board_modal" style="display: none;">
    <div class="top">
        <div class="close">x</div>
        <div class="subject">일정추가하기</div>
    </div>
    <div class="bottom">
        <div class="info">* 순번은 해당 날짜안에서 순서대로 입력이 됩니다.(하루에 최대 4개의 스케줄만 등록할 수 있습니다.)</div>
        <form name="schedule_add" action="/schedule_add">
            <div class="contents">
                <ul>
                    <input type="hidden" name="place_no" value="${place.PLACE_NO}" />
                    <li>
                        <div class="text_subject">날짜 :</div>
                        <div class="text_desc">
                            <input type="text" name="schedule_date" class="text_type1" id="testDatepicker" readonly="readonly" />
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
                        <div class="text_subject">색상 :</div> 
                        <input class="colorbox" type='color' name='schedule_mycolor' value='' />
                    </li>
                    <li class="button_li">
                        <button type="button" class="buttonstyle board_move_go pointer" onclick="scheduleAdd();">등록하기</button>
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
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".click").on("click", function(){
		alert("로그인이 필요한 페이지 입니다.")
	})
})
</script>