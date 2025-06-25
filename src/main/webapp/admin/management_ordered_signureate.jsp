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
    <%@include file="../includes/link/headLink.jsp"%>
    <link rel="stylesheet" href="css/management.css">
</head>
<body>
<%@include file="menu-admin.jsp"%>
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản Lý Chữ Ký Đơn Hàng</h2>


    <div class="row my-3">
        <div class="col-md-8">
            <c:set var="error" value="${not empty requestScope.error ? requestScope.error : ''}" />
            <c:if test="${not empty error}">
                <script type="text/javascript">
                    Swal.fire({
                        icon: 'error',
                        title: 'Thông báo',
                        text: "${error}"
                    });
                </script>
            </c:if>
        </div>
        <div class="col-md-4">
            <form method="post" action="${pageContext.request.contextPath}/admin/order-signurate" class="d-flex float-end w-100">
                <div class="row w-100">
                    <div class="col-md-8">
                        <input type="number" placeholder="Tìm theo mã đơn hàng" name="idOrder" class="form-control me-2">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                    </div>
                </div>
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
        <c:forEach var="orderSign" items="${requestScope.orderSign}">
            <tr>
                <td>${orderSign.order.id}</td>
                <td>${orderSign.order.user.id}</td>
                <td>${orderSign.orderSignatures.digitalSignature}</td>
                <td>${orderSign.userKeys.publicKey}</td>
                <td>${orderSign.orderSignatures.status}</td>
                <td><a class="btn btn-info" href="${pageContext.request.contextPath}/admin/order-signature-detail?orderId=${orderSign.order.id}">Xem chi tiết</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="d-flex justify-content-center mt-3">
    <%
        int nuPage = Integer.parseInt(request.getAttribute("nuPage").toString());
        int loca = Integer.parseInt(request.getAttribute("loca").toString());
    %>
    <nav>
        <ul class="pagination">
            <%
                if (loca > 1) {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/order-signurate?loca=<%= loca - 1 %>">&laquo;</a>
            </li>
            <%
                }
                for (int i = 1; i <= nuPage; i++) {
                    if (i == loca) {
            %>
            <li class="page-item active">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/order-signurate?loca=<%= i %>"><%= i %></a>
            </li>
            <%
            } else {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/order-signurate?loca=<%= i %>"><%= i %></a>
            </li>
            <%
                    }
                }
                if (loca < nuPage) {
            %>
            <li class="page-item">
                <a class="page-link" href="${pageContext.request.contextPath}/admin/order-signurate?loca=<%= loca + 1 %>">&raquo;</a>
            </li>
            <%
                }
            %>
        </ul>
    </nav>
</div>

<%@include file="../includes/link/footLink.jsp"%>
</body>
</html>
