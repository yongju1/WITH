<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
 <title>Modify Confirmation</title>
    <script>
        function confirmModify() {
            var result = confirm("수정하시겠습니까?");
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
        // 페이지가 로드될 때 수정 확인 창을 띄웁니다.
        window.onload = confirmModify;
    </script>
</head>
<body>
</body>
</html>