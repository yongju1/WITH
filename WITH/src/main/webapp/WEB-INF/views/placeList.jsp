<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/placeList.css">
    <title>WITH</title>
</head>

<%@ include file="./header.jsp"%>

<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize, keyword) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/place/searchPlace";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, keyword) {
        var url = "${pageContext.request.contextPath}/place/searchPlace";
        url = url + "?page=" + page
        url = url + "&range=" + range;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
    //다음 버튼 이벤트
    function fn_next(page, range, rangeSize, keyword) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/place/searchPlace";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
</script>

<body>
<div>

    <div class="main">
        <div class="content">
        <c:choose>
        	<c:when test="${placeList.size()-1 < 0 }">
        	<h2 style="margin: 200px auto">조회 결과가 없습니다.</h2>
        	</c:when>
        	<c:otherwise>
        	<c:forEach var="i" begin="0" end="${placeList.size()-1}">
        	
       		<%-- <c:choose>
        		<c:when test="${i==0}">
	            	<div class="infobox" style="margin-left: 0;" onclick="location.href='http://localhost:8080/place/?place_no=${placeList[i].PLACE_NO}'">
	            </c:when>
	            <c:otherwise>
	            	<div class="infobox" onclick="location.href='http://localhost:8080/place/?place_no=${placeList[i].PLACE_NO}'">
	            </c:otherwise>
            </c:choose> --%>
	            <div class="infobox" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${placeList[i].PLACE_NO}'">
	                <img src="/resources/img/${placeList[i].place_img1}">
	                <div style="margin-left: 5%; margin-top: 3%;">
	                    <span style="font-size: 18px;">${placeList[i].place_name}</span>
	                    <c:choose>
								<c:when test="${not empty sessionScope.user}">
									<c:choose>
										<c:when test="${bookList.contains(placeList[i].PLACE_NO)}">
											<a
												href="${pageContext.request.contextPath}/place/keywordbookmarkRemove?&place_no=${placeList[i].PLACE_NO}&keyword=${keyword}"
												class="bookmarkBtn" data-place-id="${placeList[i].PLACE_NO}"
												style="color: '#ff0000';">
												<i class="fa-solid fa-bookmark fa-lg" style="color: #ffffff;"></i>
											</a>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/place/keywordbookmarkAdd?&place_no=${placeList[i].PLACE_NO}&keyword=${keyword}"
												class="bookmarkBtn" data-place-id="${placeList[i].PLACE_NO}"
												style="color: '#ffffff';">
												
												<i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i>
											</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a style="color: '#ffffff';" class="click" href="${pageContext.request.contextPath}/account/login"><i class="fa-regular fa-bookmark fa-lg" style="color: #FFFFFF;"></i></a>
								</c:otherwise>
							</c:choose>
	                    <div style="margin-top: 5%;">
	                        <span style="font-size: 15px;">${placeList[i].place_adr1}${placeList[i].place_adr2}</span>
	                    </div>
	                </div>
	            </div>
	        </c:forEach>
	        </c:otherwise>
	        </c:choose>
	        </div>
	        </div>
	        <div style="text-align : center;">
			<div id="paginationBox">
			    <ul class="pagination">
			        <c:if test="${pagination.prev}">
			            <li class="page-item">
			                <a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.keyword }')"><<</a>
			            </li>
			        </c:if>
			
			        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
			            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.keyword }')"> ${idx} </a></li>
			        </c:forEach>
			
			        <c:if test="${pagination.next}">
			            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}', '${pagination.keyword }')" >>></a></li>
			        </c:if>
			    </ul>
			</div>
		</div>
        </div>
        
</body>

<script type="text/javascript">
$(document).ready(function(){
	$(".click").on("click", function(){
		alert("로그인이 필요한 페이지 입니다.")
	})
})
</script>