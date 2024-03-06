<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <title>Delete Confirmation</title>
    <script>
        function confirmDelete() {
            var result = confirm("삭제하시겠습니까?");
            if (result) {
                // 부모 창 새로고침
                window.opener.location.reload();
                // 팝업 창 닫기
                window.close();
            } else {
                // 팝업 창 닫기
                window.close();
            }
        }
        // 페이지가 로드될 때 삭제 확인 창을 띄웁니다.
        window.onload = confirmDelete;
    </script>
</head>
<body>
</body>
</html>