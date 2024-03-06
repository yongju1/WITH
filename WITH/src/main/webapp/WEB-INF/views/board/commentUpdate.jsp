<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>댓글 수정하기</title>
<!-- 추가된 CSS 파일 -->
<link rel="stylesheet" href="/resources/css/gbookUpdate.css">
</head>
<body>
	<div class="updateGbook">
		<div class="top">
			<div class="subject">댓글 수정</div>
		</div>
		
		<div class="bottom">
			<form role="form" name="updateGbook" action = "commentModify" method ="post">
				<div class="contents">
					<ul>
						<li>
							<div class="text_desc">
							<input type="hidden" name="comment_no" value="${comment.comment_no}">
								<textarea class="textarea_type1" rows="1"
									style="resize: none;" name="comment_content">${comment.comment_content}</textarea>
							</div>
						<li class="button_li">
							<div class="managebutton">
								<button type="submit"
									class="buttonstyle board_manage_go pointer">수정하기</button>
							</div>
						</li>
					</ul>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
