package controllers;

import jakarta.servlet.annotation.WebServlet;
import models.Order;
import models.OrderSignatures;
import models.UserKeys;
import services.OrderService;
import services.OrderSignatureService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(value = "/admin/order-signature-detail")
public class AdminManagerOrderSignurateDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);
        OrderSignatureService orderSignatureService = new OrderSignatureService();
        List<OrderSignatures> listOrderSign = orderSignatureService.getSignaturesByIdOrder(orderId);
        if (listOrderSign.isEmpty()) return;
        OrderSignatures orderSignatures = listOrderSign.getLast();
        UserKeys userKeys = orderSignatures.getUserKeys();
        request.setAttribute("order", order);
        request.setAttribute("oderSign", orderSignatures);
        request.setAttribute("userKeys", userKeys);
//        request.getRequestDispatcher("management-detail-orders.jsp").forward(request, response);
    }
}
