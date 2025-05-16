<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 16/05/2025
  Time: 10:40 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kết quả đặt vé</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .back-link:hover {
            background-color: #2980b9;
        }

        .success {
            color: #27ae60;
        }

        .error {
            color: #e74c3c;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="${message.contains('thành công') ? 'success' : 'error'}">${message}</h2>
    <a href="<c:url value='/home'/>" class="back-link">← Quay lại danh sách phim</a>
</div>
</body>
</html>
