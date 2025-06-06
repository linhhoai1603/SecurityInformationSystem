<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
  <title>Đơn hàng đã mua</title>
  <style>
    /* CSS để ngắt dòng các chuỗi dài */
    .break-long-text {
      word-break: break-all;
    }
  </style>
</head>
<body>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<link rel="stylesheet" href="css/shopping-cart.css">

<!-- Content -->
<div class="container-fluid">
  <div class="row" style="background-color: rgb(231, 231, 231); padding-top: 10px">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-10">
          <c:if test="${empty requestScope.orders}">
            <div class="text-center my-4">
              <h4>Bạn chưa có đơn hàng nào!</h4>
              <a href="products.jsp" class="btn btn-warning mt-3">Tiếp tục mua sắm</a>
            </div>
          </c:if>

          <!-- Danh sách đơn hàng -->
          <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
              <th scope="col">Mã đơn hàng</th>
              <th scope="col">Ngày đặt</th>
              <th scope="col">Tổng tiền</th>
              <th scope="col">Trạng thái giao</th>
              <th scope="col">Chi tiết</th>
              <th scope="col">Chi tiết kí</th> <%-- Thêm cột mới --%>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="o" items="${requestScope.orders}">
              <tr>
                <td>${o.id}</td>
                <td>${o.timeOrdered}</td>
                <td class="price">${o.lastPrice}</td>
                <td>${o.status}</td>
                <td>
                  <!-- Hiển thị chi tiết đơn hàng -->
                  <c:if test="${not empty o.listOfDetailOrder}">
                    <table class="table">
                      <thead class="thead-dark">
                      <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá tiền</th>
                        <th>Trọng lượng</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="detail" items="${o.listOfDetailOrder}">
                        <tr>
                          <td>${detail.style.name}</td>
                          <td>${detail.quantity}</td>
                          <td>${detail.totalPrice}</td>
                          <td>${detail.weight} kg</td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </c:if>
                </td>
                <td> <%-- Ô dữ liệu cho cột Chi tiết kí --%>
                    <%-- Nút bấm mở modal. ID đơn hàng dùng để lấy thông tin chữ ký --%>
                  <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#signatureModal" data-order-id="${o.id}" data-bs-backdrop="false">
                    Digital signatures
                  </button>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<%-- Bootstrap Modal cho Chi tiết kí --%>
<div class="modal fade" id="signatureModal" tabindex="-1" aria-labelledby="signatureModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg"> <%-- Điều chỉnh kích thước modal tại đây (modal-sm, modal-md, modal-lg, modal-xl) --%>
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="signatureModalLabel">Chi tiết thông tin kí đơn hàng: <span id="modalOrderIdDisplay"></span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Vùng chứa mới để hiển thị thông tin chi tiết kí theo chiều dọc -->
        <div id="signatureDetailsContainer"></div>

        <!-- Cấu trúc bảng cũ (có thể xóa hoặc comment sau khi xác nhận hiển thị đúng) -->
        <%--
        <table class="table table-bordered table-striped">
          <thead>
          <tr>
            <th>Public key</th>
            <th>Delivery</th>
            <th>Digital Signatures</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
          </tr>
          </thead>
          <tbody id="signatureTableBody">
          <!-- Dữ liệu chi tiết kí sẽ được tải vào đây bằng JavaScript/Ajax -->
          <tr>
            <td colspan="5" class="text-center">Chọn đơn hàng để xem chi tiết kí.</td>
          </tr>
          </tbody>
        </table>
        --%>

        <div id="verificationResult" class="mt-3">
          <!-- Kết quả xác thực sẽ hiển thị ở đây -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        <%-- Nút để gọi backend xử lý xác thực chữ ký --%>
        <button type="button" class="btn btn-primary" id="verifySignatureBtn">Xác thực chữ ký</button>
      </div>
    </div>
  </div>
</div>

<script>
  // Hàm định dạng số tiền thành tiền Việt
  function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
  }

  // Định dạng giá tiền trong bảng đơn hàng
  document.querySelectorAll(".price").forEach(el => {
    const originalPrice = el.textContent.trim().replace("VND", "").replace(/,/g, "");
    if (originalPrice) {
      el.textContent = formatCurrency(parseFloat(originalPrice));
    }
  });
