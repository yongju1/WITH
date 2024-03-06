<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="abuttonnonymous"></script>
    <link rel="stylesheet" href="/resources/css/boardSidebar.css">
</head>

<script>

function cateBtn(str) {
    window.location.href="/board/boardList?cate=" + str;
 }
 
 function orderSelect(str) {
    window.location.href="/board/boardList?cate=" + str;
 }
 </script>

<div class="con">

        <div class="container">
            <nav>
                <div class="sidebar">
                    <div class="icon-bar mypage-bar">
                    <form action="/board/boardList" method="get">
                       <button class="myinfo-btn" onclick="cateBtn('')" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-border-all fa-2xl" style="color: black;"></i>
                           
                           <p>전체</p>
                       </button>
                       </form>
                       <br>
                       <form action="/board/boardList" method="get">
						<input type="hidden" name="cate" value=0>
                       <button class="scheldule-btn" onclick="cateBtn(0)" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-map-location-dot fa-2xl" style="color: black;"></i>
                           <p>맛집</p>
                       </button>
                       </form>
                       <br>
                       <input type="hidden" name="cate" value=1>
                       <button class="list-btn" onclick="cateBtn(1)" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-mug-hot fa-2xl" style="color: black;"></i>
                           <p>카페</p>
                       </button>
                       <br>
                       <input type="hidden" name="cate" value=2>
                       <button class="bmark-btn" onclick="cateBtn(2)" style="background-color: #fff; border-color: #fff; border-style: none;">
                           <i class="fa-solid fa-comments fa-2xl" style="color: black;"></i>
                           <p>잡담</p>
                       </button>
                    </div>
                </div>
            </nav>
            </div>
            </div>