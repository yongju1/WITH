<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="abuttonnonymous"></script>
<link rel="stylesheet" href="/resources/css/adminPlaceList.css">
<title>WITH</title>
</head>
<%@ include file="../header.jsp"%>
<%@ include file="../adminSidebar.jsp"%>
<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/admin/adminPlaceList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, searchType, keyword) {
        var url = "${pageContext.request.contextPath}/admin/adminPlaceList";
        url = url + "?page=" + page
        url = url + "&range=" + range;
        location.href = url;
    }
    //다음 버튼 이벤트
    function fn_next(page, range, rangeSize) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/admin/adminPlaceList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        location.href = url;
    }
</script>
<body>
<form name="readForm" role="form" method="post">
	<input type="hidden" name="keyword" value="${pagination.keyword}">
</form>
	<h2 style="margin-left: 850px;">장소 관리</h2>
	<br>
	<div class="main">
		<div class="content">
		<c:choose>
        	<c:when test="${placeInfoList.size()-1 < 0 }">
        	<h2 style="margin: 200px auto">조회 결과가 없습니다.</h2>
        	</c:when>
        	<c:otherwise>
			<c:forEach var="i" begin="0" end="${placeInfoList.size()-1}">
				<div class="infobox">
					<img src="/resources/img/${placeInfoList[i].place_img1}" onclick="location.href='${pageContext.request.contextPath}/place/?place_no=${placeInfoList[i].PLACE_NO}'">
					<div style="margin: 5%;">
						<span style="font-size: 18px;">${placeInfoList[i].place_name}</span>
						<form action="/admin/deletePlace" method="post" onsubmit="return confirmDelete()">
							<input type="hidden" name="place_no" value="${placeInfoList[i].PLACE_NO}" />
							<button type="submit" class="s" style="background-color: #000; border-color: #000; border-style: none;">
								<i class="fa-solid fa-trash-can fa-lg" style="color: white;"></i>
							</button>
						</form>
						<a onclick="location.href='${pageContext.request.contextPath}/admin/adminPlaceUpdate/?place_no=${placeInfoList[i].PLACE_NO}'">
							<i class="fa-solid fa-pencil fa-lg" style="color: white;"></i>
						</a>
						<div style="margin-top: 10%;">
							<span style="font-size: 15px; ">${placeInfoList[i].place_adr1} ${placeInfoList[i].place_adr2}</span>
						</div>
					</div>
				</div>
			</c:forEach>
			</c:otherwise>
			</c:choose>
		</div>
		<div style="text-align: center; margin-top: 20px;">
			<button class="upload" style="padding: 5px 20px; margin-left: 750px;" onclick="location.href='${pageContext.request.contextPath}/admin/adminPlaceAdd'">등록</button>
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
</body>
<script>
function confirmDelete() {
	return confirm("정말로 삭제하시겠습니까?");
}
</script>
<footer> </footer>

</html>