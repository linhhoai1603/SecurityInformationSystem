<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/link/headLink.jsp" %>
<html>
<head>
  <title>Đơn hàng đã mua</title>
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
        <!-- Cấu trúc bảng để hiển thị thông tin chi tiết kí từ order_signatures -->
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
            <td colspan="5" class="text-center">Chọn đơn hàng để xem chi tiết kí.</td> <%-- Placeholder ban đầu --%>
          </tr>
          </tbody>
        </table>
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

<%-- Script để xử lý modal, tải dữ liệu và xác thực chữ ký --%>
<%--<script>--%>
<%--  var signatureModal = document.getElementById('signatureModal');--%>
<%--  var signatureTableBody = signatureModal.querySelector('#signatureTableBody'); // Lấy tbody của bảng chi tiết kí--%>
<%--  var modalOrderIdDisplay = signatureModal.querySelector('#modalOrderIdDisplay'); // Phần tử hiển thị ID đơn hàng trong modal title--%>
<%--  var verifySignatureBtn = document.getElementById('verifySignatureBtn'); // Lấy nút xác thực--%>
<%--  var verificationResultDiv = signatureModal.querySelector('#verificationResult'); // Div hiển thị kết quả xác thực--%>

<%--  // Xử lý khi modal bắt đầu hiển thị--%>
<%--  signatureModal.addEventListener('show.bs.modal', function (event) {--%>
<%--    // Button that triggered the modal--%>
<%--    var button = event.relatedTarget;--%>
<%--    // Extract info from data-bs-* attributes--%>
<%--    var orderId = button.getAttribute('data-order-id');--%>

<%--    console.log("DEBUG JS: Value read from data-order-id:", orderId);--%>
<%--    console.log("DEBUG JS: Type of orderId:", typeof orderId); // Kiểm tra kiểu dữ liệu--%>

<%--    // Cập nhật hiển thị ID đơn hàng trong modal title--%>
<%--    modalOrderIdDisplay.textContent = orderId;--%>

<%--    // Lưu orderId vào nút xác thực để sử dụng sau này--%>
<%--    verifySignatureBtn.setAttribute('data-order-id-to-verify', orderId);--%>

<%--    // Xóa nội dung cũ và hiển thị trạng thái loading--%>
<%--    signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Đang tải chi tiết kí...</td></tr>';--%>
<%--    verificationResultDiv.innerHTML = ''; // Xóa kết quả xác thực cũ--%>

<%--    // *** URL endpoint backend để lấy chi tiết kí ***--%>
<%--    var getDetailsUrl = '<%= request.getContextPath() %>/Signature?orderId=' + orderId;--%>

<%--    console.log("DEBUG JS: Fetching URL being constructed:", getDetailsUrl);--%>


<%--    // Thực hiện cuộc gọi AJAX sử dụng Fetch API để lấy dữ liệu chi tiết kí--%>
<%--    fetch(getDetailsUrl)--%>
<%--            .then(response => {--%>
<%--              if (!response.ok) {--%>
<%--                return response.text().then(text => { throw new Error('Lỗi khi tải dữ liệu: ' + response.status + ' - ' + text) });--%>
<%--              }--%>
<%--              return response.json(); // Giả định backend trả về JSON array--%>
<%--            })--%>
<%--            &lt;%&ndash;.then(data => {&ndash;%&gt;--%>
<%--            &lt;%&ndash;  // Xóa trạng thái loading&ndash;%&gt;--%>
<%--            &lt;%&ndash;  signatureTableBody.innerHTML = '';&ndash;%&gt;--%>

<%--            &lt;%&ndash;  // Kiểm tra xem có dữ liệu trả về không&ndash;%&gt;--%>
<%--            &lt;%&ndash;  if (data && Array.isArray(data) && data.length > 0) {&ndash;%&gt;--%>
<%--            &lt;%&ndash;    // Lặp qua dữ liệu và thêm các hàng vào bảng&ndash;%&gt;--%>
<%--            &lt;%&ndash;    data.forEach(signature => {&ndash;%&gt;--%>
<%--            &lt;%&ndash;      // !!! Cập nhật tên các trường trong object `signature` cho khớp với JSON từ backend của bạn !!!&ndash;%&gt;--%>
<%--            &lt;%&ndash;      var row = `<tr>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                         <td>${signature.publicKey}</td>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                         <td>${signature.delivery}</td>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                         <td>${signature.digitalSignatures}</td>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                         <td>${signature.status}</td>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                         <td>${signature.creationDate}</td> &lt;%&ndash; Thay creationDate bằng tên trường ngày tạo &ndash;%&gt;&ndash;%&gt;--%>
<%--            &lt;%&ndash;                       </tr>`;&ndash;%&gt;--%>
<%--            &lt;%&ndash;      signatureTableBody.innerHTML += row;&ndash;%&gt;--%>
<%--            &lt;%&ndash;    });&ndash;%&gt;--%>
<%--            &lt;%&ndash;  } else {&ndash;%&gt;--%>
<%--            &lt;%&ndash;    // Hiển thị thông báo nếu không có dữ liệu&ndash;%&gt;--%>
<%--            &lt;%&ndash;    signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Không tìm thấy thông tin kí cho đơn hàng này.</td></tr>';&ndash;%&gt;--%>
<%--            &lt;%&ndash;  }&ndash;%&gt;--%>
<%--            &lt;%&ndash;})&ndash;%&gt;--%>
<%--            // ... existing code ...--%>
<%--            .then(data => {--%>
<%--              // Xóa trạng thái loading--%>
<%--              signatureTableBody.innerHTML = '';--%>

<%--              // Kiểm tra xem có dữ liệu trả về không--%>
<%--              if (data && Array.isArray(data) && data.length > 0) {--%>
<%--                // Lặp qua dữ liệu và thêm các hàng vào bảng--%>
<%--                data.forEach(signature => {--%>
<%--                  // !!! Cập nhật tên các trường trong object `signature` cho khớp với JSON từ backend của bạn !!!--%>
<%--                  // Dựa trên cấu trúc JSON từ OrderSignatures, UserKeys, Delivery models--%>
<%--                  var row = `<tr>--%>
<%--                                     <td>${signature.userKeys ? signature.userKeys.publicKey : 'N/A'}</td> &lt;%&ndash; Truy cập publicKey qua userKeys &ndash;%&gt;--%>
<%--                                     <td>${signature.delivery ? signature.delivery.fullName : 'N/A'}</td> &lt;%&ndash; Truy cập fullName qua delivery &ndash;%&gt;--%>
<%--                                     <td>${signature.digitalSignature}</td> &lt;%&ndash; Khớp với tên trường trong OrderSignatures &ndash;%&gt;--%>
<%--                                     <td>${signature.verified}</td> &lt;%&ndash; Khớp với tên trường trong OrderSignatures &ndash;%&gt;--%>
<%--                                     <td>${signature.create_at}</td> &lt;%&ndash; Khớp với tên trường trong OrderSignatures &ndash;%&gt;--%>
<%--                                   </tr>`;--%>
<%--                  signatureTableBody.innerHTML += row;--%>
<%--                });--%>
<%--              } else {--%>
<%--                // Hiển thị thông báo nếu không có dữ liệu--%>
<%--                signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Không tìm thấy thông tin kí cho đơn hàng này.</td></tr>';--%>
<%--              }--%>
<%--            })--%>
<%--            // ... existing code ...--%>
<%--            .catch(error => {--%>
<%--              // Xử lý lỗi trong quá trình fetch--%>
<%--              console.error('Lỗi Fetch Get Details:', error);--%>
<%--              signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">Đã xảy ra lỗi khi tải dữ liệu chi tiết kí.</td></tr>';--%>
<%--            });--%>
<%--  });--%>

