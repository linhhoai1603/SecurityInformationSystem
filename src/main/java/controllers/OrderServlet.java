package controllers;

import java.io.*;

import dao.UserKeyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

// verifier.jsp
@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {
    String methodPay;
    Delivery delivery;


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // get info and create order from cart
        methodPay = request.getParameter("payment");

        // Get JSON data, signature, and public key from the request
        String orderDataJson = request.getParameter("orderDataJson");
        String publicKey = request.getParameter("public_key");
        String signature = request.getParameter("signature");

        Map<String, Object> orderData = null;
        if (orderDataJson != null && !orderDataJson.isEmpty()) {
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                orderData = objectMapper.readValue(orderDataJson, Map.class);
                // Now 'orderData' map contains the data from the JSON

                // You can access different parts like:
                // Map<String, Object> deliveryInfo = (Map<String, Object>) orderData.get("delivery");
                // Map<String, Object> orderSummary = (Map<String, Object>) orderData.get("orderSummary");
                // Map<String, Object> userInfo = (Map<String, Object>) orderData.get("user");
                // Map<String, Map<String, Object>> products = (Map<String, Map<String, Object>>) orderData.get("products");

            } catch (IOException e) {
                // Log error or handle exception
                e.printStackTrace();
                // Optionally set an error message for the user
                request.setAttribute("message", "Lỗi xử lý dữ liệu đơn hàng.");
                request.getRequestDispatcher("payment-success.jsp").forward(request, response);
                return; // Stop processing if JSON parsing fails
            } catch (IllegalStateException e) {
                // Catch validation errors thrown from createOrder
                System.err.println("Lỗi validation khi tạo đơn hàng: " + e.getMessage());
                request.setAttribute("message", "Lỗi: " + e.getMessage());
                request.getRequestDispatcher("payment-failed.jsp").forward(request, response);
                return; // Stop processing
            }
        }


        if("cash".equals(methodPay)) {
            // Pass the parsed JSON data map to createOrder
            Ordered ordered = createOrder(request, response, orderData);
            // remove cart
            removeCart(request, response);
            // set attribute
            request.setAttribute("ordered", ordered);

            // set digitalSignature
            String digitalSignature = request.getParameter("digitalSignature");
            request.setAttribute("digitalSignature", digitalSignature);

            // Send mail order infor
            User user = (User) request.getSession().getAttribute("user");
            sendOrderConfirmationEmail(user, ordered, digitalSignature);

            // forward to payment-success.jsp
            request.setAttribute("message", "Đặt hàng thành công!");
            request.getRequestDispatcher("payment-success.jsp").forward(request, response);
        }
        // If other payment methods are addeld ater, they should be handled in an else if or separate servlet.
    }

