<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 6/26/2025
  Time: 9:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết chữ ký đơn hàng</title>
    <%@include file="../includes/link/headLink.jsp" %>
    <link rel="stylesheet" href="css/management.css">
    <style>
        .code-box {
            max-width: 100%;
            max-height: 80px;
            overflow: auto;
            background-color: #f8f9fa;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
            word-break: break-all;
        }
    </style>
</head>
<body>
<%@include file="menu-admin.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4 text-center">Chi Tiết Đơn Hàng - Mã Đơn Hàng:${requestScope.order.id}</h2>

    <!-- Thông tin đơn hàng -->
    <div class="row mb-4">
        <div class="col-md-6">
            <p><strong>Mã Đơn Hàng:</strong> ${requestScope.order.id}</p>
            <p><strong>Thời Gian Đặt:</strong> ${requestScope.order.timeOrdered}</p>
            <p><strong>Trạng Thái Đơn Hàng:</strong> ${requestScope.order.status}</p>
            <p><strong>Tổng Giá Trị:</strong> <fmt:formatNumber value="${requestScope.order.lastPrice}" type="number"/>₫
            </p>
        </div>
    </div>

    <!-- Bảng chi tiết đơn hàng -->
    <h4 class="mb-3">Chi Tiết Đơn Hàng</h4>
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th>Mã Sản Phẩm</th>
            <th>Tên Sản Phẩm</th>
            <th>Màu sắc</th>
            <th>Loại</th>
            <th>Số Lượng</th>
            <th>Giá Tiền</th>
            <th>Tổng Giá</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${requestScope.order.listOfDetailOrder}">
            <tr>
                <td>${detail.id}</td>
                <td>${detail.style.product.name}</td>
                <td>${detail.style.name}</td>
                <td>${detail.style.product.category.name}</td>
                <td>${detail.quantity}</td>
                <td><fmt:formatNumber value="${detail.style.product.price.lastPrice}" type="number"/>₫</td>
                <td><fmt:formatNumber value="${detail.totalPrice}" type="number"/>₫</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

    <%--    Thông tin chữ ký    --%>
    <h4 class="mb-3">Thông Tin Chữ Ký</h4>
    <div class="row mb-4">
        <div class="col-md-12">
            <c:choose>
                <c:when test="${not empty requestScope.orderSign}">
                    <%--                    <p><strong>Mã Chữ Ký:</strong> ${requestScope.orderSign.id}</p>--%>
                    <%--                    <p><strong>Chữ Ký Số:</strong>${requestScope.orderSign.digitalSignature}</p>--%>
                    <%--                    <p><strong>Trạng Thái Xác Minh:</strong> ${requestScope.orderSign.verified}</p>--%>
                    <%--                    <p><strong>Thời Gian Tạo:</strong> ${requestScope.orderSign.create_at}</p>--%>
                    <%--                    <p><strong>Mã Khóa:</strong> ${requestScope.orderSign.userKeys.id}</p>--%>
                    <%--                    <p><strong>Khóa Công Khai:</strong>${requestScope.orderSign.userKeys.publicKey}</p>--%>
                    <table class="table table-bordered table-striped custom-table">
                        <thead>
                        <tr>
                            <th>Mã Chữ Ký</th>
                            <th>Chữ Ký Số</th>
                            <th>Trạng Thái Xác Minh</th>
                            <th>Thời Gian Tạo</th>
                            <th>Mã Khóa</th>
                            <th>Khóa Công Khai</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="signature" items="${requestScope.orderSign}">
                            <tr>
                                <td>${signature.id}</td>
                                <td>
                                    <div class="code-box">
                                            ${signature.digitalSignature}
                                    </div>
                                </td>

                                <td>${signature.verified}</td>
                                <td>${signature.create_at}</td>
                                <td>${signature.userKeys.id}</td>
                                <td>
                                    <div class="code-box">
                                            ${signature.userKeys.publicKey}
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="text-danger">Chưa có chữ ký cho đơn hàng này.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!-- Nút quay lại -->
    <div class="row">
        <div class="col-md-12 text-center mt-4">
            <a href="${pageContext.request.contextPath}/admin/order-signurate" class="btn btn-secondary">Quay lại danh
                sách Chữ ký xác nhận</a>
        </div>
    </div>
</div>

<%@include file="../includes/link/footLink.jsp" %>
</body>
</html>
