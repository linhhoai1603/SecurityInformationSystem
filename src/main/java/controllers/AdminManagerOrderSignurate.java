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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderSignatureService orderSignatureService = new OrderSignatureService();
        List<OrderSignatures> orderSignatures = orderSignatureService.getSignaturesAll();
        request.setAttribute("orderSign", orderSignatures);
        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method = request.getParameter("method");
        if("searchOrderSign".equals(method)) {
            searchOrderSign(request, response);
        }
    }

    private void searchOrderSign(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputName = request.getParameter("inputName");
        List<OrderSignatures> orderSignatures = new OrderSignatureService().getSignaturesByIdOrder(Integer.parseInt(inputName));
        request.setAttribute("orderSign", orderSignatures);
        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
    }
}
