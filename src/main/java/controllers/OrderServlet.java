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
        // Keep using session cart for product details and totals as before,
        // or switch to using 'orderData' products/summary
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


        // Tạo orderDetails
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