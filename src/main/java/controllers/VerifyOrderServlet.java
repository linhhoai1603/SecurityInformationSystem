package controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import models.CartItem;
import models.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "VerifyOrderServlet", value = "/verifyOrder")
public class VerifyOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        user infor
        User user = (User) request.getSession().getAttribute("user");
        int id_user = user.getId();
        String name = request.getParameter("name");


        Map<String, Object> userData = new HashMap<>();



//        order infor - orderDetail infor
        // Build order data structure
        Map<String, Object> orderData = new HashMap<>();

//        voucher infor

//        payment method

//        delivery infor


//        // Get data from form
//        String name = request.getParameter("name");
//        String phone = request.getParameter("phone");
//        String address = request.getParameter("address");
//        String otherPhone = request.getParameter("otherPhone");
//        boolean otherAddressSelected = request.getParameter("otherAddress") != null;
//        String note = request.getParameter("note");
//        String paymentMethod = request.getParameter("payment");
//
//        // Collect other address info if selected
//        Map<String, String> otherAddressInfo = null;
//        if (otherAddressSelected) {
//            otherAddressInfo = new HashMap<>();
//            otherAddressInfo.put("fullName", request.getParameter("o-fullName"));
//            otherAddressInfo.put("phone", request.getParameter("o-phone"));
//            otherAddressInfo.put("street", request.getParameter("o-street"));
//            otherAddressInfo.put("commune", request.getParameter("o-commune"));
//            otherAddressInfo.put("city", request.getParameter("o-city"));
//            otherAddressInfo.put("province", request.getParameter("o-province"));
//        }
//
//        // Get data from session
//        Cart cart = (Cart) request.getSession().getAttribute("cart");
//        User user = (User) request.getSession().getAttribute("user");
//

//
//        Map<String, Object> deliveryInfo = new HashMap<>();
//        deliveryInfo.put("name", name);
//        deliveryInfo.put("phone", phone);
//        deliveryInfo.put("address", address);
//        deliveryInfo.put("otherPhone", otherPhone);
//        deliveryInfo.put("otherAddressSelected", otherAddressSelected);
//        deliveryInfo.put("otherAddress", otherAddressInfo);
//        deliveryInfo.put("note", note);
//        orderData.put("delivery", deliveryInfo);
//
//        orderData.put("paymentMethod", paymentMethod);
//
//        // Add product details from cart
//        if (cart != null && cart.getItems() != null) {
//            Map<String, Map<String, Object>> productDetails = new HashMap<>();
//            for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
//                CartItem item = entry.getValue();
//                Map<String, Object> product = new HashMap<>();
//                product.put("id", item.getStyle().getId());
//                product.put("name", item.getStyle().getProduct().getName());
//                product.put("quantity", item.getQuantity());
//                product.put("pricePerItem", item.getStyle().getProduct().getPrice().getLastPrice());
//                product.put("totalPrice", item.getTotalPrice());
//                // Assuming image is accessible from Style object
//                product.put("image", item.getStyle().getImage());
//
//                productDetails.put(String.valueOf(item.getStyle().getId()), product);
//            }
//            orderData.put("products", productDetails);
//        }
//
//        // Add order summary from cart
//        if (cart != null) {
//            Map<String, Object> orderSummary = new HashMap<>();
//            orderSummary.put("subtotal", cart.getTotalPrice());
//            orderSummary.put("shippingFee", cart.getShippingFee());
//            orderSummary.put("total", cart.getLastPrice());
//            orderData.put("orderSummary", orderSummary);
//
//            // Add voucher info if available in cart
//            if (cart.getVoucher() != null) {
//                 Map<String, Object> voucherInfo = new HashMap<>();
//                 voucherInfo.put("code", cart.getVoucher().getCode());
//                 voucherInfo.put("discountAmount", cart.getVoucher().getDiscountAmount());
//                 // Add other relevant voucher details if needed
//                 orderData.put("voucher", voucherInfo);
//            } else {
//                 orderData.put("voucher", null);
//            }
//        }
//
//        // Add user info (optional, depending on what you need in the JSON)
//        if (user != null) {
//            Map<String, Object> userInfo = new HashMap<>();
//            userInfo.put("userId", user.getId());
//            userInfo.put("fullName", user.getFullName());
//            userInfo.put("email", user.getEmail());
//            // Add other relevant user details if needed
//            orderData.put("user", userInfo);
//        }

        // Convert orderData to JSON string using Jackson ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();

        String orderDataJson = objectMapper.writeValueAsString(orderData);


        // Store JSON string in request attribute and forward to verifier.jsp
        request.setAttribute("orderDataJson", orderDataJson);
        
        // Calculate hash of the JSON string
        String jsonHash = null;
        try {
            jsonHash = calculateSha256(orderDataJson);
        } catch (NoSuchAlgorithmException e) {
            // Log the error or handle it appropriately
            e.printStackTrace();
            jsonHash = "Error calculating hash: " + e.getMessage();
        }
        request.setAttribute("orderDataHash", jsonHash);
        
        request.getRequestDispatcher("verifier.jsp").forward(request, response);
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