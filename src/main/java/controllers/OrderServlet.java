package controllers;

import java.io.*;

import dao.UserKeyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;

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
            // forward to payment-success.jsp
            request.setAttribute("message", "Đặt hàng thành công!");
            request.getRequestDispatcher("payment-success.jsp").forward(request, response);
        }
        // If other payment methods are addeld ater, they should be handled in an else if or separate servlet.
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