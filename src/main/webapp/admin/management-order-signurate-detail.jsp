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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                            data-bs-target="#editOrderItemModal"
                            data-quantity="${detail.quantity}"
                            data-detail-id="${detail.id}"
                            data-order-id="${detail.idOrder}">Chỉnh sửa
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <%--    Modal--%>
    <div class="modal fade" id="editOrderItemModal" tabindex="-1" aria-labelledby="editOrderItemModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editOrderItemModalLabel">Chỉnh sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="infoOrderItem"
                          action="${pageContext.request.contextPath}/admin/manager-order-sign-detail?method=editOrderItem"
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
                                        <%--                                    <button class="btn btn-primary btn-sm verify-order-sign">Xác minh--%>
                                        <%--                                    </button>--%>
                                    <button class="btn btn-primary btn-sm verify-order-sign" data-bs-toggle="modal"
                                            data-bs-target="#verifySignatureModal"
                                            data-signature-id="${signature.id}"
                                            data-order-id="${requestScope.order.id}"
                                            data-digital-signature="${signature.digitalSignature}"
                                            data-public-key="${signature.userKeys.publicKey}"
                                            data-create-at="${signature.create_at}">Xác minh
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

    <div class="modal fade" id="verifySignatureModal" tabindex="-1" aria-labelledby="verifySignatureModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="verifySignatureModalLabel">Xác minh chữ ký: Mã <span
                            id="signatureIdDisplay"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Thông tin chữ ký -->
                    <div class="signature-details-item">
                        <p><strong>Mã Chữ Ký:</strong> <span id="signatureId"></span></p>
                        <p><strong>Chữ Ký Số:</strong><br><code class="code-box" id="digitalSignature"></code></p>
                        <p><strong>Khóa Công Khai:</strong><br><code class="code-box" id="publicKey"></code></p>
                        <p><strong>Thời Gian Tạo:</strong> <span id="createAt"></span></p>
                    </div>
                    <!-- Kết quả xác minh -->
                    <div class="result-container" id="verificationResultContainer"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <form id="verifySignatureForm"
                          action="${pageContext.request.contextPath}/admin/manager-order-sign-detail?method=verifySignature"
                          method="POST">
                        <input type="hidden" name="signatureId" id="signatureIdInput">
                        <input type="hidden" name="orderId" id="orderIdInput">
                        <button type="submit" class="btn btn-primary" id="verifyButton">Xác thực chữ ký</button>
                    </form>
                </div>
            </div>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Listen for the modal show event triggered by Bootstrap
        document.querySelectorAll('.edit-order-item').forEach(button => {
            button.addEventListener('click', function () {
                // Get data attributes from the clicked button
                const quantity = this.getAttribute('data-quantity');
                const detailId = this.getAttribute('data-detail-id');
                const orderId = this.getAttribute('data-order-id');

                // Populate the modal form fields
                document.getElementById('quantity').value = quantity;
                document.getElementById('detailId').value = detailId;
                document.getElementById('orderId').value = orderId;
            });
        });

        const verifyForm = document.getElementById('verifySignatureForm');
        const resultContainer = document.getElementById('verificationResultContainer');
        document.querySelectorAll('.verify-order-sign').forEach(button => {
            button.addEventListener('click', function () {
                const signatureId = this.getAttribute('data-signature-id');
                const orderId = this.getAttribute('data-order-id');
                const digitalSignature = this.getAttribute('data-digital-signature');
                const publicKey = this.getAttribute('data-public-key');
                const createAt = this.getAttribute('data-create-at');

                console.log('Verify Signature: signatureId=', signatureId, 'orderId=', orderId);
                document.getElementById('signatureIdDisplay').textContent = signatureId;
                document.getElementById('signatureId').textContent = signatureId;
                document.getElementById('digitalSignature').textContent = digitalSignature;
                document.getElementById('publicKey').textContent = publicKey;
                document.getElementById('createAt').textContent = createAt;
                document.getElementById('signatureIdInput').value = signatureId;
                document.getElementById('orderIdInput').value = orderId;

                // Xóa kết quả cũ
                resultContainer.innerHTML = '';
            });
        });

        // Xử lý gửi form bằng Ajax
        verifyForm.addEventListener('submit', function (event) {
            event.preventDefault(); // Ngăn form submit mặc định
            const formData = new FormData(this);
            const url = this.action;

            console.log('FormData entries:');
            let formDataHasValues = false;
            for (let [key, value] of formData.entries()) {
                console.log(key + '=' + value);
                formDataHasValues = true;
            }
            if (!formDataHasValues) {
                console.warn('FormData is empty!');
            }

            const signatureId = formData.get('signatureId');
            const orderId = formData.get('orderId');
            console.log('Submitting verifySignatureForm: signatureId=', signatureId, 'orderId=', orderId);
            if (!signatureId || !orderId) {
                resultContainer.innerHTML = `
                    <div class="alert alert-danger mt-3">Lỗi: Thiếu signatureId hoặc orderId</div>
                `;
                return;
            }

            fetch(url, {
                method: 'POST',
                body: formData
            }).then(response => {
                <%--console.log('Response status:', response.status);--%>
                <%--if (!response.ok) {--%>
                <%--    return response.text().then(text => {--%>
                <%--        try {--%>
                <%--            const json = JSON.parse(text);--%>
                <%--            throw new Error(json.error || `HTTP error! Status: ${response.status}`);--%>
                <%--        } catch (e) {--%>
                <%--            throw new Error(`HTTP error! Status: ${response.status}, Response: ${text}`);--%>
                <%--        }--%>
                <%--    });--%>
                <%--}--%>
                <%--return response.json();--%>
                console.log('Response status:', response.status);
                return response.text().then(text => {
                    console.log('Response text:', text);
                    if (!response.ok) {
                        try {
                            const json = JSON.parse(text);
                            throw new Error(json.error || 'HTTP error! Status:' + response.status);
                        } catch (e) {
                            throw new Error('HTTP error! Status: ' + response.status + ', Response: ' + text);
                        }
                    }
                    return JSON.parse(text);
                });
            }).then(data => {
                console.log('Response data:', data);
                let formattedJson = 'N/A';
                if (data.orderDataJson) {
                    try {
                        formattedJson = JSON.stringify(JSON.parse(data.orderDataJson), null, 2);
                    } catch (e) {
                        formattedJson = escapeHtml(data.orderDataJson);
                    }
                }
                if (data.error) {
                    resultContainer.innerHTML = '<div class="alert alert-danger mt-3">Lỗi: ' + data.error + '</div>';
                } else if (!data.verificationResult) {
                    resultContainer.innerHTML = '<div class="alert alert-danger mt-3">Lỗi: Không nhận được kết quả xác minh từ server</div>';
                } else {
                    resultContainer.innerHTML =
                        // '<div class="alert alert-success mt-3"><h6>' + data.verificationResult + '</h6>' +
                        // '<details class="mt-2">' +
                        // '<summary>Xem chi tiết dữ liệu</summary>' +
                        // '<div class="mt-2">' +
                        // '<p><strong>Order Data Hash:</strong></p>' +
                        // '<code class="code-box">' + data.orderDataHash || 'N/A' + '</code>' +
                        // '<p class="mt-2"><strong>Order Data JSON:</strong></p>' +
                        // '<pre class="bg-light p-2 border rounded" style="max-height: 300px; overflow-y: auto;">' + data.orderDataJson || 'N/A' + '</pre>' +
                        // '</div></details></div>'
                        resultContainer.innerHTML = '<div class="alert alert-' + (data.verificationResult.includes('thành công') ? 'success' : 'danger') + ' mt-3"><h6>' + data.verificationResult + '</h6>' +
                            '<details class="mt-2" open>' +
                            '<summary>Xem chi tiết dữ liệu</summary>' +
                            '<div class="mt-2">' +
                            '<p><strong>Order Data Hash:</strong></p>' +
                            '<code class="code-box">' + escapeHtml(data.orderDataHash) + '</code>' +
                            '<p class="mt-2"><strong>Order Data JSON:</strong></p>' +
                            '<pre class="bg-light p-2 border rounded" style="max-height: 300px; overflow-y: auto;">' +
                            formattedJson +
                            '</pre></div></details></div>';
                }
            }).catch(error => {
                console.error('Ajax error:', error.message);
                resultContainer.innerHTML =
                    '<div class="alert alert-danger mt-3">Lỗi:' + error.message + '</div>';
            });
        });
    });
    function escapeHtml(unsafe) {
        if (unsafe === null || unsafe === undefined) return 'N/A';
        return String(unsafe)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
</script>
</body>
</html>
