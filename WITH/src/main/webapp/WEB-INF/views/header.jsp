<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/resources/css/header.css">
    <title>WITH</title>
</head>

<script type="text/javascript">
	$(document).ready(function(){
		
		$(".join-btn").on("click", function(){
			location.href="../../account/login";
		})
		
		$(".logout_btn").on("click", function(){
			location.href="../../account/logout";
		})
		
		$(".profile_btn").on("click", function(){
			location.href="../../myPage/myPage";
		})
		
		$(".bookmark-btn").on("click", function(){
			location.href="../../myPage/myBookMark";
		})
		
		$(".location-btn").on("click", function(){
			//window.open("http://localhost:8080/place/allLocation");
			location.href="../../place/allLocation";
		})
		
		$(".admin-btn").on("click", function(){
			location.href="../../admin/adminUserInfo";
		})
		
	})
</script>

<body>
<!-- <form name='mainForm' method="post" action="/account/login"> -->
    <!-- <div class="app-container"> -->
        <div class="app-header">
            <div class="app-header-left">
                <a href="/"><p class="app-name"><img src=../../resources/img/with.png width="180px"></p></a>
                <form action="/place/categoryPlace" method="get">
                <div class="app-header-middle">
                    <a href="../place/categoryPlace?cate=0">맛집</a>
                    <a href="../place/categoryPlace?cate=1">카페</a>
                    <a>지역별</a>
                    <a href="/board/boardList">커뮤니티</a>
                </div>
                </form>
                <form action="/place/searchPlace" method="get">
                <div class="search" style="width: 350px;">
                    <input type="text" name="keyword" placeholder="검색어 입력">
                    <button class="searchbtn" type="submit">
                    <!-- <a style="text-decoration: none; color: black; right: 20px;"> -->
                        <i class="fa-solid fa-magnifying-glass fa-lg" style="color: #000000;"></i>
                       <!--  </a> -->
                    </button>
                </div>
                </form>
            </div>
            <div class="app-header-right">
            	<c:if test="${user != null && user.user_type==1}">
	            	<button class="admin-btn">
	                    <i class="fa-solid fa-gear fa-2xl" style="color: #000000;"></i>
	                    <span class="tooltip">관리자</span>
	                </button>
	            </c:if>
            	<button class="location-btn">
                    <i class="fa-solid fa-location-dot fa-2xl" style="color: #000000;"></i>
                    <span class="tooltip">지도</span>
	            </button>
	            
            	<c:if test="${user != null }">
	                <button class="bookmark-btn">
	                    <i class="fa-solid fa-bookmark fa-2xl" style="color: #000000;"></i>
	                    <span class="tooltip">북마크</span>
	                </button>
	                
	                <button class="profile_btn" title="마이페이지">
	                    <i class="fa-solid fa-circle-user fa-2xl" style="color: #000000;"></i>
	                    <span class="tooltip">마이페이지</span>
	                </button>
	                
	                <button class="logout_btn">
	                    <i class="fa-solid fa-arrow-right-from-bracket fa-2xl" style="color: #000000;"></i>
	                    <span class="tooltip">로그아웃</span>
	                </button>
                </c:if>
                <c:if test="${user == null}">
	                <button class="join-btn">
	                    <i class="fa-solid fa-user-plus fa-2xl" style="color: #000000;"></i>
	                    <span class="tooltip">로그인/회원가입</span>
	                </button>
                </c:if>
            </div>
        </div>
        <hr>
   <!--  </div> -->
<!-- </form> -->
</body>