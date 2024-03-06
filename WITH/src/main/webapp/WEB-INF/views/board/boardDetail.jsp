<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
   crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/boardDetail.css">
</head>

<%@ include file="../header.jsp"%>

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
<body>

   <div class="write">
      <h1 style="text-align: center; margin: 30px 0 30px 0;">게시물 상세</h1>


      <h3>작성자: ${boardDetail.user_name}</h3>
      <br>

      <h3>제목</h3>
    
      <br>
      <p class="type">${boardDetail.board_type==0? "장소":boardDetail.board_type==1? "카페":"잡담"}</p>
      <br>
      <p>글 번호: ${boardDetail.board_no}</p>
      
      <br>

      <textarea class="qnatext1" rows=1 readonly>${boardDetail.board_title}</textarea>

      <div>
         <br>
         <h3>내용</h3>
         <br>
         <textarea class="qnatext2" rows=10 readonly>${boardDetail.board_content}</textarea>
      </div>
      
      <div class="image">
      <br>
      
      <c:if test="${boardDetail.board_img == null}">
      
      </c:if>
      <c:if test="${boardDetail.board_img != null}">
      
      <img src="/resources/img/board/${boardDetail.board_img}" alt="게시물 사진" width=70%; height=auto;>
      </c:if>
      </div>
      <br>
      <div class="postBtn">
      <a href="${path}/board/boardUpdate?board_no=${boardDetail.board_no}"
				role="button" class="post">수정</a> 
      <a href="${path}/board/boardDelete?board_no=${boardDetail.board_no}"
				role="button" class="post">삭제</a>
	  </div>
<br><br><br><br>
      
      <hr style="margin-bottom:10px;">
      <!— 댓글 —>
		<div class="gbook">
			<h3 class="comment_count" style="margin-bottom: 10px;">댓글 ${boardDetail.comment_cnt}개</h3>
		    <hr>
		    
		      <div class="comment_element">
		      	<table>
			         <c:forEach items="${commentList}" var="comment">
	 					<tr class="commentTr">
		 					<td style="width:40px;">${comment.comment_no}</td>
		  					<td style="width:60px;">${comment.user_name}</td>
							<td style="width:500px; margin-left:5px;margin-right:5px;">${comment.comment_content}</td>
							<td style="width:100px;"><fmt:formatDate value="${comment.comment_date}" pattern="yyyy/MM/dd" /></td>
							<c:if
								test="${sessionScope.user.user_no eq comment.user_no}">
								<td style="width:40px;">
									<button
										onclick="window.open('../board/commentUpdate?comment_no=${comment.comment_no}', 'update_comment', 'width=600,height=600'); return false;"
										style="background-color: #fff; border: none;">
										<i class="fa-solid fa-pen" style="color: #000000;"></i>
									</button>
								</td>
							</c:if>
							
							<c:if
								test="${sessionScope.user.user_no eq comment.user_no}">
								<td style="width:40px;">
									<form action="/board/commentDelete" method="post"
										onsubmit="return confirmDelete()">
										<input type="hidden" name="comment_no"
											value="${comment.comment_no}" />
											<input type="hidden" name="board_no"
											value="${boardDetail.board_no}" />
										<button type="submit"
											style="background-color: #fff; border-color: #fff; border-style: none;">
											<i class="fa-solid fa-trash-can fa-lg"
												style="color: #000000;"></i>
										</button>
									</form>
								</td>
							</c:if>
						</tr>
						
					 </c:forEach>
			  	</table>
		      </div>
		      
		      
		      
		      <form action="/board/commentInsert" method="post">
		         <div class="inputarea">
		            <input type="hidden" name="user_no" value="${user.user_no}">
					<input type="hidden" name="board_no" value="${boardDetail.board_no}">
					<input type="text" name="comment_content" class="textInput">
		            <button type="submit" class="upload">댓글등록</button>
		         </div>
		      </form>
		</div>
   </div>
</body>