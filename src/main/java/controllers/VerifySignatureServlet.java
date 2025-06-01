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
import services.OrderService;
import services.OrderSignatureService;
import services.PaymentService;


import java.io.IOException;
import java.util.HashMap;
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
        OrderSignatures orderSignature = orderSignatures.getFirst();

        int orderSignatureId = orderSignature.getId();

        Map<String, Object> deliveryData = new HashMap<>();
        Delivery delivery = orderSignature.getDelivery();


        PaymentService paymentService = new PaymentService();
        Payment payment = paymentService.getPaymentByIdOrder(orderId);


        UserKeys userKey = orderSignature.getUserKeys();

        User user = userKey.getUser();

//        int id_user = user.getId();
//        String fullname = user.getFullName();
//        String email = user.getEmail();
//        String phone = user.getNumberPhone();
//
//        Map<String, Object> userData = new HashMap<>();
//        userData.put("id_user", id_user);
//        userData.put("fullname", fullname);
//        userData.put("email", email);
//        userData.put("phone", phone);





        Map<String, Object> data = new HashMap<>();
//        data.put("user", userData);
//        data.put("order", orderData);
//        data.put("payment", paymentData);
//        data.put("delivery", deliveryData);

        // Convert aggregated data to JSON string
        ObjectMapper objectMapper = new ObjectMapper();
        String orderDataJson = objectMapper.writeValueAsString(data);

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
        Map<String, String> finalResponse = new HashMap<>();
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
