<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
 <title>Modify Confirmation</title>
    <script>
        function confirmModify() {
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
        window.onload = confirmModify;
    </script>
</head>
<body>
</body>
</html>