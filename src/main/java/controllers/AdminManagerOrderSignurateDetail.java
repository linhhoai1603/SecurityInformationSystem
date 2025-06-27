package controllers;

import jakarta.servlet.annotation.WebServlet;
import models.Order;
import models.OrderDetail;
import models.OrderSignatures;
import models.UserKeys;
import services.OrderDetailService;
import services.OrderService;
import services.OrderSignatureService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/admin/order-signature-detail")
public class AdminManagerOrderSignurateDetail extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        if ("editOrderItem".equals(method)) {
            editOrderItem(req, resp);
        }
        if ("editStatusOrderSign".equals(method)) {
            editStatusOrderSign(req, resp);
        }
    }

    private void editOrderItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        int detailId = Integer.parseInt(req.getParameter("detailId"));
        OrderService orderService = new OrderService();
        OrderDetailService orderDetailService = new OrderDetailService();

        OrderDetail detail = orderDetailService.getOrderDetailById(detailId);
        detail.setQuantity(quantity);
        detail.setTotalPrice(detail.getQuantity() * detail.getStyle().getProduct().getPrice().getLastPrice());
        orderDetailService.updateOrderDetail(detail);

        Order order = orderService.getOrder(orderId);
        double totalOrderPrice = order.getListOfDetailOrder().stream().mapToDouble(OrderDetail::getTotalPrice).sum();
        order.setLastPrice(totalOrderPrice);
        orderService.updateOrder(order);

        redirectToDetail(req, resp);
    }

    private void editStatusOrderSign(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    private void redirectToDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String orderId = req.getParameter("orderId");
        if (orderId != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/order-signurate?method=detailOrderSign&id=" + orderId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/order-signurate");
        }
    }
}