<%--  // Xử lý khi nhấp vào nút Xác thực chữ ký--%>
<%--  verifySignatureBtn.addEventListener('click', function() {--%>
<%--    var orderIdToVerify = this.getAttribute('data-order-id-to-verify'); // Lấy ID đơn hàng cần xác thực--%>

<%--    if (!orderIdToVerify) {--%>
<%--      console.error('Không tìm thấy ID đơn hàng để xác thực.');--%>
<%--      verificationResultDiv.innerHTML = '<div class="alert alert-danger">Không tìm thấy ID đơn hàng để xác thực.</div>';--%>
<%--      return;--%>
<%--    }--%>

<%--    // Cập nhật trạng thái trên giao diện--%>
<%--    verificationResultDiv.innerHTML = '<div class="alert alert-info">Đang xử lý xác thực...</div>';--%>

<%--    // *** URL endpoint backend xử lý xác thực chữ ký ***--%>
<%--    // Thay thế '/your-backend-endpoint/verifySignature' bằng URL mapping thực tế của Servlet của bạn--%>
<%--    // Ví dụ: '/SecurityInformationSystem/verifySignature' hoặc '<%= request.getContextPath() %>/verifySignature'--%>
<%--    var verificationUrl = '<%= request.getContextPath() %>/verifySignature?orderId=' + orderIdToVerify;--%>

<%--    // Thực hiện cuộc gọi AJAX (Fetch API) để gọi backend xác thực--%>
<%--    fetch(verificationUrl)--%>
<%--            .then(response => {--%>
<%--              if (!response.ok) {--%>
<%--                // Xử lý lỗi HTTP (ví dụ: 400, 500)--%>
<%--                return response.text().then(text => { throw new Error('Lỗi Backend: ' + response.status + ' - ' + text) });--%>
<%--              }--%>
<%--              // Giả định backend trả về JSON với kết quả xác thực (ví dụ: { success: true, message: "Chữ ký hợp lệ" })--%>
<%--              return response.json();--%>
<%--            })--%>
<%--            .then(result => {--%>
<%--              // Xử lý kết quả trả về từ backend--%>
<%--              console.log('Kết quả xác thực:', result);--%>

<%--              // Hiển thị kết quả xác thực cho người dùng--%>
<%--              if (result.success) {--%>
<%--                verificationResultDiv.innerHTML = `<div class="alert alert-success">${result.message || 'Xác thực thành công.'}</div>`;--%>
<%--              } else {--%>
<%--                verificationResultDiv.innerHTML = `<div class="alert alert-danger">${result.message || 'Xác thực thất bại.'}</div>`;--%>
<%--              }--%>

<%--              // Tùy chọn: Nếu xác thực thành công/thất bại, bạn có thể muốn cập nhật trạng thái trong bảng chi tiết kí--%>
<%--              // Hoặc làm gì đó khác trên trang.--%>

<%--            })--%>
<%--            .catch(error => {--%>
<%--              // Xử lý lỗi trong quá trình fetch--%>
<%--              console.error('Lỗi Fetch Verification:', error);--%>
<%--              verificationResultDiv.innerHTML = `<div class="alert alert-danger">Đã xảy ra lỗi khi xác thực: ${error.message}</div>`;--%>
<%--            });--%>
<%--  });--%>