</script>


<%-- Alternative Solution: Event Delegation --%>
<script>
  (function() {
    // Singleton pattern to ensure only one instance
    if (window.signatureModalHandler) {
      return;
    }

    window.signatureModalHandler = {
      isLoading: false,
      currentOrderId: null,
      // Cập nhật reference đến vùng chứa mới
      signatureDetailsContainer: document.querySelector('#signatureDetailsContainer'),
      modalOrderIdDisplay: document.querySelector('#modalOrderIdDisplay'),
      verifySignatureBtn: document.getElementById('verifySignatureBtn'),
      verificationResultDiv: document.querySelector('#verificationResult'),

      init: function() {
        // Use event delegation on document body
        document.body.addEventListener('click', this.handleButtonClick.bind(this), true);

        // Modal events
        var modal = document.getElementById('signatureModal');
        // Kiểm tra xem modal có tồn tại không trước khi thêm event listener
        if (modal) {
          modal.addEventListener('show.bs.modal', this.handleModalShow.bind(this), { once: false });
          modal.addEventListener('hidden.bs.modal', this.handleModalHidden.bind(this), { once: false });
        }
      },

      handleButtonClick: function(event) {
        // Handle signature detail buttons
        if (event.target.matches('[data-bs-target="#signatureModal"]')) {
          var orderId = event.target.getAttribute('data-order-id');
          if (this.isLoading && this.currentOrderId === orderId) {
            event.preventDefault();
            event.stopPropagation();
            console.log("DEBUG JS: Prevented duplicate request for orderId:", orderId);
            return false;
          }
        }

        // Handle verify button
        if (event.target.id === 'verifySignatureBtn') {
          this.handleVerifyClick(event);
        }
      },

      handleModalShow: function(event) {
        if (this.isLoading) {
          console.log("DEBUG JS: Modal show blocked - already loading");
          return;
        }

        var button = event.relatedTarget;
        var orderId = button.getAttribute('data-order-id');

        // Skip if same data already loaded
        if (this.currentOrderId === orderId && !this.needsRefresh()) {
          console.log("DEBUG JS: Data already loaded for orderId:", orderId);
          return;
        }

        this.loadSignatureData(orderId);
      },

      handleModalHidden: function(event) {
        this.currentOrderId = null;
        this.isLoading = false;
        // Xóa nội dung khi modal đóng
        if (this.signatureDetailsContainer) {
           this.signatureDetailsContainer.innerHTML = '';
        }
        if (this.verificationResultDiv) {
           this.verificationResultDiv.innerHTML = '';
        }
      },

      needsRefresh: function() {
        // Kiểm tra dựa trên nội dung của vùng chứa mới
        return this.signatureDetailsContainer.innerHTML.indexOf('Đang tải') !== -1 ||
               this.signatureDetailsContainer.innerHTML.indexOf('lỗi') !== -1 ||
               this.signatureDetailsContainer.innerHTML === ''; // Coi như cần refresh nếu rỗng
      },

      loadSignatureData: function(orderId) {
        this.isLoading = true;
        this.currentOrderId = orderId;

        var modalOrderIdDisplay = this.modalOrderIdDisplay;
        var signatureDetailsContainer = this.signatureDetailsContainer;
        var verificationResultDiv = this.verificationResultDiv;
        var verifyBtn = this.verifySignatureBtn;

        console.log("DEBUG JS: Loading data for orderId:", orderId);

        if (modalOrderIdDisplay) modalOrderIdDisplay.textContent = orderId;
        if (verifyBtn) verifyBtn.setAttribute('data-order-id-to-verify', orderId);

        // Hiển thị trạng thái loading trong vùng chứa mới
        if (signatureDetailsContainer) signatureDetailsContainer.innerHTML = '<p class="text-center">Đang tải chi tiết kí...</p>';
        if (verificationResultDiv) verificationResultDiv.innerHTML = '';

        var url = '<%= request.getContextPath() %>/Signature?orderId=' + orderId + '&t=' + Date.now();

        fetch(url)
                .then(response => {
                  if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                  }
                  return response.json();
                })
                .then(data => {
                  console.log("DEBUG JS: Data received:", data);
                  this.renderSignatureData(data);
                })
                .catch(error => {
                  console.error('Load error:', error);
                  // Hiển thị lỗi trong vùng chứa mới
                  if (signatureDetailsContainer) signatureDetailsContainer.innerHTML = '<p class="text-center text-danger">Lỗi tải dữ liệu: ' + error.message + '</p>';
                })
                .finally(() => {
                  this.isLoading = false;
                });
      },

      renderSignatureData: function(data) {
        var signatureDetailsContainer = this.signatureDetailsContainer;

        if (!signatureDetailsContainer) return; // Đảm bảo element tồn tại

        if (data && Array.isArray(data) && data.length > 0) {
          var html = '';
          data.forEach(signature => {
            // Tạo cấu trúc hiển thị theo chiều dọc cho mỗi chữ ký
            html += '<div class="signature-details-item mb-3 p-3 border rounded bg-light">';
            html += '<p class="break-long-text"><strong>Public key:</strong> <br>' + (signature.userKeys ? signature.userKeys.publicKey : 'N/A') + '</p>';
            html += '<p><strong>Delivery Full Name:</strong> ' + (signature.delivery ? signature.delivery.fullName : 'N/A') + '</p>';
            html += '<p class="break-long-text"><strong>Digital Signature:</strong> <br>' + (signature.digitalSignature || 'N/A') + '</p>';
            // Hiển thị trạng thái Verified
            var verifiedStatus = signature.verified;
            var verifiedText = 'N/A';
            if (verifiedStatus === 'verified') {
                verifiedText = '<span class="badge bg-success">Verified</span>';
            } else if (verifiedStatus === 'not verified') { // Giả định có trạng thái này hoặc tương tự
                 verifiedText = '<span class="badge bg-danger">Not Verified</span>';
            } else if (verifiedStatus) { // Hiển thị giá trị khác nếu có
                 verifiedText = verifiedStatus;
            }
            html += '<p><strong>Trạng thái:</strong> ' + verifiedText + '</p>';
            html += '<p><strong>Ngày tạo:</strong> ' + (signature.create_at || 'N/A') + '</p>';
            html += '</div>'; // Đóng signature-details-item
          });
          console.log("DEBUG JS: Generated HTML:", html);
          signatureDetailsContainer.innerHTML = html;
        } else {
          // Hiển thị thông báo không có dữ liệu trong vùng chứa mới
          signatureDetailsContainer.innerHTML = '<p class="text-center">Không có dữ liệu chữ ký.</p>';
        }
      },

      <%--handleVerifyClick: function(event) {--%>
      <%--  var button = event.target;--%>
      <%--  var orderId = button.getAttribute('data-order-id-to-verify');--%>

      <%--  if (!orderId || button.disabled) {--%>
      <%--    return;--%>
      <%--  }--%>

      <%--  button.disabled = true;--%>
      <%--  var originalText = button.textContent;--%>
      <%--  button.textContent = 'Đang xác thực...';--%>

      <%--  var verificationResultDiv = this.verificationResultDiv;--%>
      <%--  if (verificationResultDiv) verificationResultDiv.innerHTML = '<div class="alert alert-info">Đang xử lý xác thực...</div>';--%>

      <%--  var url = '<%= request.getContextPath() %>/verifySignature?orderId=' + orderId;--%>

      <%--  fetch(url, {--%>
      <%--    method: 'POST',--%>
      <%--    headers: {--%>
      <%--      'Content-Type': 'application/x-www-form-urlencoded',--%>
      <%--    },--%>
      <%--    body: formData--%>
      <%--  })--%>
      <%--  .then(response => {--%>
      <%--    // Kiểm tra mã trạng thái phản hồi trước khi xử lý JSON--%>
      <%--    if (!response.ok) {--%>
      <%--      // Nếu lỗi (ví dụ 405, 400, 500), ném lỗi để nhảy vào catch block--%>
      <%--      throw new Error(`HTTP error! status: ${response.status}`);--%>
      <%--    }--%>
      <%--    return response.json(); // Xử lý phản hồi dưới dạng JSON--%>
      <%--  })--%>
      <%--  .then(result => {--%>
      <%--    if (!verificationResultDiv) return;--%>
      <%--    // Giả sử phản hồi JSON có cấu trúc { success: boolean, message?: string, orderDataJson: string, orderDataHash: string }--%>
      <%--    // Cập nhật cách xử lý kết quả dựa trên cấu trúc thực tế bạn muốn hiển thị--%>
      <%--    var alertClass = result.success ? 'alert-success' : 'alert-danger';--%>
      <%--    var message = result.message || (result.success ? 'Xác thực thành công' : 'Xác thực thất bại');--%>
      <%--    // Hiển thị orderDataJson và orderDataHash nếu cần--%>
      <%--    let detailInfo = '';--%>
      <%--    if (result.success) {--%>
      <%--      detailInfo = `<p>Order Data JSON: ${result.orderDataJson}</p><p>Order Data Hash: ${result.orderDataHash}</p>`;--%>
      <%--    }--%>
      <%--    verificationResultDiv.innerHTML = `<div class="alert ${alertClass}">${message}${detailInfo}</div>`;--%>
      <%--  })--%>
      <%--  .catch(error => {--%>
      <%--    console.error('Fetch error:', error); // Log lỗi chi tiết--%>
      <%--    if (!verificationResultDiv) return;--%>
      <%--    verificationResultDiv.innerHTML = `<div class="alert alert-danger">Lỗi xác thực: ${error.message || ''}</div>`;--%>
      <%--  })--%>
      <%--  .finally(() => {--%>
      <%--    button.disabled = false;--%>
      <%--    button.textContent = originalText;--%>
      <%--  });--%>
      <%--}--%>
      handleVerifyClick: function(event) {
        var button = event.target;
        var orderId = button.getAttribute('data-order-id-to-verify');

        if (!orderId || button.disabled) {
          return;
        }

        button.disabled = true;
        var originalText = button.textContent;
        button.textContent = 'Đang xác thực...';

        var verificationResultDiv = this.verificationResultDiv;
        if (verificationResultDiv) verificationResultDiv.innerHTML = '<div class="alert alert-info">Đang xử lý xác thực...</div>';

        var url = '<%= request.getContextPath() %>/verifySignature?orderId=' + orderId;
        fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
          // Không cần body vì orderId đã nằm trong query string
        })
                .then(response => {
                  console.log('Response status:', response.status); // Debug log
                  if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                  }
                  return response.json();
                })
                .then(result => {
                  console.log('Verification result:', result); // Debug log
                  if (!verificationResultDiv) return;

                  // Xử lý kết quả từ servlet
                  if (result.error) {
                    verificationResultDiv.innerHTML = `<div class="alert alert-danger">Lỗi: ${result.error}</div>`;
                  } else {
                    // Hiển thị kết quả thành công
                    var successHtml = '<div class="alert alert-success">';
                    successHtml += '<h6>Xác thực thành công!</h6>';
                    successHtml += '<details class="mt-2">';
                    successHtml += '<summary>Xem chi tiết dữ liệu</summary>';
                    successHtml += '<div class="mt-2">';
                    successHtml += '<p><strong>Order Data Hash:</strong></p>';
                    successHtml += '<code class="break-long-text">' + result.orderDataHash + '</code>';
                    successHtml += '<p class="mt-2"><strong>Order Data JSON:</strong></p>';
                    successHtml += '<pre class="bg-light p-2 border rounded" style="max-height: 300px; overflow-y: auto;">' +
                            JSON.stringify(JSON.parse(result.orderDataJson), null, 2) + '</pre>';
                    successHtml += '</div>';
                    successHtml += '</details>';
                    successHtml += '</div>';
                    verificationResultDiv.innerHTML = successHtml;
                  }
                })
                .catch(error => {
                  console.error('Fetch error:', error);
                  if (!verificationResultDiv) return;
                  verificationResultDiv.innerHTML = `<div class="alert alert-danger">Lỗi xác thực: ${error.message}</div>`;
                })
                .finally(() => {
                  button.disabled = false;
                  button.textContent = originalText;
                });
      }
    };

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', function() {
        window.signatureModalHandler.init();
      });
    } else {
      window.signatureModalHandler.init();
    }
  })();
</script>

<%@ include file="includes/footer.jsp" %>
<%@ include file="includes/link/footLink.jsp" %>
</body>
</html>