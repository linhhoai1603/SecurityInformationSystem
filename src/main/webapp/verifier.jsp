<%--
  Created by Gemini AI
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Order Verifier</title>
    <%@include file="includes/link/headLink.jsp"%>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<div class="container mt-5">
<%--    <h2>Thông tin đơn hàng (JSON)</h2>--%>
    <pre id="jsonContent" style="background-color: #f4f4f4; padding: 15px; border-radius: 5px; white-space: pre-wrap; word-wrap: break-word; display: none"></pre>
    <br>
<%--    <h2>Hash của JSON (SHA-256)</h2>--%>
<%--    <div id="jsonHash" style="background-color: #f4f4f4; padding: 15px; border-radius: 5px; word-wrap: break-word;">--%>
<%--        <button class="btn btn-outline-secondary" type="button" onclick="copyPublicKey()">Copy</button>--%>
<%--    </div>--%>


    <label class="fw-bold">Mã hash của thông tin đơn hàng: </label>
    <div style="background-color: #fff;padding-left: 10px;border-radius: 5px;border: solid 1px #ccc;word-wrap: break-word;display: flex;align-items: center;">
        <span id="hashValue" style="flex:1;">${requestScope.orderDataHash}</span>
        <button class="btn btn-outline-secondary ms-2" id="copyHashBtn" type="button" onclick="copyHash()">Copy</button>
    </div>

    <br>

    <form action="order" method="post">
        <%-- Hidden inputs for JSON and Hash (populated by JavaScript) --%>
        <input type="hidden" id="orderDataJsonInput" name="orderDataJson">
        <input type="hidden" id="orderDataHashInput" name="orderDataHash">

        <%-- Hidden inputs for original form data from payment.jsp (populated by JSP EL) --%>
        <input type="hidden" name="name" value="${param.name}">
        <input type="hidden" name="phone" value="${param.phone}">
        <input type="hidden" name="address" value="${param.address}">
        <input type="hidden" name="otherPhone" value="${param.otherPhone}">
        <%-- Checkbox sends 'on' or null, need to handle 1 for value --%>
        <c:if test="${param.otherAddress == '1'}">
             <input type="hidden" name="otherAddress" value="1">
        </c:if>
        <input type="hidden" name="o-fullName" value="${param['o-fullName']}">
        <input type="hidden" name="o-phone" value="${param['o-phone']}">
        <input type="hidden" name="o-street" value="${param['o-street']}">
        <input type="hidden" name="o-commune" value="${param['o-commune']}">
        <input type="hidden" name="o-city" value="${param['o-city']}">
        <input type="hidden" name="o-province" value="${param['o-province']}">
        <input type="hidden" name="note" value="${param.note}">
        <input type="hidden" name="payment" value="${param.payment}">

        <%-- Input for public key --%>
        <div class="form-group mb-3 position-relative">
            <label for="public_key" class="fw-bold">Public key:</label>
            <div class="input-group">
                <input type="text" class="form-control" id="public_key" name="public_key" value="${publicKey}" readonly>
            </div>
        </div>

        <%-- Input for Signature --%>
        <div class="form-group mb-3">
            <label for="digitalSignature" class="fw-bold">Nội dung ký xác nhận:</label>
            <input type="text" class="form-control" id="digitalSignature" name="digitalSignature" placeholder="Nhập nội dung ký">
        </div>

        <%-- Submit button --%>
        <button type="submit" class="btn btn-success">Ký xác nhận</button>
    </form>
</div>
<%@include file="includes/footer.jsp"%>
<script>
    // JavaScript to retrieve and display JSON/Hash and populate hidden inputs
    document.addEventListener("DOMContentLoaded", function() {
        // Retrieve JSON string and hash from request attribute set by the servlet (VerifyOrderServlet)
        const jsonString = '${requestScope.orderDataJson}';
        const jsonHash = '${requestScope.orderDataHash}';

        const jsonDisplayElement = document.getElementById('jsonContent');
        const hashDisplayElement = document.getElementById('jsonHash');
        const jsonInput = document.getElementById('orderDataJsonInput');
        const hashInput = document.getElementById('orderDataHashInput');

        // Display JSON
        if (jsonString && jsonString !== '') {
            try {
                const jsonObject = JSON.parse(jsonString);
                jsonDisplayElement.textContent = JSON.stringify(jsonObject, null, 2);
                // Populate hidden input
                jsonInput.value = jsonString;
            } catch (e) {
                jsonDisplayElement.textContent = 'Error parsing JSON: ' + e.message + '\n' + jsonString;
                jsonInput.value = ''; // Clear input on error
            }
        } else {
            jsonDisplayElement.textContent = 'Không tìm thấy dữ liệu đơn hàng.';
            jsonInput.value = ''; // Clear input if no data
        }

        // Display the hash and populate hidden input
        if (hashDisplayElement) {
             hashDisplayElement.textContent = jsonHash || 'Không có hash.';
             // Populate hidden input
             hashInput.value = jsonHash || '';
        }

    });

    // hàm xử lý sự kiện coppy text
    function copyHash() {
        const text = document.getElementById("hashValue").innerText;
        // navigator.clipboard.writeText(text); // không hiệu ứng

        navigator.clipboard.writeText(text).then(function() {
            const btn = document.getElementById("copyHashBtn");
            const original = btn.innerHTML;
            btn.innerHTML = "&#10003;"; // dấu tích
            btn.classList.remove("btn-outline-secondary");
            btn.classList.add("btn-success");
            setTimeout(function() {
                btn.innerHTML = original;
                btn.classList.remove("btn-success");
                btn.classList.add("btn-outline-secondary");
            }, 1500);
        });
    }

</script>
</body>
</html> 