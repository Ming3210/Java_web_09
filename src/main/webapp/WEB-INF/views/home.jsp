<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 16/05/2025
  Time: 8:21 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách phim</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f9fc;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        table {
            width: 90%;
            max-width: 900px;
            margin: 0 auto 20px;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #4299e1;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f6fb;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a, .pagination strong {
            display: inline-block;
            margin: 0 6px;
            padding: 8px 12px;
            color: #4299e1;
            text-decoration: none;
            border-radius: 4px;
            border: 1px solid transparent;
            transition: background-color 0.3s, border-color 0.3s;
        }
        .pagination a:hover {
            background-color: #3182ce;
            color: white;
            border-color: #3182ce;
        }
        .pagination strong {
            font-weight: bold;
            background-color: #3182ce;
            color: white;
            border-color: #3182ce;
            cursor: default;
        }
    </style>
</head>
<body>

<h1>Danh sách phim</h1>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Thể loại</th>
        <th>Đạo diễn</th>
        <th>Thời lượng</th>
        <th>Ngôn ngữ</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="movie" items="${movies}">
        <tr>
            <td>${movie.id}</td>
            <td><a href="<c:url value='/movies/${movie.id}'/>">${movie.title}</a></td>

            <td>${movie.genre}</td>
            <td>${movie.director}</td>
            <td>${movie.duration} phút</td>
            <td>${movie.language}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<c:if test="${totalPages > 1}">
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">Previous</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">Next</a>
        </c:if>
    </div>
</c:if>

</body>
</html>
