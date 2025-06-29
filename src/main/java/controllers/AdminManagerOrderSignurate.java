package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Order;
import models.OrderSignatures;
import models.Product;
import services.OrderService;
import services.OrderSignatureService;
import services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "order-signurate", value = "/admin/order-signurate")
public class AdminManagerOrderSignurate extends HttpServlet {
//    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        OrderSignatureService orderSignatureService = new OrderSignatureService();
//        List<OrderSignatures> orderSignatures = orderSignatureService.getSignaturesAll();
//        request.setAttribute("orderSign", orderSignatures);
//        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
        getALlSign(request, response);
    }

//    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if ("searchOrderSign".equals(method)) {
            searchOrderSign(request, response);
        }
//        if("detailOrderSign".equals(method)) {
//            detailOrderSign(request, response);
//        }
        if("getAllSign".equals(method)) {
            getALlSign(request, response);
        }
    }

    private void getALlSign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderSignatureService orderSignatureService = new OrderSignatureService();
        List<OrderSignatures> orderSignatures = orderSignatureService.getSignaturesAll();
        request.setAttribute("orderSign", orderSignatures);
        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
    }

    private void detailOrderSign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        OrderService orderService = new OrderService();
        Order order = orderService.getOrder(orderId);
        OrderSignatureService orderSignatureService = new OrderSignatureService();
        List<OrderSignatures> listOrderSign = orderSignatureService.getSignaturesByIdOrder(orderId);
        if (listOrderSign.isEmpty()) return;
        request.setAttribute("order", order);
        request.setAttribute("orderSign", listOrderSign);
        request.getRequestDispatcher("management-order-signurate-detail.jsp").forward(request, response);
    }

    private void searchOrderSign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputName = request.getParameter("inputName");
        List<OrderSignatures> orderSignatures = new OrderSignatureService().getSignaturesByIdOrder(Integer.parseInt(inputName));
        request.setAttribute("orderSign", orderSignatures);
        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
    }
}
