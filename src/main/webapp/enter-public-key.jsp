<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 6/7/2025
  Time: 5:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
    <title>Hướng dẫn nhập khóa xác nhận</title>
    <style>
        title {
            color: #2c8b73;
        }
    </style>
</head>
<body>
<%@include file="includes/header.jsp" %>
<%@include file="includes/navbar.jsp" %>

<div class="container mt-5">
    <h3 class="text-center mb-4 title">Hướng dẫn cập nhật key xác nhận</h3>
    <c:if test="${not empty message}">
        <h4 class="${messageType}">${message}</h4>
    </c:if>
    <%--    1. Hướng dẫn    --%>
    <div class="instruction">

    </div>
    <%--    2. Đường dẫn tải file exe   --%>
    <div class="mt-4">
        <a href="tool/SignOrder.exe" class="btn btn-primary" download>Tải công cụ tạo khóa (.exe)</a>
    </div>
    <%--    3. Form nhận public key của người dùng--%>
    <form action="update-public-key" method="post" enctype="multipart/form-data">
        <%--        3.1. Form group nhận dữ liệu dạng text      --%>
        <div class="form-group">
            <label for="manualKey">Nhập khóa xác nhận (thủ công):</label>
            <textarea class="form-control" id="manualKey" name="manualKey" rows="6"
                      placeholder="Dán public key vào đây nếu bạn không dùng file"></textarea>
        </div>
        <%--        3.2. Form group nhận dữ liệu dạng file txt      --%>
        <div class="form-group mt-4">
            <label for="keyFile">Hoặc chọn file .txt chứa public key:</label>
            <input type="file" class="form-control-file" id="keyFile" name="keyFile" accept=".txt">
        </div>

        <button type="submit" class="btn mt-4" style="background: #339C87 ;color: white ">Lưu Khóa Xác Nhận</button>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>

</body>
</html>