//    private void sendOrderConfirmationEmail(User user, Ordered ordered, String digitalSignature) {
//        String email = user.getEmail();
//        StringBuilder emailContent = new StringBuilder();
//        emailContent.append("Xin chào ").append(user.getFullName()).append(",\n\n");
//        emailContent.append("Cảm ơn bạn đã đặt hàng tại hệ thống của chúng tôi!\n\n");
//        emailContent.append("Thông tin đơn hàng:\n");
//        emailContent.append("Mã đơn hàng: ").append(ordered.getIdOrder()).append("\n");
//        emailContent.append("Thời gian mua hàng: ").append(ordered.getTimeOrdered()).append("\n");
//        emailContent.append("Người mua hàng: ").append(ordered.getPersonName()).append("\n");
//        emailContent.append("Địa chỉ nhận hàng: ").append(ordered.getAddress()).append("\n");
//        emailContent.append("Tổng cộng: ").append(ordered.getCart().getLastPrice()).append("đ\n");
//        emailContent.append("Phương thức thanh toán: ").append(ordered.getMethodPayment()).append("\n");
//        emailContent.append("Chữ ký xác nhận: ").append(digitalSignature).append("\n\n");
//        emailContent.append("Chi tiết sản phẩm:\n");
//        for (CartItem item : ordered.getCart().getItems().values()) {
//            emailContent.append("- ")
//                    .append(item.getStyle().getProduct().getName())
//                    .append(" - ").append(item.getStyle().getName())
//                    .append(", SL: ").append(item.getQuantity())
//                    .append(", Tổng: ").append(item.getTotalPrice()).append("đ\n");
//        }
//        emailContent.append("\nNếu có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi.\n");
//        emailContent.append("Trân trọng!");
//        services.application.EmailSender.sendEMail(
//                email,
//                "Xác nhận đơn hàng #" + ordered.getIdOrder(),
//                emailContent.toString()
//        );
//    }
private void sendOrderConfirmationEmail(User user, Ordered ordered, String digitalSignature) {
    String email = user.getEmail();
    String subject = "🎉 Xác nhận đơn hàng #" + ordered.getIdOrder() + " - Cảm ơn bạn đã mua hàng!";

    StringBuilder html = new StringBuilder();
    html.append("<div style='font-family:Arial,sans-serif;max-width:600px;margin:auto;border-radius:10px;border:1px solid #eee;box-shadow:0 2px 8px #eee;padding:24px;background:#f9f9f9;'>");
    html.append("<h2 style='color:#4fd0b6;text-align:center;'>Cảm ơn bạn đã đặt hàng!</h2>");
    html.append("<p style='text-align:center;font-size:18px;'>Xin chào <b>").append(user.getFullName()).append("</b>,</p>");
    html.append("<p style='text-align:center;'>Đơn hàng của bạn đã được ghi nhận thành công.</p>");
    html.append("<hr style='margin:24px 0;'>");

    html.append("<h3 style='color:#4fd0b6;'>Thông tin đơn hàng</h3>");
    html.append("<table style='width:100%;font-size:16px;'>");
    html.append("<tr><td><b>Mã đơn hàng:</b></td><td>").append(ordered.getIdOrder()).append("</td></tr>");
    html.append("<tr><td><b>Thời gian mua hàng:</b></td><td>").append(ordered.getTimeOrdered()).append("</td></tr>");
    html.append("<tr><td><b>Người mua hàng:</b></td><td>").append(ordered.getPersonName()).append("</td></tr>");
    html.append("<tr><td><b>Địa chỉ nhận hàng:</b></td><td>").append(ordered.getAddress()).append("</td></tr>");
    html.append("<tr><td><b>Tổng cộng:</b></td><td><b style='color:#e67e22;'>").append(ordered.getCart().getLastPrice()).append("đ</b></td></tr>");
    html.append("<tr><td><b>Phương thức thanh toán:</b></td><td>").append(ordered.getMethodPayment()).append("</td></tr>");
    html.append("<tr><td><b>Chữ ký xác nhận:</b></td><td><span style='word-break:break-all;background:#eafaf1;padding:4px 8px;border-radius:4px;display:inline-block;'>")
            .append(digitalSignature).append("</span></td></tr>");
    html.append("</table>");

    html.append("<h3 style='color:#4fd0b6;margin-top:32px;'>Chi tiết sản phẩm</h3>");
    html.append("<table style='width:100%;border-collapse:collapse;font-size:15px;'>");
    html.append("<tr style='background:#eafaf1;'><th style='padding:8px;border:1px solid #ddd;'>Sản phẩm</th><th style='padding:8px;border:1px solid #ddd;'>Số lượng</th><th style='padding:8px;border:1px solid #ddd;'>Tổng</th></tr>");
    for (CartItem item : ordered.getCart().getItems().values()) {
        html.append("<tr>");
        html.append("<td style='padding:8px;border:1px solid #ddd;'>")
                .append(item.getStyle().getProduct().getName())
                .append(" - ").append(item.getStyle().getName())
                .append("</td>");
        html.append("<td style='padding:8px;border:1px solid #ddd;text-align:center;'>")
                .append(item.getQuantity()).append("</td>");
        html.append("<td style='padding:8px;border:1px solid #ddd;text-align:right;'>")
                .append(item.getTotalPrice()).append("đ</td>");
        html.append("</tr>");
    }
    html.append("</table>");

    html.append("<p style='margin-top:32px;text-align:center;'>Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi.<br>Trân trọng!</p>");
    html.append("</div>");

    services.application.EmailSender.sendEMail(
            email,
            subject,
            html.toString(),
            true // gửi HTML
    );
}

    private void removeCart(HttpServletRequest request, HttpServletResponse response) {
        Cart cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    // Modified createOrder to accept the parsed JSON data
    private Ordered createOrder(HttpServletRequest request, HttpServletResponse response, Map<String, Object> orderData) {
        OrderService orderService = new OrderService();
        OrderDetailService orderDetailService = new OrderDetailService();
        DeliveryService deliveryService = new DeliveryService();
        AddressService addressService = new AddressService();
        StyleService styleService = new StyleService();


        // Kiểm tra session và lấy thông tin
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if(cart == null || cart.getItems().isEmpty()) {
            throw new IllegalStateException("Giỏ hàng trống hoặc không tồn tại.");
        }

        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            throw new IllegalStateException("Người dùng chưa đăng nhập");
        }

        // Tạo order
        Voucher voucher = cart.getVoucher();
        String status = "Đang giao hàng";
        double totalPrice = cart.getTotalPrice();
        double lastPrice = cart.getLastPrice();
        Order order = new Order(user, voucher, status, totalPrice, lastPrice);
        int idOrder = orderService.insertOrder(order);
        order.setId(idOrder);


//        // Tạo orderDetails
        for (CartItem item : cart.getItems().values()) {
            Style style = item.getStyle();
            int quantity = item.getQuantity();

            if(quantity > style.getProduct().getQuantity()) {
                throw new IllegalStateException("Số lượng hàng không đủ");
            }else {
                style.setQuantity(style.getQuantity() - quantity);
                style.getProduct().setQuantity(style.getProduct().getQuantity() - quantity);
                styleService.updateQuantityForProduct(style.getProduct().getId(), style.getProduct().getQuantity());
                styleService.updateQuantityForStyle(style.getId(), style.getQuantity());
                OrderDetail orderDetail = new OrderDetail(idOrder, style, quantity);
                orderDetailService.insertOrderDetail(orderDetail);
                order.getListOfDetailOrder().add(orderDetail);
            }
        }

        // Xử lý thông tin giao hàng - Use data from orderData if available, fallback to request parameters
        Map<String, Object> deliveryInfo = (Map<String, Object>) orderData.get("delivery");
        String note = (String) deliveryInfo.get("note");
        String deliveryProvince = (String) deliveryInfo.get("province");
        String deliveryCity = (String) deliveryInfo.get("city");
        String deliveryCommune = (String) deliveryInfo.get("commune");
        String deliveryStreet = (String) deliveryInfo.get("street");
        String deliveryPhone = (String) deliveryInfo.get("phone");
        String deliveryFullName = (String) deliveryInfo.get("fullName");
        int idAddress = user.getAddress().getId();

        delivery = new Delivery(
            idOrder,
            idAddress,
            deliveryFullName,
            deliveryPhone,
            cart.getTotalArea(),
            cart.getShippingFee(),
            note,
            "Đang giao hàng"
        );
        int delicery_id = deliveryService.insertDeliveryReturnId(delivery);
        delivery.setId(delicery_id);

//        insert payments
        PaymentService paymentService = new PaymentService();
        Payment payment = new Payment(order, methodPay, "Pending");
        paymentService.insertPayment(payment);

//        insert order_signatures
        String digitalSignature = request.getParameter("digitalSignature");
        UserKeyService userKeyService = new UserKeyService();
        System.out.println("UserKeyService created successfully");
        OrderSignatureService orderSignatureService = new OrderSignatureService();

        System.out.println("user.getId(): " + user.getId());

        UserKeys userKey = new UserKeys();
        try {
            userKey = userKeyService.getCurrentUserKey(user.getId());
            System.out.println("UserKey retrieved: " + (userKey != null ? userKey.toString() : "null"));
        } catch (Exception e) {
            System.out.println("Error calling getCurrentUserKey: " + e.getMessage());
            e.printStackTrace();
        };

        OrderSignatures orderSignatures = new OrderSignatures(order, userKey, delivery, digitalSignature, "verified");

        // Kiểm tra các object trước khi tạo OrderSignatures
        System.out.println("Order ID: " + (order != null ? order.getId() : "null"));
        System.out.println("UserKey ID: " + (userKey != null ? userKey.getId() : "null"));
        System.out.println("Delivery ID: " + (delivery != null ? delivery.getId() : "null"));

        orderSignatureService.insertOrderSignature(orderSignatures);

        // Trả về đối tượng Ordered
        return new Ordered(
                cart, idOrder, order.getTimeOrdered(),
                user.getFullName(), delivery.getNote(),
                addressService.getAddressById(delivery.getIdAddress()).getAddressDetail(),
                methodPay
        );
    }

}