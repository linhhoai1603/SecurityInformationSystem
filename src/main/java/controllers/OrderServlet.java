package controllers;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.*;
import services.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // get info and create order from cart
        // get method payment
        String methodPay = request.getParameter("payment");

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

                // TODO: Use 'publicKey' and 'signature' here for verification if needed

            } catch (IOException e) {
                // Log error or handle exception
                e.printStackTrace();
                // Optionally set an error message for the user
                request.setAttribute("message", "Lỗi xử lý dữ liệu đơn hàng.");
                request.getRequestDispatcher("payment-success.jsp").forward(request, response);
                return; // Stop processing if JSON parsing fails
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
        // Removed the else block as requested, assuming only cash is handled here.
        // If other payment methods are added later, they should be handled in an else if or separate servlet.
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
        // Keep using session cart for product details and totals as before,
        // or switch to using 'orderData' products/summary
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
             // If orderData is available, try to construct cart details from JSON
             if (orderData != null && orderData.containsKey("products")) {
                 // TODO: Logic to reconstruct Cart or necessary product/summary info from 'orderData' map
                 // For now, throwing an exception if session cart is empty and no orderData is available
                 throw new IllegalStateException("Giỏ hàng trống hoặc không tồn tại và không có dữ liệu đơn hàng từ JSON.");
             } else {
                 throw new IllegalStateException("Giỏ hàng trống hoặc không tồn tại.");
             }
        }

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            throw new IllegalStateException("Người dùng chưa đăng nhập.");
        }

        // Tạo order - Use data from orderData if available, fallback to cart/session
        Voucher voucher = null;
        String status = "Đang giao hàng"; // Default status
        double totalPrice = 0;
        double lastPrice = 0;

        if (orderData != null && orderData.containsKey("orderSummary")) {
            Map<String, Object> orderSummary = (Map<String, Object>) orderData.get("orderSummary");
            totalPrice = ((Number) orderSummary.get("subtotal")).doubleValue();
            lastPrice = ((Number) orderSummary.get("total")).doubleValue();
             if (orderData.containsKey("voucher") && orderData.get("voucher") != null) {
                 Map<String, Object> voucherInfo = (Map<String, Object>) orderData.get("voucher");
                 // TODO: Fetch or create Voucher object from voucherInfo
                 // Example (basic):
                 // voucher = new Voucher((String) voucherInfo.get("code"), ((Number) voucherInfo.get("discountAmount")).doubleValue());
             }
        } else {
             // Fallback to cart data if JSON summary not available
             totalPrice = cart.getTotalPrice();
             lastPrice = cart.getLastPrice();
             voucher = cart.getVoucher();
        }


        Order order = new Order(user, voucher, status, totalPrice, lastPrice);
        int idOrder = orderService.insertOrder(order); // Trả về idOrder sau khi chèn

        // Tạo chi tiết đơn hàng - Use data from orderData if available, fallback to cart
        if (orderData != null && orderData.containsKey("products")) {
            Map<String, Map<String, Object>> products = (Map<String, Map<String, Object>>) orderData.get("products");
            for (Map<String, Object> productJson : products.values()) {
                int styleId = Integer.parseInt(productJson.get("id").toString());
                int quantity = (Integer) productJson.get("quantity");

                Style style = styleService.getStyleByID(styleId); // Fetch Style object from DB
                if (style == null) {
                     // Handle case where style is not found
                     throw new IllegalStateException("Không tìm thấy Style cho sản phẩm ID: " + styleId);
                }

                 if (quantity > style.getProduct().getQuantity()) {
                     throw new IllegalStateException("Số lượng sản phẩm không đủ cho Style ID: " + styleId);
                 }else{
                     // Update quantity in database
                     style.getProduct().setQuantity(style.getProduct().getQuantity() - quantity);
                     style.setQuantity(style.getQuantity() - quantity);
                     styleService.updateQuantityForStyle(style.getId(), style.getQuantity());
                     styleService.updateQuantityForProduct(style.getProduct().getId(), style.getProduct().getQuantity());

                     // Create OrderDetail
                     OrderDetail orderDetail = new OrderDetail(idOrder, style, quantity);
                     orderDetailService.insertOrderDetail(orderDetail);
                     order.getListOfDetailOrder().add(orderDetail);
                 }
            }

        } else {
            // Original logic using session cart
            for (CartItem item : cart.getItems().values()) {
                Style style = item.getStyle();
                int quantity = item.getQuantity();
                if (quantity > style.getProduct().getQuantity()) {
                    throw new IllegalStateException("Số lượng sản phẩm không đủ.");
                }else{
                    style.getProduct().setQuantity(style.getProduct().getQuantity() - quantity);
                    style.setQuantity(style.getQuantity() - quantity);
                    styleService.updateQuantityForStyle(style.getId(), style.getQuantity());
                    styleService.updateQuantityForProduct(style.getProduct().getId(), style.getProduct().getQuantity());
                    OrderDetail orderDetail = new OrderDetail(idOrder, style, quantity);
                    orderDetailService.insertOrderDetail(orderDetail);
                    order.getListOfDetailOrder().add(orderDetail);
                }
            }
        }


        // Xử lý thông tin giao hàng - Use data from orderData if available, fallback to request parameters
        String note = null;
        String deliveryFullName = null;
        String deliveryPhone = null;
        String deliveryStreet = null;
        String deliveryCommune = null;
        String deliveryCity = null;
        String deliveryProvince = null;
        boolean otherAddressSelected = false;

        if (orderData != null && orderData.containsKey("delivery")) {
            Map<String, Object> deliveryInfo = (Map<String, Object>) orderData.get("delivery");
            note = (String) deliveryInfo.get("note");
            deliveryFullName = (String) deliveryInfo.get("name");
            deliveryPhone = (String) deliveryInfo.get("phone");
            otherAddressSelected = (Boolean) deliveryInfo.get("otherAddressSelected");

            if (otherAddressSelected && deliveryInfo.containsKey("otherAddress") && deliveryInfo.get("otherAddress") != null) {
                 Map<String, Object> otherAddressInfo = (Map<String, Object>) deliveryInfo.get("otherAddress");
                 deliveryStreet = (String) otherAddressInfo.get("street");
                 deliveryCommune = (String) otherAddressInfo.get("commune");
                 deliveryCity = (String) otherAddressInfo.get("city");
                 deliveryProvince = (String) otherAddressInfo.get("province");
                 deliveryFullName = (String) otherAddressInfo.get("fullName"); // Use other address name if selected
                 deliveryPhone = (String) otherAddressInfo.get("phone"); // Use other address phone if selected
            } else {
                 // If other address not selected, use default address info from JSON or user session
                 // Note: JSON structure has top-level name/phone for delivery even if otherAddressSelected is false
                 // You might need to clarify which name/phone to use here based on your exact JSON structure
                 // For now, sticking to JSON structure: if otherAddressSelected is false, use top-level name/phone
                 // If orderData is available, but delivery info is missing or incomplete, you might fallback to request.getParameter or user session
                 // For simplicity, assuming JSON delivery is the source of truth when orderData is present
            }
        } else {
            // Fallback to original logic using request parameters and user session
            String otherAddressParam = request.getParameter("otherAddress");
            otherAddressSelected = (otherAddressParam != null && otherAddressParam.equals("1"));
            note = request.getParameter("note");

            if (otherAddressSelected) {
                deliveryStreet = request.getParameter("o-street");
                deliveryCommune = request.getParameter("o-commune");
                deliveryCity = request.getParameter("o-city");
                deliveryProvince = request.getParameter("o-province");
                deliveryFullName = request.getParameter("o-fullName");
                deliveryPhone = request.getParameter("o-phone");
            } else {
                // Use user's default address info
                if (user.getAddress() == null) {
                    throw new IllegalStateException("Người dùng không có địa chỉ mặc định.");
                }
                 deliveryFullName = user.getFullName();
                 deliveryPhone = user.getNumberPhone();
                 // Note: The original logic uses user's address ID directly, not components.
                 // If you need to insert a new address, you'll need street, commune, city, province.
                 // If using user's default, you only need user.getAddress().getId()
            }
        }

        Delivery delivery;

        if (otherAddressSelected) {
            // Insert new address from other address info (either from JSON or request params)
             int idAddress = addressService.getLastId() + 1;
             // Ensure all address components are available if inserting new address
             if (deliveryStreet == null || deliveryCommune == null || deliveryCity == null || deliveryProvince == null) {
                  throw new IllegalStateException("Thông tin địa chỉ khác không đầy đủ.");
             }
             Address address = new Address(idAddress, deliveryStreet, deliveryCommune, deliveryCity, deliveryProvince);
             addressService.insertAddress(address);

            delivery = new Delivery(
                    idOrder, idAddress, deliveryFullName, deliveryPhone,
                    cart.getTotalArea(), cart.getShippingFee(), note, "Đang giao hàng" // Assuming totalArea and shippingFee still from cart
            );
        } else {
            // Use user's default address
             if (user.getAddress() == null) {
                 throw new IllegalStateException("Người dùng không có địa chỉ mặc định.");
             }
            delivery = new Delivery(
                    idOrder, user.getAddress().getId(), deliveryFullName, deliveryPhone,
                    cart.getTotalArea(), cart.getShippingFee(), note, "Đang giao hàng"
            );
        }

        deliveryService.insertDelivery(delivery);

        // TODO: Save public_key and signature to database.


        // Trả về đối tượng Ordered - Use data from delivery if available, fallback to user/deliveryService
        // The Ordered object constructor expects specific parameters.
        // Need to ensure the data for these parameters is available from either JSON or session/request params.
         String orderedUserName = user.getFullName(); // Usually from session user
         String orderedAddressDetail = ""; // Need to construct or fetch this

         if (otherAddressSelected) {
             orderedAddressDetail = deliveryStreet + "/" + deliveryCommune + "/" + deliveryCity + "/" + deliveryProvince;
         } else if (user.getAddress() != null) {
              orderedAddressDetail = user.getAddress().getAddressDetail();
         } else if (orderData != null && orderData.containsKey("delivery")) {
             Map<String, Object> deliveryInfo = (Map<String, Object>) orderData.get("delivery");
             if (otherAddressSelected && deliveryInfo.containsKey("otherAddress") && deliveryInfo.get("otherAddress") != null) {
                  Map<String, Object> otherAddressInfo = (Map<String, Object>) deliveryInfo.get("otherAddress");
                  orderedAddressDetail = otherAddressInfo.get("street") + "/" + otherAddressInfo.get("commune") + "/" + otherAddressInfo.get("city") + "/" + otherAddressInfo.get("province");
             } else {
                  // Assuming address detail for default address is available in user object or can be constructed
                  // from top-level address field in JSON if it was included there (current JSON doesn't seem to have it)
                  // Or fetch from DB using delivery.getIdAddress()
                  Address deliveryAddress = addressService.getAddressById(delivery.getIdAddress());
                  if (deliveryAddress != null) {
                       orderedAddressDetail = deliveryAddress.getAddressDetail();
                  }
             }
         }


        return new Ordered(
                cart, idOrder, order.getTimeOrdered(),
                orderedUserName, delivery.getNote(),
                orderedAddressDetail, delivery.getStatus()
        );
    }

}