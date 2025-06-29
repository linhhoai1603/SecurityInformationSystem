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
        .instruction img {
            max-width: 100%;
            height: auto;
            margin: 10px 0;
        }
        .step-separator {
            border-top: 2px solid #ccc;
            margin: 20px 0;
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
        <h4>Hướng dẫn sử dụng công cụ tạo khóa</h4>
        <ol>
            <li><strong>Tải công cụ:</strong> Nhấn vào nút "Tải công cụ tạo khóa (.exe)" để tải file SignOrder.exe.
                <img src="images/download_3.png" alt="Click Tải công cụ khoá .exe">
                <img src="images/download_4.png" alt="Click Keep để tiếp tục tải">
                <img src="images/download_5.png" alt="Click Keep anyway để tiếp tục">
                <img src="images/download_6.png" alt="Complete download exe">
                <div class="step-separator"></div>
            </li>
            <li><strong>Chạy công cụ:</strong> Mở file SignOrder.exe trên máy tính của bạn. Đảm bảo máy tính đã cài đặt
                Java Runtime Environment (JRE).
                <img src="images/open_exe.png" alt="Run SignOrder.exe">
                <img src="images/exe_ui.png" alt="Giao diện UI của exe">
                <div class="step-separator"></div>
            </li>
            <li><strong>Chọn kích thước khóa RSA:</strong> Trong giao diện công cụ, chọn kích thước khóa RSA (ví dụ:
                1024, 2048, hoặc 4096 bit) từ menu thả xuống "RSA Key Size".
                <img src="images/select_keysize.png" alt="Chọn kích thước khóa">
                <div class="step-separator"></div>
            </li>
            <li><strong>Chọn thuật toán ký:</strong> Chọn thuật toán ký (ví dụ: SHA256withRSA) từ menu thả xuống "Sign
                Algorithm".
                <img src="images/select_algo.png" alt="Chọn thuật toán tạo khóa">
                <div class="step-separator"></div>
            </li>
            <li><strong>Tạo khóa:</strong> Nhấn nút "Generate Key" để tạo cặp khóa công khai (public key) và khóa bí mật
                (private key). Khóa sẽ hiển thị trong các ô "Public Key" và "Private Key".
                <img src="images/generate_key.png" alt="Generate private and public key">
                <div class="step-separator"></div>
            </li>
            <li><strong>Lưu khóa:</strong> Nhấn "Save Public Key" để lưu khóa công khai hoặc "Save Private Key" để lưu
                khóa bí mật dưới dạng file .txt. Bạn cũng có thể sao chép khóa công khai bằng nút "Copy Signature".
                <img src="images/save_key.png" alt="Lưu khóa">
                <div class="step-separator"></div>
            </li>
            <li><strong>Tải khóa lên hệ thống:</strong> Quay lại trang web, sử dụng phần "Nhập khóa xác nhận (thủ công)"
                để dán khóa công khai hoặc phần "Hoặc chọn file .txt chứa public key" để tải file chứa khóa công khai.
                <img src="images/copy_publickey_manual.png">
                <img src="images/input_publickey_manual.png">
                <img src="images/click_choose_file.png">
                <img src="images/click_choose_file.png">
                <img src="images/key_choosed.png">
                <div class="step-separator"></div>
            </li>
            <li><strong>Lưu khóa:</strong> Nhấn nút "Lưu Khóa Xác Nhận" để gửi khóa công khai lên hệ thống.</li>
        </ol>
        <p><strong>Lưu ý:</strong> Giữ khóa bí mật (private key) ở nơi an toàn và không chia sẻ với bất kỳ ai. Khóa công
            khai (public key) có thể được gửi lên hệ thống để xác nhận.</p>
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
