<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <title>Delete Confirmation</title>
    <script>
        function confirmDelete() {
            var result = confirm("�����Ͻðڽ��ϱ�?");
            if (result) {
                // �θ� â ���ΰ�ħ
                window.opener.location.reload();
                // �˾� â �ݱ�
                window.close();
            } else {
                // �˾� â �ݱ�
                window.close();
            }
        }
        // �������� �ε�� �� ���� Ȯ�� â�� ���ϴ�.
        window.onload = confirmDelete;
    </script>
</head>
<body>
</body>
</html>