<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="abuttonnonymous"></script>
    <link rel="stylesheet" href="/resources/css/adminBoardList.css">
<!--     <link rel="stylesheet" href="/resources/css/boardList.css"> -->
     <link rel="stylesheet" href="/resources/css/mySidebar.css">

    <title>WITH</title>
</head>
<%@ include file="../header.jsp"%>

<script>
    //이전 버튼 이벤트
    function fn_prev(page, range, rangeSize,order,keyword,cate) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;
        var url = "${pageContext.request.contextPath}/board/boardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&order=" + order;
        url = url + "&keyword=" + keyword;
        url = url + "&cate=" + cate;
        location.href = url;
    }
    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, searchType, keyword, order,cate) {
        var url = "${pageContext.request.contextPath}/board/boardList";
        url = url + "?page=" + page
        url = url + "&range=" + range;
        url = url + "&order=" + order;
        url = url + "&keyword=" + keyword;
        url = url + "&cate=" + cate;
        
        /* if(document.getElementById("lang").onchange){
        	var order = this.value === "old" ? "DESC" : "ASC";
        	url = url + order;
        } */
        location.href = url;
    }
    //다음 버튼 이벤트
    function fn_next(page, range, rangeSize,order, keyword, cate) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;
        var url = "${pageContext.request.contextPath}/board/boardList";
        url = url + "?page=" + page;
        url = url + "&range=" + range;
        url = url + "&order=" + order;
        url = url + "&keyword=" + keyword;
        url = url + "&cate=" + cate;
        location.href = url;
    }
    
    function cateBtn(str) {
        window.location.href="/board/boardList?keyword=" + str;
     }
     
     function orderSelect(str) {
        window.location.href="/board/boardList?keyword=" + str;
     }

</script>

<body>
<div class="con">
        <div class="container">

<nav>
                <div class="sidebar">
                    <div class="icon-bar mypage-bar">
                       <button class="myinfo-btn" onclick="cateBtn('')" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-border-all fa-2xl" style="color: black;"></i>
                           <p>전체</p>
                       </button>
                       <br>
                       <button class="scheldule-btn" onclick="cateBtn('맛집')" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-map-location-dot fa-2xl" style="color: black;"></i>
                           <p>맛집</p>
                       </button>
                       <br>
                       <button class="list-btn" onclick="cateBtn('카페')" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-mug-hot fa-2xl" style="color: black;"></i>
                           <p>카페</p>
                       </button>
                       <br>
                       <button class="bmark-btn" onclick="cateBtn('잡담')" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-comments fa-2xl" style="color: black;"></i>
                           <p>잡담</p>
                       </button>
                    </div>
                </div>
            </nav>
</div>
       </div>

            <section>
                <div class="admininfo">
                    <div class="admin">
                        <table class="userlist-table">
                            <caption>
                                <div class="list-title">
                                    <h2 style=" margin-left: 0px; text-align: center; font-size:30px;">자유게시판</h2><br>
                                    <div class="list-title2">
                                        <div class="search_bar">
									<form action="/board/boardList" method="get">
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
												<option value="new">최근순</option>
												<option value="">인기순</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </caption>
                            <thead class="table-title">
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">조회수</th>
                                    <th scope="col">등록날짜</th>
                                </tr>
                            </thead>
                            <tbody>
	                            <c:forEach items="${boardList}" var="m">
	                                <tr>
	                                    <td><a href="${path}/board/boardDetail?board_no=${m.board_no}" style="text-decoration:none; color:black;">${m.board_no}</a></td>
	                                    <td>${m.user_name}</td>
	                                    <td><a href="${path}/board/boardDetail?board_no=${m.board_no}" style="text-decoration:none; color:black;">${m.board_title}</a></td>
	                                    <td>${m.board_view}</td>
										<td><fmt:formatDate value="${m.board_date}" pattern="yyyy/MM/dd" /></td>
									</tr>
								</c:forEach>
                            </tbody>
                        </table>
                        
                        <div class="p_button">
						    <a href="<c:url value='../board/boardUpload' />" role="button" class="postting">글쓰기</a> <!-- 글쓰기 버튼 -->
						 </div>

                        <div style="text-align : center;">
			<div id="paginationBox">
			    <ul class="pagination">
			        <c:if test="${pagination.prev}">
			            <li class="page-item">
			                <a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${pagination.order}','${pagination.keyword}','${pagination.cate}')"><<</a>
			            </li>
			        </c:if>
			
			        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
			            <li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.order}','${pagination.keyword}','${pagination.cate}')"> ${idx} </a></li>
			        </c:forEach>
			
			        <c:if test="${pagination.next}">
			            <li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}','${pagination.range}', '${pagination.rangeSize}','${pagination.order}','${pagination.keyword}','${pagination.cate}')" >>></a></li>
			        </c:if>
			    </ul>
			</div>
		</div>
                    </div>
                </div>

            </section>
</body>
<script>

document.getElementById("lang").onchange = function() {
	var order = this.value === "new" ? "최근순" : "인기순";
	$.ajax({
		url: "/board/boardList",
		type: "GET",
		data : {"order" : order} ,
	});
	location.href = "/board/boardList?order=" + order;
};


 </script>
<footer>

</footer>

</html>