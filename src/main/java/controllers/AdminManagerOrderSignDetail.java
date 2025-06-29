package controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Order;
import models.OrderDetail;
import models.OrderSignatures;
import services.OrderDetailService;
import services.OrderService;
import services.OrderSignatureService;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(name = "AdminOrderSignDetail", value = "/admin/manager-order-sign-detail")
@MultipartConfig
public class AdminManagerOrderSignDetail extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminManagerOrderSignDetail.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String orderIdStr = req.getParameter("orderId");
//        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
//            req.setAttribute("error", "Thiếu mã đơn hàng. Vui lòng truy cập từ danh sách đơn hàng.");
//            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp); // Chuyển đến trang lỗi
//            return;
//        }
//        try {
//            int orderId = Integer.parseInt(orderIdStr);
//            OrderService orderService = new OrderService();
//            Order order = orderService.getOrder(orderId);
//            if (order == null) {
//                req.setAttribute("error", "Không tìm thấy đơn hàng với mã: " + orderId);
//                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
//                return;
//            }
//            OrderSignatureService orderSignatureService = new OrderSignatureService();
//            List<OrderSignatures> listOrderSign = orderSignatureService.getSignaturesByIdOrder(orderId);
////            if (listOrderSign.isEmpty()) return;
//            if (listOrderSign.isEmpty()) {
//                req.setAttribute("error", "Không tìm thấy chữ ký cho đơn hàng này");
//            }
//            req.setAttribute("order", order);
//            req.setAttribute("orderSign", listOrderSign);
//            req.getRequestDispatcher("management-order-signurate-detail.jsp").forward(req, resp);
//        } catch (NumberFormatException e) {
//            req.setAttribute("error", "Mã đơn hàng không hợp lệ: " + orderIdStr);
//            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
//        }
        String orderIdStr = req.getParameter("orderId");
        LOGGER.info("doGet: orderId = " + orderIdStr);
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            req.setAttribute("error", "Thiếu mã đơn hàng. Vui lòng truy cập từ danh sách đơn hàng.");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
            return;
        }
        try {
            int orderId = Integer.parseInt(orderIdStr);
            OrderService orderService = new OrderService();
            Order order = orderService.getOrder(orderId);
            if (order == null) {
                req.setAttribute("error", "Không tìm thấy đơn hàng với mã: " + orderId);
                req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
                return;
            }
            OrderSignatureService orderSignatureService = new OrderSignatureService();
            List<OrderSignatures> listOrderSign = orderSignatureService.getSignaturesByIdOrder(orderId);
            if (listOrderSign.isEmpty()) {
                req.setAttribute("error", "Không tìm thấy chữ ký cho đơn hàng này");
            }
            req.setAttribute("order", order);
            req.setAttribute("orderSign", listOrderSign);
            req.getRequestDispatcher("management-order-signurate-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            LOGGER.severe("doGet: Invalid orderId format: " + orderIdStr + ", Error: " + e.getMessage());
            req.setAttribute("error", "Mã đơn hàng không hợp lệ: " + orderIdStr);
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String method = req.getParameter("method");
//        if ("editOrderItem".equals(method)) {
//            editOrderItem(req, resp);
//        }
//        if ("verifySignature".equals(method)) {
//            verifySignature(req, resp);
//        }
        String method = req.getParameter("method");
        LOGGER.info("doPost: method = " + method);
        if ("editOrderItem".equals(method)) {
            editOrderItem(req, resp);
        } else if ("verifySignature".equals(method)) {
            verifySignature(req, resp);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> responseJson = new LinkedHashMap<>();
            responseJson.put("error", "Phương thức không hợp lệ: " + (method != null ? method : "null"));
            new ObjectMapper().writeValue(resp.getWriter(), responseJson);
        }
    }

    private void editOrderItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int orderId = Integer.parseInt(req.getParameter("orderId"));
//        int detailId = Integer.parseInt(req.getParameter("detailId"));
//        int quantity = Integer.parseInt(req.getParameter("quantity"));
//
//        OrderService orderService = new OrderService();
//        Order order = orderService.getOrder(orderId);
//        OrderDetailService orderDetailService = new OrderDetailService();
//        OrderDetail orderDetail = orderDetailService.getOrderDetailById(detailId);
//
//        orderDetail.setQuantity(quantity);
//        double price = orderDetail.getStyle().getProduct().getPrice().getLastPrice();
//        double totalPrice = orderDetail.getQuantity() * price;
//        orderDetail.setTotalPrice(totalPrice);
//        orderDetailService.updateOrderDetail(orderDetail);
//
//        List<OrderDetail> orderDetailList = order.getListOfDetailOrder();
//        double lastPrice = 0.0;
//        for (OrderDetail orderDetail2 : orderDetailList) {
//            lastPrice += orderDetail2.getTotalPrice();
//        }
//        order.setLastPrice(lastPrice);
//        orderService.updateOrder(order);
//
//        doGet(req, resp);
        String orderIdStr = req.getParameter("orderId");
        String detailIdStr = req.getParameter("detailId");
        String quantityStr = req.getParameter("quantity");
        LOGGER.info("editOrderItem: orderId = " + orderIdStr + ", detailId = " + detailIdStr + ", quantity = " + quantityStr);

        if (orderIdStr == null || detailIdStr == null || quantityStr == null || orderIdStr.trim().isEmpty() || detailIdStr.trim().isEmpty() || quantityStr.trim().isEmpty()) {
            req.setAttribute("error", "Thiếu tham số orderId, detailId hoặc quantity");
            doGet(req, resp);
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            int detailId = Integer.parseInt(detailIdStr);
            int quantity = Integer.parseInt(quantityStr);

            if (quantity <= 0) {
                req.setAttribute("error", "Số lượng phải lớn hơn 0");
                doGet(req, resp);
                return;
            }

            OrderService orderService = new OrderService();
            Order order = orderService.getOrder(orderId);
            if (order == null) {
                req.setAttribute("error", "Không tìm thấy đơn hàng với mã: " + orderId);
                doGet(req, resp);
                return;
            }

            OrderDetailService orderDetailService = new OrderDetailService();
            OrderDetail orderDetail = orderDetailService.getOrderDetailById(detailId);
            if (orderDetail == null) {
                req.setAttribute("error", "Không tìm thấy chi tiết đơn hàng với mã: " + detailId);
                doGet(req, resp);
                return;
            }

            orderDetail.setQuantity(quantity);
            double price = orderDetail.getStyle().getProduct().getPrice().getLastPrice();
            double totalPrice = orderDetail.getQuantity() * price;
            orderDetail.setTotalPrice(totalPrice);
            orderDetailService.updateOrderDetail(orderDetail);

            List<OrderDetail> orderDetailList = order.getListOfDetailOrder();
            double lastPrice = 0.0;
            for (OrderDetail detail : orderDetailList) {
                lastPrice += detail.getTotalPrice();
            }
            order.setLastPrice(lastPrice);
            orderService.updateOrder(order);

            doGet(req, resp);
        } catch (NumberFormatException e) {
            LOGGER.severe("editOrderItem: Invalid input format: " + e.getMessage());
            req.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            doGet(req, resp);
        } catch (Exception e) {
            LOGGER.severe("editOrderItem: Error: " + e.getMessage());
            req.setAttribute("error", "Đã xảy ra lỗi khi cập nhật đơn hàng: " + e.getMessage());
            doGet(req, resp);
        }
    }

    private void verifySignature(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> responseJson = new LinkedHashMap<>();
        try {
//            int orderId = Integer.parseInt(req.getParameter("orderId"));
//            int signatureId = Integer.parseInt(req.getParameter("signatureId"));
            String orderIdStr = req.getParameter("orderId");
            String signatureIdStr = req.getParameter("signatureId");
            LOGGER.info("verifySignature: signatureId = " + signatureIdStr + ", orderId = " + orderIdStr);

            if (orderIdStr == null || orderIdStr.trim().isEmpty() || signatureIdStr == null || signatureIdStr.trim().isEmpty()) {
                responseJson.put("error", "Thiếu hoặc không hợp lệ tham số signatureId hoặc orderId");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                new ObjectMapper().writeValue(resp.getWriter(), responseJson);
                return;
            }

            int orderId = Integer.parseInt(orderIdStr);
            int signatureId = Integer.parseInt(signatureIdStr);

            OrderSignatureService signatureService = new OrderSignatureService();
            OrderSignatures orderSignatures = signatureService.getOrderSignatureById(signatureId);
            if (orderSignatures == null) {
                responseJson.put("error", "Không tìm thấy chữ ký");
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                new ObjectMapper().writeValue(resp.getWriter(), responseJson);
                return;
            }

            Map<String, String> result = signatureService.verifySignature(orderId);
            String status = result.get("result").contains("thành công") ? "verified" : "not verified";
            boolean updated = signatureService.updateSignatureStatus(signatureId, status);

            if (!updated) {
                responseJson.put("error", "Không thể cập nhật trạng thái chữ ký sau xác minh");
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                new ObjectMapper().writeValue(resp.getWriter(), responseJson);
                return;
            }

//            req.getSession().setAttribute("verificationResult", result.get("result"));
//            req.getSession().setAttribute("orderDataHash", result.get("orderDataHash"));
//            req.getSession().setAttribute("orderDataJson", result.get("orderDataJson"));
//            req.setAttribute("openModalSignatureId", signatureId);
            responseJson.put("verificationResult", result.get("result"));
            responseJson.put("orderDataHash", result.get("orderDataHash"));
            responseJson.put("orderDataJson", result.get("orderDataJson"));
            responseJson.put("signatureId", signatureId);
            resp.setStatus(HttpServletResponse.SC_OK);
            new ObjectMapper().writeValue(resp.getWriter(), responseJson);
        } catch (NumberFormatException e) {
            LOGGER.severe("verifySignature: Invalid input format: " + e.getMessage());
            responseJson.put("error", "Dữ liệu đầu vào không hợp lệ");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            new ObjectMapper().writeValue(resp.getWriter(), responseJson);
        } catch (Exception e) {
            LOGGER.severe("verifySignature: Error: " + e.getMessage());
            responseJson.put("error", "Lỗi xác thực: " + e.getMessage());
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            new ObjectMapper().writeValue(resp.getWriter(), responseJson);
        }
    }
}
