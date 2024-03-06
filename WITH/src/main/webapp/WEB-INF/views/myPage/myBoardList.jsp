<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="abuttonnonymous"></script>
<link rel="stylesheet" href="/resources/css/myBoardList.css">
</head>

<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>

<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize, keyword) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/myPage/myBoardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, searchType, keyword, order) {
        var url = "${pageContext.request.contextPath}/myPage/myBoardList";
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
    function fn_next(page, range, rangeSize,keyword) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/myPage/myBoardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
</script>

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

<script type="text/javascript">
	function confirmUpdate() {
		var result = confirm("수정하시겠습니까?");
		if (result) {
			// 확인 버튼을 눌렀을 때 처리
			return true;
		} else {
			// 취소 버튼을 눌렀을 때 처리
			alert("취소되었습니다.");
			return false;
		}
	}
</script>

<body>
	<section>
		<div class="myinfo">

			<table class="writelist-table">
				<caption>
					<div class="list-title">
						<h2 style="margin: 0 0 20px -150px;">글 목록</h2>
						<div class="list-title2">
						<form action="/myPage/myBoardList" action="get">
							<div class="search_bar">
								<input class="form-control" type="text" name="keyword" placeholder="검색">

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
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록날짜</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${boardList}" var="write">
						<tr>
							<td><a href="${pageContext.request.contextPath}/myPage/myBoardDetail/${write.board_no}" style="text-decoration: none; color:black;">${write.board_no}</a></td>
							<td><a href="${pageContext.request.contextPath}/myPage/myBoardDetail/${write.board_no}" style="text-decoration: none; color:black;">${write.board_title}</a></td>
							<td><fmt:formatDate value="${write.board_date}"
									pattern="yyyy/MM/dd" /></td>

							<td><form action="/myPage/myBoardDetail/${write.board_no}"
									onsubmit="return confirmUpdate()">
									<button type="submit"
										style="background-color: #fff; border-color: #fff; border-style: none;">
										<i class="fa-solid fa-pen" style="color: #000000;"></i>
									</button>
								</form></td>

							<td><form action="/myPage/boardDelete" method="post"
									onsubmit="return confirmDelete()">
									<input type="hidden" name="board_no" value="${write.board_no}" />
									<button type="submit"
										style="background-color: #fff; border-color: #fff; border-style: none;">
										<i class="fa-solid fa-trash-can fa-lg" style="color: #000000;"></i>
									</button>
								</form></td>
						</tr>
					</c:forEach>
				</tbody>

			</table>

         <div style="margin-left:78%;">
			<div id="paginationBox">
			    <ul class="pagination">
			        <c:if test="${pagination.prev}">
			            <li class="page-item">
			                <a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${pagination.keyword}')"><<</a>
			            </li>
			        </c:if>
			
			        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
			            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.order}','${pagination.keyword}')"> ${idx} </a></li>
			        </c:forEach>
			
			        <c:if test="${pagination.next}">
			            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}','${pagination.keyword}')" >>></a></li>
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
       url: "/myPage/myBoardList",
       type: "GET",
       data : {"order" : order} ,
    });
    location.href = "${pageContext.request.contextPath}/myPage/myBoardList?order=" + order;
 };
</script>