<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="abuttonnonymous"></script>
<link rel="stylesheet" href="/resources/css/myGbookList.css">
</head>

<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>

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
<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/myPage/myGbookList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize) {
        var url = "${pageContext.request.contextPath}/myPage/myGbookList";
        url = url + "?page=" + page
        url = url + "&range=" + range;
        location.href = url;
    }
    //다음 버튼 이벤트
    function fn_next(page, range, rangeSize) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/myPage/myGbookList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        location.href = url;
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
						<h2 style="margin: 0 0 20px -150px;">나의 방명록</h2>
					</div>
				</caption>
				<thead class="table-title">
					<tr>

						<th scope="col">장소</th>
						<th scope="col">내용</th>
						<th scope="col">등록날짜</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${gbookList}" var="gbook">
						<tr>
							<td>${gbook.place_name}</td>
							<td>${gbook.gbook_content}</td>
							<td><fmt:formatDate value="${gbook.gbook_date}"
									pattern="yyyy/MM/dd" /></td>
							<script>
								function goToPlaceDetail(placeNo) {
									var url = "${pageContext.request.contextPath}/place/?place_no="
											+ placeNo;
									window.location.href = url;
								}
							</script>
							<td>
								<form action="/myPage/goToPlaceDetail" method="post">
									<input type="hidden" name="place_no" value="${gbook.place_no}" />
									<button type="button"
										onclick="goToPlaceDetail('${gbook.place_no}')"
										style="background-color: #fff; border-color: #fff; border-style: none;">
										<i class="fa-solid fa-pen" style="color: #000000;"></i>
									</button>
								</form>
							</td>
							<td>
								<form action="/myPage/gbookDelete" method="get"
									onsubmit="return confirmDelete()">
									<input type="hidden" name="place_no" value="${gbook.place_no}" />
									<input type="hidden" name="gbook_no" value="${gbook.gbook_no}" />
									<button type="submit"
										style="background-color: #fff; border-color: #fff; border-style: none;">
										<i class="fa-solid fa-trash-can fa-lg" style="color: #000000;"></i>
									</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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