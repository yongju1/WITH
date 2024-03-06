<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/myBookMark.css">
</head>

<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>
<script>

	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${pageContext.request.contextPath}/myPage/myBookMark";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		location.href = url;
	}
	
	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize) {
		var url = "${pageContext.request.contextPath}/myPage/myBookMark";
		url = url + "?page=" + page
		url = url + "&range=" + range;
		location.href = url;
	}
	
	//다음 버튼 이벤트
	function fn_next(range, rangeSize) {
	    var page = parseInt((range * rangeSize)) + 1;
	    var range = parseInt(range) + 1;
	    var url = "${pageContext.request.contextPath}/myPage/myBookMark";
	    url = url + "?page=" + page;
	    url = url + "&range=" + range;
	    location.href = url;
	}
</script>
<body>
	<section>
		<div class="myinfo" style="margin-right: 50%;">

			<div>
				<h2 style="margin: 0 0 40px 450px;">북마크</h2>
			</div>

			<div class="container-wrapper" style="margin-right: 100%;">
			<c:choose>
				<c:when test="${bookMark.size()-1 < 0 }">
	        		<h2 style="margin: 200px auto">북마크 장소가 없습니다.</h2>
	        	</c:when>
	        	<c:otherwise>
					<c:forEach begin="0" var="i" end="${bookMark.size()-1}">
						<div class="myinfobox">
						<a href="../place/?place_no=${bookMark[i].PLACE_NO}">
							<img src="/resources/img/${bookMark[i].place_img1}">
							</a>
							<div style="margin-left: 5%; margin-top: 3%;">
								<span style="font-size: 18px; color: white;">${bookMark[i].place_name}</span>
								 <a href="${pageContext.request.contextPath}/myPage/bookmarkRemove?&place_no=${bookMark[i].PLACE_NO}" class="bookmarkBtn" data-place-id="${bookMark[i].PLACE_NO}" style="color:'#ff0000';">
	                   			<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
	                   			</a>
								<div style="margin-top: 5%;">
			                        <span style="font-size: 15px; color: white;">${bookMark[i].place_adr1} ${bookMark[i].place_adr2}</span>
			                    </div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
			<!-- pagination{s} -->
		<div style="text-align : center;">
			<div id="paginationBox">
			    <ul class="pagination">
			        <c:if test="${pagination.prev}">
			            <li class="page-item">
			                <a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')"><<</a>
			            </li>
			        </c:if>
			
			        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
			            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>
			        </c:forEach>
			
			        <c:if test="${pagination.next}">
			            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}')" >>></a></li>
			        </c:if>
			    </ul>
			</div>
		</div>
		</div>

		
	</section>
</body>