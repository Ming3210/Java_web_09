<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 15/05/2025
  Time: 5:28 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(120deg, #a1c4fd, #c2e9fb);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.1), 0 10px 10px rgba(0, 0, 0, 0.05);
            padding: 40px;
            width: 400px;
            max-width: 90%;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: #2d3748;
            font-weight: 600;
        }

        .login-header p {
            margin-top: 8px;
            color: #718096;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-size: 14px;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 5px;
            font-size: 14px;
            color: #2d3748;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #4299e1;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .login-btn:hover {
            background-color: #3182ce;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .remember-me input {
            margin-right: 8px;
            cursor: pointer;
        }

        .remember-me label {
            color: #718096;
            font-size: 14px;
            cursor: pointer;
        }

        .extra-links {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
            color: #718096;
        }

        .extra-links a {
            color: #4299e1;
            text-decoration: none;
            transition: color 0.3s;
        }

        .extra-links a:hover {
            color: #3182ce;
        }

        .alert-error {
            background-color: #fed7d7;
            color: #c53030;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h2>Đăng nhập</h2>
        <p>Vui lòng nhập thông tin đăng nhập của bạn</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert-error">
                ${error}
        </div>
    </c:if>

    <form action="<c:url value='/login'/>" method="post">
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" required />
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" required />
        </div>

        <div class="remember-me">
            <input type="checkbox" id="remember" name="remember" />
            <label for="remember">Ghi nhớ đăng nhập</label>
        </div>

        <button type="submit" class="login-btn">Đăng nhập</button>


    </form>
</div>
</body>
</html>