<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Chi tiết phim</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      padding: 20px;
    }

    .container {
      max-width: 1000px;
      margin: auto;
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h2, h3 {
      color: #2c3e50;
    }

    .movie-info {
      background-color: #f9f9f9;
      padding: 20px;
      border-radius: 6px;
      margin-bottom: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th {
      background-color: #3498db;
      color: white;
      padding: 12px;
    }

    td {
      padding: 12px;
      border-bottom: 1px solid #ddd;
    }

    .seat-selection {
      padding: 10px;
      background: #ecf0f1;
      margin-top: 10px;
      border-radius: 6px;
    }

    .seat-selection label {
      margin-right: 15px;
      display: inline-block;
      width: 80px;
      margin-bottom: 10px;
    }

    .submit-btn {
      background: #2ecc71;
      color: white;
      border: none;
      padding: 8px 16px;
      margin-top: 10px;
      cursor: pointer;
      border-radius: 4px;
    }

    .submit-btn:hover {
      background: #27ae60;
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

  </style>
</head>
<body>
<div class="container">
  <h2>Chi tiết phim: ${movie.title}</h2>

  <div class="movie-info">
    <p><strong>Thể loại:</strong> ${movie.genre}</p>
    <p><strong>Đạo diễn:</strong> ${movie.director}</p>
    <p><strong>Mô tả:</strong> ${movie.description}</p>
  </div>

  <h3>Lịch chiếu</h3>

  <c:choose>
    <c:when test="${not empty schedules}">
      <c:forEach var="s" items="${schedules}">
        <table>
          <thead>
          <tr>
            <th>Thời gian</th>
            <th>Phòng</th>
            <th>Ghế trống</th>
            <th>Định dạng</th>
          </tr>
          </thead>
          <tr>
            <td><fmt:formatDate value="${s.showTime}" pattern="dd/MM/yyyy HH:mm"/></td>
            <td>${s.screenRoomId}</td>
            <td>${s.availableSeats}</td>
            <td>${s.format}</td>
          </tr>
        </table>

        <!-- FORM ĐẶT VÉ -->
        <form action="${pageContext.request.contextPath}/tickets/book" method="post" class="seat-selection">
          <input type="hidden" name="scheduleId" value="${s.id}" />
          <input type="hidden" name="customerId" value="${sessionScope.user.id}" />

          <p><strong>Chọn ghế:</strong></p>
          <c:forEach var="i" begin="1" end="20" varStatus="status">
            <c:if test="${i <= s.availableSeats}">
              <label>
                <input type="checkbox" name="seats" value="${i}" />
                Ghế ${i}
              </label>
              <c:if test="${status.count % 5 == 0}"><br/></c:if>
            </c:if>
          </c:forEach>

          <br/>
          <button type="submit" class="submit-btn">Đặt vé</button>
        </form>
        <hr/>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <p>Không có lịch chiếu nào.</p>
    </c:otherwise>
  </c:choose>

  <a href="<c:url value='/home'/>" class="back-link">← Quay lại</a>
</div>
</body>
</html>