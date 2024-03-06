<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="abuttonnonymous"></script>
<link rel="stylesheet" href="/resources/css/gbookList.css">
</head>

<%@ include file="../header.jsp"%>

<script>
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize, keyword) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${pageContext.request.contextPath}/Board/gbookList";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + keyword;
		location.href = url;
	}
	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, searchType, keyword, order) {
		var url = "${pageContext.request.contextPath}/Board/gbookList";
		url = url + "?page=" + page
		url = url + "&range=" + range;
		url = url + "&order=" + order;
		url = url + "&keyword=" + keyword;

		/* if(document.getElementById("lang").onchange){
			var order = this.value === "old" ? "DESC" : "ASC";
			url = url + order;
		} */
		location.href = url;
	}
	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize, keyword) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "${pageContext.request.contextPath}/Board/gbookList";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + keyword;
		location.href = url;
	}
</script>
<body>
	<section>
		<div class="myinfo">

			<table class="gbooklist-table">
				<caption>
					<div class="list-title">
						<h2>방명록 목록</h2>
						<div class="list-title2">
							<form action="/Board/gbookList" action="get">
								<div class="search_bar">
									<input class="form-control" type="text" name="keyword"
										placeholder="검색">

									<button class="search-btn" type="submit">
										<i class="fa-fa-search"></i>
										<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
											fill="none" stroke="currentColor" stroke-linecap="round"
											stroke-linejoin="round" stroke-width="2"
											class="feather feather-search" viewBox="0 0 24 24">
                                                    <defs></defs>
                                                    <circle cx="11"
												cy="11" r="8"></circle>
                                                    <path
												d="M21 21l-4.35-4.35"></path>
                                                </svg>
										</a>
									</button>
								</div>
							</form>
						</div>
						<div class="list-title2">

							<div class="dropdown">
								<select name="languages" id="lang" class="pl">
									<option selected>선택하세요</option>
									<option value="old">최근 순</option>
									<option value="new">오래된 순</option>
								</select>
							</div>
						</div>
					</div>
				</caption>
				<thead class="table-title">
					<tr>
						<th scope="col">장소명</th>
						<th scope="col">장소사진</th>
						<th scope="col">내용</th>
						<th scope="col">작성자</th>
						<th scope="col">등록날짜</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${gbookList}" var="gbook">
						<tr>
							<td onclick="goToPlaceDetail(${gbook.place_no})">${gbook.place_name}</td>
							<script>
								function goToPlaceDetail(placeNo) {
									var url = "${pageContext.request.contextPath}/place/?place_no="
											+ placeNo;
									window.location.href = url;
								}
							</script>
							<td onclick="goToPlaceDetail(${gbook.place_no})" style="padding:10px;"><img src="../resources/img/${gbook.place_img1}" width="80px" height="80px;"></td>
							<script>
								function goToPlaceDetail(placeNo) {
									var url = "${pageContext.request.contextPath}/place/?place_no="
											+ placeNo;
									window.location.href = url;
								}
							</script>
							<td>${gbook.gbook_content}</td>
							<td>${gbook.user_name}</td>
							<td><fmt:formatDate value="${gbook.gbook_date}"
									pattern="yyyy/MM/dd" /></td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div style="margin-left: 50%">
				<div id="paginationBox">
					<ul class="pagination">
						<c:if test="${pagination.prev}">
							<li class="page-item"><a class="page-link" href="#"
								onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${pagination.keyword}')"><<</a>
							</li>
						</c:if>

						<c:forEach begin="${pagination.startPage}"
							end="${pagination.endPage}" var="idx">
							<li
								class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
								class="page-link" href="#"
								onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.order}','${pagination.keyword}')">
									${idx} </a></li>
						</c:forEach>

						<c:if test="${pagination.next}">
							<li class="page-item"><a class="page-link" href="#"
								onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}','${pagination.keyword}')">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</section>
</body>
<script>
	document.getElementById("lang").onchange = function() {
		var order = this.value === "old" ? "DESC" : "ASC";
		$.ajax({
			url : "/board/gbookList",
			type : "GET",
			data : {
				"order" : order
			},
		});
		location.href = "/board/gbookList?order=" + order;
	};
</script>