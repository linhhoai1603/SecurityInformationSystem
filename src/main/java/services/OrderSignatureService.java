package services;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.OrderSignatureDAO;
import models.*;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrderSignatureService {
    OrderSignatureDAO dao;

    public OrderSignatureService() {
        dao = new OrderSignatureDAO();
    }

    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
        return dao.insertOrderSignature(orderSignatures);
    }

    public List<OrderSignatures> getSignaturesByIdOrder(int orderId) {
        return dao.getSignaturesByIdOrder(orderId);
    }

    public List<OrderSignatures> getSignaturesAll() {
        return dao.getSignaturesAll();
    }

    public OrderSignatures getOrderSignatureById(int signatureId) {
        return dao.getSignaturesById(signatureId);
    }

    public String getPublicKeyById(int id) {
        return dao.getPublicKeyById(id);
    }

    public Map<String, String> verifySignature(int orderId) throws Exception {
        Map<String, String> finalResponse = new LinkedHashMap<>();

        // Lấy danh sách chữ ký
        List<OrderSignatures> orderSignatures = getSignaturesByIdOrder(orderId);
        if (orderSignatures.isEmpty()) {
            finalResponse.put("result", "Lỗi xác thực: Không tìm thấy chữ ký cho đơn hàng này");
            return finalResponse;
        }
        OrderSignatures orderSignature = orderSignatures.getLast();

        // Lấy thông tin đơn hàng
        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);
        if (order == null) {
            finalResponse.put("result", "Lỗi xác thực: Không tìm thấy đơn hàng");
            return finalResponse;
        }
        int id_user = order.getUser().getId();

        // Block User
        Map<String, Object> userData = new LinkedHashMap<>();
        UserService userService = new UserService();
        User user = userService.getUserById(id_user);
        userData.put("id_user", user.getId());
        userData.put("fullname", user.getFullName());
        userData.put("email", user.getEmail());
        userData.put("phone", user.getNumberPhone());

        // Block Delivery
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

        // Block Payment
        PaymentService paymentService = new PaymentService();
        Payment payment = paymentService.getPaymentByIdOrder(orderId);
        Map<String, Object> paymentData = new LinkedHashMap<>();
        paymentData.put("paymentMethod", payment.getMethod());

        // Block Order
        Map<String, Object> orderData = new LinkedHashMap<>();
        Map<String, Object> productData = new LinkedHashMap<>();
        OrderDetailService orderDetailService = new OrderDetailService();
        List<OrderDetail> orderDetails = orderDetailService.getOrderDetailByOrder(orderId);
        for (OrderDetail orderDetail : orderDetails) {
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

        // Tạo dữ liệu tổng hợp
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("user", userData);
        data.put("order", orderData);
        data.put("payment", paymentData);
        data.put("delivery", deliveryData);

        // Chuyển dữ liệu thành JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String orderDataJson = objectMapper.writeValueAsString(data);

        // Tính hash
        String jsonHash;
        try {
            jsonHash = calculateSha256(orderDataJson);
        } catch (NoSuchAlgorithmException e) {
            finalResponse.put("result", "Lỗi xác thực: Không thể tính hash dữ liệu");
            return finalResponse;
        }

        // Xác minh chữ ký
        String digitalSignature = orderSignature.getDigitalSignature();
        String publicKey = getPublicKeyById(orderSignature.getId());
        boolean isSignatureValid;
        try {
            Sign signer = new Sign();
            isSignatureValid = signer.verify(jsonHash, digitalSignature, publicKey);
        } catch (Exception e) {
            finalResponse.put("result", "Lỗi xác thực: " + e.getMessage());
            return finalResponse;
        }

        // Chuẩn bị phản hồi
        if (isSignatureValid) {
            finalResponse.put("result", "Xác thực thành công");
            finalResponse.put("orderDataJson", orderDataJson);
            finalResponse.put("orderDataHash", jsonHash);
        } else {
            finalResponse.put("result", "Lỗi. Chữ ký điện tử không hợp lệ. Dữ liệu có thể đã bị thay đổi.");
        }

        return finalResponse;
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

    public boolean updateSignatureStatus(int signatureId, String status) {
        return dao.updateSignatureStatus(signatureId, status);
    }
}
