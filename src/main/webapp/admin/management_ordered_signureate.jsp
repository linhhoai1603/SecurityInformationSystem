<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 6/25/2025
  Time: 1:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý chữ ký đơn hàng</title>
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
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản Lý Chữ Ký Đơn Hàng</h2>


    <div class="row my-3">
        <%--        <div class="col-md-8">--%>
        <%--            <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />--%>
        <%--            <c:if test="${not empty error}">--%>
        <%--                <script type="text/javascript">--%>
        <%--                    Swal.fire({--%>
        <%--                        icon: 'error',--%>
        <%--                        title: 'Thông báo',--%>
        <%--                        text: "${error}"--%>
        <%--                    });--%>
        <%--                </script>--%>
        <%--            </c:if>--%>
        <%--        </div>--%>
        <div class="col-md-4">
            <form class="d-flex" action="order-signurate?method=searchOrderSign" method="POST">
                <input type="hidden" name="method" value="searchOrderSign">
                <input class="form-control me-2" type="search" name="inputName" placeholder="Tìm kiếm sản phẩm theo ID"
                       aria-label="Search" required>
                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
            </form>
        </div>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <table class="table table-bordered table-striped custom-table">
        <thead>
        <tr>
            <th>Mã Đơn Hàng</th>
            <th>Mã Người Dùng</th>
            <th>Signurate</th>
            <th>Key Xác Nhận</th>
            <th>Trang thái chữ ký</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="sign" items="${requestScope.orderSign}">
            <tr>
                <td>${sign.order.id}</td>
                <td>${sign.order.user.id}</td>
                <td>
                    <div class="code-box">
                            ${sign.digitalSignature}
                    </div>
                </td>
                <td>
                    <div class="code-box">
                            ${sign.userKeys.publicKey}
                    </div>
                </td>
                <td>${sign.verified}</td>
                <td><form id="detailForm" action="order-signurate" method="POST" style="display: inline;">
                    <input type="hidden" name="method" value="detailOrderSign">
                    <input type="hidden" name="id" value="${sign.order.id}">
                    <button type="submit" class="btn btn-warning">Xem chi tiết</button>
                </form></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%@include file="../includes/link/footLink.jsp" %>
</body>
</html>
