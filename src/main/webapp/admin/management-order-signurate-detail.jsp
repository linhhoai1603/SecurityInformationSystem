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
            <th>Hành Động</th>
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
                <td>
                    <button class="btn btn-primary btn-sm edit-order-item"
                            data-bs-toggle="modal"
                            data-bs-target="#editOrderItem"
                            data-detail-id="${detail.id}"
                            data-order-id="${requestScope.order.id}"
                            data-quantity="${detail.quantity}">Chỉnh sửa
                    </button>
                </td>
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
                    <table class="table table-bordered table-striped custom-table">
                        <thead>
                        <tr>
                            <th>Mã Chữ Ký</th>
                            <th>Chữ Ký Số</th>
                            <th>Trạng Thái Xác Minh</th>
                            <th>Thời Gian Tạo</th>
                            <th>Mã Khóa</th>
                            <th>Khóa Công Khai</th>
                            <th>Hành Động</th>
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
                                <td>
                                    <button class="btn btn-primary btn-sm edit-status-order-sign"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editStatusOrderSign"
                                            data-order-id="${requestScope.order.id}"
                                            data-signature-id="${signature.id}"
                                            data-status="${requestScope.order.status}">Chỉnh sửa
                                    </button>
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
    <!-- Modal chỉnh sửa chi tiết sản phẩm -->
    <div class="modal fade" id="editOrderItem" tabindex="-1" aria-labelledby="editOrderItemModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editOrderItemModalLabel">Chỉnh sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/order-signature-detail?method=editOrderItem"
                          method="POST">
                        <input type="hidden" name="detailId" id="detailId">
                        <input type="hidden" name="orderId" id="orderId">
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal chỉnh sửa trạng thái đơn hàng -->
    <div class="modal fade" id="editStatusOrderSign" tabindex="-1" aria-labelledby="editStatusOrderSignModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editStatusOrderSignModalLabel">Chỉnh sửa trạng thái đơn hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/order-signature-detail?method=editStatusOrderSign"
                          method="POST">
                        <input type="hidden" name="orderId" id="statusOrderId">
                        <input type="hidden" name="signatureId" id="signatureId">
                        <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="verified"
                                       value="CONFIRMED" required>
                                <label class="form-check-label" for="verified">Verified (Đã xác nhận)</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="nonVerified"
                                       value="PENDING">
                                <label class="form-check-label" for="nonVerified">Non-Verified (Chưa xác minh)</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="verifyAgain"
                                       value="PENDING">
                                <label class="form-check-label" for="verifyAgain">Verify-Again (Yêu cầu xác minh
                                    lại)</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    // Lưu trữ nút kích hoạt modal
    let triggerButton = null;
    // Lưu nút kích hoạt khi mở modal
    document.querySelectorAll('.edit-order-item, .edit-status-order-sign').forEach(function (button) {
        button.addEventListener('click', function () {
            triggerButton = this;
        });
    });
    // Điền dữ liệu vào modal chỉnh sửa chi tiết sản phẩm
    document.getElementById('editOrderItem').addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var detailId = button.getAttribute('data-detail-id');
        var orderId = button.getAttribute('data-order-id');
        var quantity = button.getAttribute('data-quantity');
        // var price = button.getAttribute('data-price');

        var modal = this;
        modal.querySelector('#detailId').value = detailId;
        modal.querySelector('#orderId').value = orderId;
        modal.querySelector('#quantity').value = quantity;
        // modal.querySelector('#price').value = parseFloat(price).toFixed(2);
    });
    // Điền dữ liệu vào modal chỉnh sửa trạng thái đơn hàng
    document.getElementById('editStatusOrderSign').addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget;
        var orderId = button.getAttribute('data-order-id');
        var signatureId = button.getAttribute('data-signature-id');
        var status = button.getAttribute('data-status');

        var modal = this;
        modal.querySelector('#statusOrderId').value = orderId;
        modal.querySelector('#signatureId').value = signatureId;
        var radio = modal.querySelector(`input[name="status"][value="${status}"]`);
        if (radio) radio.checked = true;
    });
    // // Quản lý tiêu điểm khi đóng modal
    // document.querySelectorAll('.modal').forEach(function (modal) {
    //     modal.addEventListener('hidden.bs.modal', function (event) {
    //         var triggerButton = document.activeElement.closest('.modal') ?
    //             document.querySelector('.edit-order-item, .edit-status-order-sign') :
    //             document.activeElement;
    //         if (triggerButton) {
    //             triggerButton.focus();
    //         } else {
    //             document.querySelector('.container').focus();
    //         }
    //     });
    // });
    // Chuyển tiêu điểm về nút kích hoạt hoặc container khi nhấn "Hủy"
    function moveFocusToTrigger() {
        if (triggerButton) {
            triggerButton.focus();
        } else {
            document.querySelector('.container').focus();
        }
    }

    // Xóa tiêu điểm khỏi nút "Hủy" hoặc nút đóng khi modal bắt đầu đóng
    document.querySelectorAll('.modal .btn-secondary, .modal .btn-close').forEach(function (button) {
        button.addEventListener('click', function () {
            moveFocusToTrigger();
        });
    });
</script>

<%@include file="../includes/link/footLink.jsp" %>
</body>
</html>
