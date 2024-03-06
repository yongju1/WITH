<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="abuttonnonymous"></script>
    <link rel="stylesheet" href="/resources/css/adminBoardList.css">
    <title>WITH</title>
</head>
<%@ include file="../header.jsp"%>
<%@ include file="../adminSidebar.jsp"%>

<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize,order,keyword) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/admin/adminBoardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&order=" + order;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, searchType, keyword, order) {
        var url = "${pageContext.request.contextPath}/admin/adminBoardList";
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
    function fn_next(page, range, rangeSize,order, keyword) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/admin/adminBoardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&order=" + order;
        url = url + "&keyword=" + keyword;
        location.href = url;
    }
</script>

<body>

            <section>
                <div class="admininfo">
                    <div class="admin">
                        <table class="userlist-table">
                            <caption>
                                <div class="list-title">
                                    <h2>게시판 관리</h2><br>
                                    <div class="list-title2">
                                        <div class="search_bar">
									<form action="/admin/adminBoardList" method="get">
										<div style="display: flex;">
											<input class="form-control" type="text" name="keyword"
												placeholder="작성자, 제목 검색" value="${pagination.keyword}">
											<button class="search-btn" type="submit">
												<i class="fa-fa-search"></i>
												<svg xmlns="http://www.w3.org/2000/svg" width="20"
													height="20" fill="none" stroke="currentColor"
													stroke-linecap="round" stroke-linejoin="round"
													stroke-width="2" class="feather feather-search"
													viewBox="0 0 24 24">
                                                    <defs></defs>
                                                    <circle cx="11"
														cy="11" r="8"></circle>
                                                    <path	
														d="M21 21l-4.35-4.35"></path>
                                                </svg>
											</button>
										</div>
									</form>
								</div>

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
                                    <th scope="col">작성자</th>
                                    <th scope="col">이메일</th>
                                    <th scope="col">답글수</th>
                                    <th scope="col">등록날짜</th>
                                    <th scope="col">삭제</th>
                                </tr>
                            </thead>
                            <tbody>
	                            <c:forEach items="${adminBoardList}" var="m">
	                                <tr>
	                                    <td>${m.board_no}</td>
	                                    <td>${m.board_title}</td>
	                                    <td>${m.user_name}</td>
	                                    <td>${m.user_email}</td>
	                                    <td>${m.comment_cnt}</td>
										<td><fmt:formatDate value="${m.board_date}" pattern="yyyy/MM/dd" /></td>
										<td><form action="/admin/deleteBoard" method="post" onsubmit="return confirmDelete()">
											<input type="hidden" name="board_no" value="${m.board_no}" />
											<button type="submit" style="background-color: #fff; border-color: #fff; border-style: none;">
												<i class="fa-solid fa-trash-can fa-lg" style="color: #000000;"></i>
											</button>
										</form></td>
									</tr>
								</c:forEach>
                            </tbody>
                        </table>

                        <div style="text-align : center;">
			<div id="paginationBox">
			    <ul class="pagination">
			        <c:if test="${pagination.prev}">
			            <li class="page-item">
			                <a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${pagination.order}','${pagination.keyword}')"><<</a>
			            </li>
			        </c:if>
			
			        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
			            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.order}','${pagination.keyword}')"> ${idx} </a></li>
			        </c:forEach>
			
			        <c:if test="${pagination.next}">
			            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}','${pagination.order}','${pagination.keyword}')" >>></a></li>
			        </c:if>
			    </ul>
			</div>
		</div>
                    </div>
                </div>

            </section>
</body>
<script>
function confirmDelete() {
    return confirm("정말로 삭제하시겠습니까?");
 }

document.getElementById("lang").onchange = function() {
	var order = this.value === "old" ? "DESC" : "ASC";
	$.ajax({
		url: "/admin/adminBoardList",
		type: "GET",
		data : {"order" : order} ,
		/* success: function(data, textStatus, xhr) {
			
			document.location.reload(true);
			console.log(data);
		},
		error: function(xhr, status, error) {
			console.log(error);
			alert("실패")
		} */
	});
	location.href = "/admin/adminBoardList?order=" + order;
};

/* function selectBoxChange(order) {
	var order = this.value === "old" ? "DESC" : "ASC";
	
		$.ajax({
			url: "/admin/adminBoardList",
			type: "GET",
			data : {"order" : order} ,
			/* success: function(data, textStatus, xhr) {
				
				document.location.reload(true);
				console.log(data);
			},
			error: function(xhr, status, error) {
				console.log(error);
				alert("실패")
			}
		});
	
} */

 </script>
<footer>

</footer>

</html>