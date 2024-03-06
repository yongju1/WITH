<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/myBoardDetail.css">
</head>

<%@ include file="../header.jsp"%>

<script type="text/javascript">

	function confirmUpdate() {
		var result = confirm("수정하시겠습니까?");
		if (result) {
			// 확인 버튼을 눌렀을 때 처리
			return true;
			document.myBoardUpdate.submit();
		} else {
			// 취소 버튼을 눌렀을 때 처리
			alert("취소되었습니다.");
			return false;
		}
	}
	
</script>

<script>

function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
            var currentImage = document.getElementById('current-image');
            currentImage.src = e.target.result;
        }

        reader.readAsDataURL(input.files[0]);
    }
}
</script>

<body>

	<div class="write">

		<form action="/myPage/boardUpdate" name="myBoardUpdate" method="post" enctype="multipart/form-data">
			<h1 style="text-align: center; margin: 30px 0 30px 0;">게시물 상세</h1>

			<h3>작성자: ${board.user_name}</h3>
			<br>

			<h3>제목</h3>
			<br>

			<textarea class="qnatext1" rows=1 name="board_title">${board.board_title}</textarea>

			<div>
				<br>
				<h3>내용</h3>
				<br>
				<textarea class="qnatext2" rows=10 name="board_content">${board.board_content}</textarea>
			</div>

			<br>
			<div class="image-section">
				<h3>이미지</h3>
				<br> <img id="current-image"
					src="/resources/img/${board.board_img}" alt="게시물 사진" width="40%;">
				<br> <br>

				<div class="input-img">
					<input type="text" class="upload-name" value="이미지를 업로드 하세요">
					<label for="upload-file">파일선택</label> <input type="file"
						name="upload" id="upload-file" onchange="previewImage(this);">
				</div>
			</div>
				
			<br> <br>

			<hr>
			<h3 style="margin: 15px 0px 15px 0px;">댓글 ${cnt}개</h3>
			<hr>
			<hr>
			<c:forEach items="${comments}" var="comment">
				<div class="comment_element">
					<p class="comment_writer">${comment.user_name}</p>
					<p class="comment_detail">${comment.comment_content}</p>
					<p class="comment_time">${comment.comment_date}</p>
				</div>
			</c:forEach>

			<br> <br>


			<div class="btnarea">
				<input type="hidden" name="board_no" value="${board.board_no}" />
				<button type="submit" style="margin-left: 310px; margin-right: 10px;"
					onclick="return confirmUpdate()">수정하기</button>
				<div>
						<button type="button" style="margin-left: 10px;" onclick="location.href='../../myPage/myBoardList'">목록</button>
				</div>
			</div>
			
		</form>
</body>