<%--</script>--%>

<%-- Script để xử lý modal, tải dữ liệu và xác thực chữ ký --%>
<script>
  var signatureModal = document.getElementById('signatureModal');
  var signatureTableBody = signatureModal.querySelector('#signatureTableBody');
  var modalOrderIdDisplay = signatureModal.querySelector('#modalOrderIdDisplay');
  var verifySignatureBtn = document.getElementById('verifySignatureBtn');
  var verificationResultDiv = signatureModal.querySelector('#verificationResult');

  // Biến để theo dõi trạng thái loading và ngăn chặn multiple requests
  var isLoading = false;
  var currentOrderId = null;

  // Remove existing event listeners to prevent multiple registration
  var newSignatureModal = signatureModal.cloneNode(true);
  signatureModal.parentNode.replaceChild(newSignatureModal, signatureModal);
  signatureModal = newSignatureModal;

  // Re-get elements after cloning
  signatureTableBody = signatureModal.querySelector('#signatureTableBody');
  modalOrderIdDisplay = signatureModal.querySelector('#modalOrderIdDisplay');
  verificationResultDiv = signatureModal.querySelector('#verificationResult');

  // Xử lý khi modal bắt đầu hiển thị
  signatureModal.addEventListener('show.bs.modal', function (event) {
    // Ngăn chặn nếu đang loading
    if (isLoading) {
      console.log("DEBUG JS: Request blocked - already loading");
      return;
    }

    // Button that triggered the modal
    var button = event.relatedTarget;
    var orderId = button.getAttribute('data-order-id');

    // Kiểm tra nếu cùng orderId đã được load
    if (currentOrderId === orderId && signatureTableBody.innerHTML.indexOf('Đang tải') === -1 &&
            signatureTableBody.innerHTML.indexOf('Không tìm thấy') === -1) {
      console.log("DEBUG JS: Data already loaded for orderId:", orderId);
      return;
    }

    console.log("DEBUG JS: Value read from data-order-id:", orderId);
    console.log("DEBUG JS: Type of orderId:", typeof orderId);

    currentOrderId = orderId;
    isLoading = true;

    // Cập nhật hiển thị ID đơn hàng trong modal title
    modalOrderIdDisplay.textContent = orderId;

    // Lưu orderId vào nút xác thực để sử dụng sau này
    verifySignatureBtn.setAttribute('data-order-id-to-verify', orderId);

    // Xóa nội dung cũ và hiển thị trạng thái loading
    signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Đang tải chi tiết kí...</td></tr>';
    verificationResultDiv.innerHTML = '';

    // URL endpoint backend để lấy chi tiết kí
    var getDetailsUrl = '<%= request.getContextPath() %>/Signature?orderId=' + orderId;
    console.log("DEBUG JS: Fetching URL being constructed:", getDetailsUrl);

    // Thực hiện cuộc gọi AJAX với timeout và abort controller
    var controller = new AbortController();
    var timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout

    fetch(getDetailsUrl, {
      signal: controller.signal,
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    })
            .then(response => {
              clearTimeout(timeoutId);
              if (!response.ok) {
                return response.text().then(text => {
                  throw new Error('Lỗi khi tải dữ liệu: ' + response.status + ' - ' + text)
                });
              }
              return response.json();
            })
            .then(data => {
              // Xóa trạng thái loading
              signatureTableBody.innerHTML = '';

              // Kiểm tra xem có dữ liệu trả về không
              if (data && Array.isArray(data) && data.length > 0) {
                // Lặp qua dữ liệu và thêm các hàng vào bảng
                data.forEach(signature => {
                  var row = `<tr>
                       <td>${signature.userKeys ? signature.userKeys.publicKey : 'N/A'}</td>
                       <td>${signature.delivery ? signature.delivery.fullName : 'N/A'}</td>
                       <td>${signature.digitalSignature || 'N/A'}</td>
                       <td>${signature.verified || 'N/A'}</td>
                       <td>${signature.create_at || 'N/A'}</td>
                     </tr>`;
                  signatureTableBody.innerHTML += row;
                });
              } else {
                signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Không tìm thấy thông tin kí cho đơn hàng này.</td></tr>';
              }
            })
            .catch(error => {
              clearTimeout(timeoutId);
              if (error.name === 'AbortError') {
                console.log('Request was aborted');
                signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center text-warning">Request timeout - vui lòng thử lại.</td></tr>';
              } else {
                console.error('Lỗi Fetch Get Details:', error);
                signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">Đã xảy ra lỗi khi tải dữ liệu chi tiết kí.</td></tr>';
              }
            })
            .finally(() => {
              isLoading = false; // Reset loading state
            });
  });

  // Xử lý khi modal được đóng - reset state
  signatureModal.addEventListener('hidden.bs.modal', function (event) {
    currentOrderId = null;
    isLoading = false;
  });

  // Xử lý khi nhấp vào nút Xác thực chữ ký
  document.getElementById('verifySignatureBtn').addEventListener('click', function() {
    var orderIdToVerify = this.getAttribute('data-order-id-to-verify');

    if (!orderIdToVerify) {
      console.error('Không tìm thấy ID đơn hàng để xác thực.');
      verificationResultDiv.innerHTML = '<div class="alert alert-danger">Không tìm thấy ID đơn hàng để xác thực.</div>';
      return;
    }

    // Ngăn chặn multiple verification requests
    if (this.disabled) {
      return;
    }

    // Disable button during verification
    this.disabled = true;
    var originalText = this.textContent;
    this.textContent = 'Đang xác thực...';

    // Cập nhật trạng thái trên giao diện
    verificationResultDiv.innerHTML = '<div class="alert alert-info">Đang xử lý xác thực...</div>';

    var verificationUrl = '<%= request.getContextPath() %>/verifySignature?orderId=' + orderIdToVerify;

    fetch(verificationUrl)
            .then(response => {
              if (!response.ok) {
                return response.text().then(text => {
                  throw new Error('Lỗi Backend: ' + response.status + ' - ' + text)
                });
              }
              return response.json();
            })
            .then(result => {
              console.log('Kết quả xác thực:', result);

              if (result.success) {
                verificationResultDiv.innerHTML = `<div class="alert alert-success">${result.message || 'Xác thực thành công.'}</div>`;
              } else {
                verificationResultDiv.innerHTML = `<div class="alert alert-danger">${result.message || 'Xác thực thất bại.'}</div>`;
              }
            })
            .catch(error => {
              console.error('Lỗi Fetch Verification:', error);
              verificationResultDiv.innerHTML = `<div class="alert alert-danger">Đã xảy ra lỗi khi xác thực: ${error.message}</div>`;
            })
            .finally(() => {
              // Re-enable button
              this.disabled = false;
              this.textContent = originalText;
            });
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

      init: function() {
        // Use event delegation on document body
        document.body.addEventListener('click', this.handleButtonClick.bind(this), true);

        // Modal events
        var modal = document.getElementById('signatureModal');
        modal.addEventListener('show.bs.modal', this.handleModalShow.bind(this), { once: false });
        modal.addEventListener('hidden.bs.modal', this.handleModalHidden.bind(this), { once: false });
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
      },

      needsRefresh: function() {
        var tableBody = document.querySelector('#signatureTableBody');
        return tableBody.innerHTML.indexOf('Đang tải') !== -1 ||
                tableBody.innerHTML.indexOf('lỗi') !== -1;
      },

      loadSignatureData: function(orderId) {
        this.isLoading = true;
        this.currentOrderId = orderId;

        var modalOrderIdDisplay = document.querySelector('#modalOrderIdDisplay');
        var signatureTableBody = document.querySelector('#signatureTableBody');
        var verificationResultDiv = document.querySelector('#verificationResult');
        var verifyBtn = document.getElementById('verifySignatureBtn');

        console.log("DEBUG JS: Loading data for orderId:", orderId);

        modalOrderIdDisplay.textContent = orderId;
        verifyBtn.setAttribute('data-order-id-to-verify', orderId);
        signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Đang tải chi tiết kí...</td></tr>';
        verificationResultDiv.innerHTML = '';

        var url = '<%= request.getContextPath() %>/Signature?orderId=' + orderId + '&t=' + Date.now();

        fetch(url)
                .then(response => {
                  if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                  }
                  return response.json();
                })
                .then(data => {
                  this.renderSignatureData(data);
                })
                .catch(error => {
                  console.error('Load error:', error);
                  signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center text-danger">Lỗi tải dữ liệu: ' + error.message + '</td></tr>';
                })
                .finally(() => {
                  this.isLoading = false;
                });
      },

      renderSignatureData: function(data) {
        var signatureTableBody = document.querySelector('#signatureTableBody');

        if (data && Array.isArray(data) && data.length > 0) {
          var html = '';
          data.forEach(signature => {
            html += `<tr>
                     <td>${signature.userKeys ? signature.userKeys.publicKey : 'N/A'}</td>
                     <td>${signature.delivery ? signature.delivery.fullName : 'N/A'}</td>
                     <td>${signature.digitalSignature || 'N/A'}</td>
                     <td>${signature.verified || 'N/A'}</td>
                     <td>${signature.create_at || 'N/A'}</td>
                   </tr>`;
          });
          signatureTableBody.innerHTML = html;
        } else {
          signatureTableBody.innerHTML = '<tr><td colspan="5" class="text-center">Không có dữ liệu chữ ký.</td></tr>';
        }
      },

      handleVerifyClick: function(event) {
        var button = event.target;
        var orderId = button.getAttribute('data-order-id-to-verify');

        if (!orderId || button.disabled) {
          return;
        }

        button.disabled = true;
        var originalText = button.textContent;
        button.textContent = 'Đang xác thực...';

        var verificationResultDiv = document.querySelector('#verificationResult');
        verificationResultDiv.innerHTML = '<div class="alert alert-info">Đang xử lý xác thực...</div>';

        var url = '<%= request.getContextPath() %>/verifySignature?orderId=' + orderId;

        fetch(url)
                .then(response => response.json())
                .then(result => {
                  var alertClass = result.success ? 'alert-success' : 'alert-danger';
                  var message = result.message || (result.success ? 'Xác thực thành công' : 'Xác thực thất bại');
                  verificationResultDiv.innerHTML = `<div class="alert ${alertClass}">${message}</div>`;
                })
                .catch(error => {
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