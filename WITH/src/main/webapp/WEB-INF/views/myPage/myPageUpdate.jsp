<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/7c9e4a6a06.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/resources/css/myPageUpdate.css">

<script>
function updateUserInfo() {
		if (confirm("수정하시겠습니까?") == true) {
			var user_email = document.getElementById("user_email");
			var user_id = document.getElementById("user_id");
			var user_phone = document.getElementById("user_phone");
			var user_birth = document.getElementById("user_birth");

			if (user_email.value.trim() == "") {
				alert("이메일를 입력해주세요.");
				user_email.focus();
				return false;
			}

			if (user_id.value.trim() == "") {
				alert("아이디를 입력해주세요.");
				user_id.focus();
				return false;
			}

			if (user_phone.value.trim() == "") {
				alert("핸드폰 번호를 입력해주세요.");
				user_phone.focus();
				return false;
			}

			if (user_birth.value.trim() == "") {
				alert("생년월일을 입력해주세요.");
				user_birth.focus();
				return false;
			}
			
			document.myPageUpdate.submit();
		}
	}
	
	function updatePw(){
		location.href="../myPage/changePw";
	}
	
	
</script>

<script>
function cancelAction() {
	Swal.fire({
		  title: "취소",
		  text: "취소하시겠습니까?",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: '예',
		  cancelButtonText: '아니오',
		}).then((result) => {
		  if (result.isConfirmed) {
		    location.href='${pageContext.request.contextPath}/myPage/myPage';
		  }
		})
}
</script>

</head>
<%@ include file="../header.jsp"%>
<%@ include file="../mySidebar.jsp"%>
<body>
	<section>
		<div class="myinfo">
			<form name="myPageUpdate" role="form" method="post"
				action="/myPage/myPageUpdate">
				<input type="hidden" id="user_name" name="user_name"
					value="${info.user_name}">
				<div style="margin: 0 0 15px 150px;">
					<h2>정보 수정</h2>
					<br>
				</div>

				<div class="mypage">
					<c:if test="${info.user_social_type == 1}">
						<div class="form">
							<div class="in" style="margin: 0 auto;">
								<p class="social_p">소셜로그인 사용자는 이메일 및 아이디 수정이 불가합니다.</p>
							</div>
						</div>
					</c:if>
					<div class="form">
						<label class="te">이메일</label>
						<div class="in">
							<c:if test="${info.user_social_type == 1}">
								<input type="email" class="form-control"
									value="${info.user_email}" name="user_email" readonly />
							</c:if>
							<c:if test="${info.user_social_type == 0}">
								<input type="email" class="form-control"
									value="${info.user_email}" name="user_email" />
							</c:if>
						</div>
					</div>

					<div class="form" style="margin-top: 60px;">
						<label class="te">아이디</label>
						<div class="in">
							<c:if test="${info.user_social_type == 1}">
								<input type="text" class="form-control" value="${info.user_id}" name="user_id" readonly>
							</c:if>
							<c:if test="${info.user_social_type == 0}">
								<input type="text" class="form-control" value="${info.user_id}" name="user_id" />
							</c:if>
						</div>
					</div>

					<div class="form" style="margin-top: 60px;">
						<label class="te">전화번호</label>
						<div class="in">
							<input type="tel" class="form-control" value="${info.user_phone}" oninput="hypenTel(this)" name="user_phone" />
						</div>
					</div>

					<div class="form" style="margin-top: 60px;">
						<label class="te">생년월일</label>
						<div class="in">
							<input type="text" class="form-control" value="${info.user_birth}" name="user_birth" />
						</div>
					</div>
				</div>

				<div class="btn">
					<button type="submit" class="modifybtn" onclick="updateUserInfo()">수정하기</button>
					<div>
						<button type="reset" class="cancelbtn" onclick="cancelAction()">취소</button>
					</div>
				</div>
			</form>
		</div>

	</section>

</body>

<script type="text/javascript">

    const hypenTel = (target) => {
	   target.value = target.value
	     .replace(/[^0-9]/g, '')
	     .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	  }

    </script>

