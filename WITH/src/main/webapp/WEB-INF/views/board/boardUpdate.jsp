<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/7c9e4a6a06.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/boardUpload.css">
	
</head>

<%@ include file="../header.jsp"%>

<body>
<div class="all">
  <div class="container">
    <form class="postting_con" method="post" action="${path}/board/boardUpdate?board_no=${data.board_no}">
      <div class="detail_con"  >
      
	      <div class="detail">
	      <p class="title">게시글 수정</p>
	      <label >카테고리: </label>
		        <select id="board_type" class="detail_cate" aria-label="Default select example" name="board_type">
		          <option value="0" selected>맛집추천</option>
		          <option value="1">카페추천</option>
		          <option value="2">잡담</option>
		        </select>
	       </div>
	       <div class="detail">
	       <label>제목</label>
        		<input id="board_title" type="text" name="board_title" value="${data.board_title}">
           </div>
          <div class="text_con">
          <label>내용</label>
            <input id="board_content" type="text" name="board_content" style="height:200px; margin-bottom:20px;"value="${data.board_content}">
          </div>
          </div>
          
          <div class="button_con">
	        <button class="post" onclick="location.href='../board/boardList'">취소</button>
	     	<button type="submit" class="post">수정</button>
	  </div>
      <input type="hidden" id="user_no" name="user_no" value="${user.user_no}">
	      </form>
      </div>
  </div>
</body>
