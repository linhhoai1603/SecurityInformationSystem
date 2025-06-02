package controllers;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.*;
import services.*;


import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@WebServlet(value = "/verifySignature")
public class VerifySignatureServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String orderId_string = request.getParameter("orderId");
        if (orderId_string == null || orderId_string.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing orderId parameter\"}");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderId_string);
        } catch (NumberFormatException e) {
            // Handle error: invalid signature ID format
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid orderId format\"}");
            return;
        }

        OrderSignatureService orderSignatureService = new OrderSignatureService();
        List<OrderSignatures> orderSignatures = orderSignatureService.getSignaturesByIdOrder(orderId);
        System.out.println("Number of order signatures found: " + orderSignatures.size());
        if (orderSignatures.isEmpty()) {
            System.out.println("No signatures found for orderId: " + orderId);
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"No signatures found for this orderId\"}");
            return;
        }
        OrderSignatures orderSignature = orderSignatures.getLast();


        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);
        int id_user = order.getUser().getId();
        System.out.println("id_user" + order.getUser().getId());

        //        block User
        Map<String, Object> userData = new LinkedHashMap<>();
        UserService userService = new UserService();
        User user = userService.getUserById(id_user);
        userData.put("id_user", user.getId());
        userData.put("fullname", user.getFullName());
        userData.put("email", user.getEmail());
        userData.put("phone", user.getNumberPhone());

//        Block delivery
        Map<String, Object> deliveryData = new LinkedHashMap<>();
        int id_delivery = orderSignature.getDelivery().getId();
        DeliveryService deliveryService = new DeliveryService();
        Delivery delivery = deliveryService.getDeliveryById(id_delivery);

        int id_address = delivery.getAddress().getId();
        AddressService addressService = new AddressService();
        Address address = addressService.getAddressById(id_address);
        deliveryData.put("address_id", id_address);
        deliveryData.put("fullName", delivery.getFullName());
        deliveryData.put("phone", delivery.getPhoneNumber());
        deliveryData.put("street", address.getStreet());
        deliveryData.put("commune", address.getCommune());
        deliveryData.put("city", address.getCity());
        deliveryData.put("province", address.getProvince());
        deliveryData.put("note", delivery.getNote());

//        block payment
        PaymentService paymentService = new PaymentService();
        Payment payment = paymentService.getPaymentByIdOrder(orderId);
        Map<String, Object> paymentData = new LinkedHashMap<>();
        paymentData.put("paymentMethod", payment.getMethod());


//        block Order
        Map<String, Object> orderData = new LinkedHashMap<>();
        Map<String, Object> productData = new LinkedHashMap<>();
        OrderDetailService orderDetailService = new OrderDetailService();

        List<OrderDetail> OrderDetails =  orderDetailService.getOrderDetailByOrder(orderId);
        for(OrderDetail orderDetail: OrderDetails){
            int id_style = orderDetail.getStyle().getId();

            StyleService styleService = new StyleService();
            Style style = styleService.getStyleByID(id_style);

            int id_product = style.getProduct().getId();
            ProductService productsService = new ProductService();
            Product product = productsService.getProductById(id_product);

            int id_price = product.getPrice().getId();
            PriceService priceService = new PriceService();
            Price price = priceService.getPriceById(id_price);


            productData.put("product_id", id_product);
            productData.put("product_name", product.getName());
            productData.put("image", style.getImage());
            productData.put("price", price.getLastPrice());
            productData.put("quantity", orderDetail.getQuantity());

            orderData.put("product_" + id_product, productData);
        }

        orderData.put("totalPrice", order.getTotalPrice());
        orderData.put("shippingFee", delivery.getDeliveryFee());

        VoucherService voucherService = new VoucherService();
        System.out.println(voucherService.getVoucherByOrderId(orderId));
        Voucher voucher = voucherService.getVoucherByOrderId(orderId);

        if (voucher != null) {
            Map<String, Object> voucherInfo = new LinkedHashMap<>();
            voucherInfo.put("code", voucher.getCode());
            voucherInfo.put("discountAmount", voucher.getDiscountAmount());

            orderData.put("voucher", voucherInfo);
        } else {
            orderData.put("voucher", null);
        }
        orderData.put("lastPrice", order.getLastPrice());

        Map<String, Object> data = new LinkedHashMap<>();
        data.put("user", userData);
        data.put("order", orderData);
        data.put("payment", paymentData);
        data.put("delivery", deliveryData);

        // Convert aggregated data to JSON string
        ObjectMapper objectMapper = new ObjectMapper();
        String orderDataJson = objectMapper.writeValueAsString(data);

        System.out.println(orderDataJson);

        // Calculate hash
        String jsonHash = null;
        try {
            jsonHash = calculateSha256(orderDataJson);
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Error calculating hash: " + e.getMessage());
            e.printStackTrace();
            // Handle error appropriately, maybe return an error response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to calculate hash\"}");
            return;
        }

        // Prepare final response JSON
        Map<String, String> finalResponse = new LinkedHashMap<>();
        finalResponse.put("orderDataJson", orderDataJson);
        finalResponse.put("orderDataHash", jsonHash);

        // Write the final JSON response
        response.getWriter().write(objectMapper.writeValueAsString(finalResponse));
    }

    private String calculateSha256(String text) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(text.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }


}
