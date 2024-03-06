<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/mySidebar.css">
</head>

<body>
    <div class="con">
        <div class="container">
            <nav>
                <div class="sidebar">
                    <div class="icon-bar mypage-bar">
                    	<a href="../myPage/myPage">
	                       <button class="myinfo-btn" style="background-color: #fff; border-color: #fff; border-style: none;">
	                           <i class="fa-solid fa-address-card fa-2xl" style="color: black; float: none;"></i>
	                           <p>내 정보</p>
	                       </button>
                       </a>
                       <br>
                       <a href="../calendar">
	                       <button class="scheldule-btn" style="background-color: #fff; border-color: #fff; border-style: none;">
	                           <i class="fa-regular fa-calendar fa-2xl" style="color: black; float: none;"></i>
	                           <p>내 일정</p>
	                       </button>
                       </a>
                       <br>
                       <a href="../myPage/myBoardList">
	                       <button class="list-btn" style="background-color: #fff; border-color: #fff; border-style: none;">
	                           <i class="fa-regular fa-pen-to-square fa-2xl" style="color: black;float: none;"></i>
	                           <p>게시물</p>
	                       </button>
                       </a>
                       <br>
                       <a href="../myPage/myBookMark">
	                       <button class="bmark-btn" style="background-color: #fff; border-color: #fff; border-style: none;">
	                           <i class="fa-regular fa-bookmark fa-2xl" style="color: black; float: none;"></i>
	                           <p>북마크</p>
	                       </button>
                       </a>
                       <br>
                       <a href="../myPage/myGbookList">
	                       <button class="gbook-btn" style="background-color: #fff; border-color: #fff; border-style: none;">
	                           <i class="fa-regular fa-comment fa-2xl" style="color: black;float: none;"></i>
	                           <p>방명록</p>
	                           
	                       </button>
                       </a>
                    </div>
                </div>
            </nav>
         </div>
       </div>
</body>