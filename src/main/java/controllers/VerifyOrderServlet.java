package controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.*;
import services.AddressService;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "VerifyOrderServlet", value = "/verifyOrder")
public class VerifyOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AddressService addressService = new AddressService();

//        user infor
        User user = (User) request.getSession().getAttribute("user");

        if(user == null) {
            throw new IllegalStateException("Người dùng chưa đăng nhập");
        }

        // Lấy khóa công khai của người dùng
        String publicKey = null;
        try {
            services.UserKeyService userKeyService = new services.UserKeyService();
//            models.UserKeys userKey = userKeyService.getCurrentUserKey(user.getId());
            models.UserKeys userKey = user.getUserkeys();
            if (userKey != null) {
                publicKey = userKey.getPublicKey();
            } else {
                System.out.println("Không tìm thấy khóa công khai cho người dùng ID: " + user.getId());
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy khóa công khai cho người dùng ID: " + user.getId());
            e.printStackTrace();
            publicKey = "Error retrieving public key"; // Hoặc xử lý lỗi theo cách khác
        }

        request.setAttribute("publicKey", publicKey); // Lưu khóa công khai vào request attribute

        int id_user = user.getId();
        String fullname = user.getFullName();
        String email = user.getEmail();
        String phone = user.getNumberPhone();

        Map<String, Object> userData = new LinkedHashMap<>();
        userData.put("id_user", id_user);
        userData.put("fullname", fullname);
        userData.put("email", email);
        userData.put("phone", phone);


//        order infor - orderDetail infor, voucher infor, shipping fee
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if(cart == null || cart.getItems().isEmpty()) {
            throw new IllegalStateException("Giỏ hàng trống hoặc không tồn tại.");
        }
        Map<String, Object> orderData = new LinkedHashMap<>();
        for(CartItem item: cart.getItems().values()) {
            Map<String, Object> productData = new LinkedHashMap<>();
            Style style = item.getStyle();

            int style_id = style.getId();
            int product_id = style.getProduct().getId();
            String product_name = style.getProduct().getName();
            String image = style.getImage();
            double price = style.getProduct().getPrice().getLastPrice();
            int quantity = item.getQuantity();
            // total price = quantity * price

            productData.put("product_id", product_id);
            productData.put("product_name", product_name);
            productData.put("image", image);
            productData.put("price", price);
            productData.put("quantity", quantity);

            orderData.put("product_" + product_id, productData);
        }
        double totalPrice = cart.getTotalPrice();
        double shippingFee = cart.getShippingFee();
        double lastPrice = cart.getLastPrice();

        orderData.put("totalPrice", totalPrice);
        orderData.put("shippingFee", shippingFee);

        if (cart.getVoucher() != null) {
            Map<String, Object> voucherInfo = new LinkedHashMap<>();
            voucherInfo.put("code", cart.getVoucher().getCode());
            voucherInfo.put("discountAmount", cart.getVoucher().getDiscountAmount());

            orderData.put("voucher", voucherInfo);
        } else {
            orderData.put("voucher", null);
        }
        orderData.put("lastPrice", lastPrice);

//        payment method
        Map<String, Object> paymentData = new LinkedHashMap<>();
        String paymentMethod = request.getParameter("payment");
        paymentData.put("paymentMethod", paymentMethod);

//        delivery infor
        Map<String, Object> deliveryData = new LinkedHashMap<>();
        String otherAddress = request.getParameter("otherAddress");
        if(otherAddress != null) {
            deliveryData.put("address_id", addressService.getLastId() + 1);
            deliveryData.put("fullName", request.getParameter("o-fullName"));
            deliveryData.put("phone", request.getParameter("o-phone"));

            deliveryData.put("street", request.getParameter("o-street"));
            deliveryData.put("commune", request.getParameter("o-commune"));
            deliveryData.put("city", request.getParameter("o-city"));
            deliveryData.put("province", request.getParameter("o-province"));
            deliveryData.put("note", request.getParameter("note"));
        }else {
            int address_id = user.getAddress().getId();

            String name_receive = user.getFullName();
            String phone_number = user.getNumberPhone();

            String street = user.getAddress().getStreet();
            String commune = user.getAddress().getCommune();
            String city = user.getAddress().getCity();
            String provice = user.getAddress().getProvince();


            String note = request.getParameter("note");

            deliveryData.put("address_id", address_id);
            deliveryData.put("fullName", name_receive);
            deliveryData.put("phone", phone_number);
            deliveryData.put("street", street);
            deliveryData.put("commune", commune);
            deliveryData.put("city", city);
            deliveryData.put("province", provice);
            deliveryData.put("note", note);
        }

        Map<String, Object> data = new LinkedHashMap<>();
        data.put("user", userData);
        data.put("order",orderData);
        data.put("payment",paymentData);
        data.put("delivery",deliveryData);

        // Convert orderData to JSON string using Jackson ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();

        String orderDataJson = objectMapper.writeValueAsString(data);

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
        
        // Thêm dòng này để lưu lại đối tượng Cart vào session trước khi forward
        request.getSession().setAttribute("cart", cart);

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