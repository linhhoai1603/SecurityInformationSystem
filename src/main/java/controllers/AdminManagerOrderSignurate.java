package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Order;
import models.OrderSignInfo;
import models.OrderSignatures;
import models.UserKeys;
import services.OrderService;
import services.OrderSignInfoServices;
import services.OrderSignatureService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "order-signurate", value = "/admin/order-signurate")
public class AdminManagerOrderSignurate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("test 1");
        int loca = request.getParameter("loca") == null ? 1 : Integer.parseInt(request.getParameter("loca"));
        System.out.println("test 2");
        OrderService os = new OrderService();
        int nuPage = os.getNuPage(5);
        System.out.println("test 3");
        List<Order> orders = os.getOrdersByPage(loca, 5);
        System.out.println("test 4");
        OrderSignInfoServices orderSignInfoServices = new OrderSignInfoServices();
        System.out.println("test 5");
        List<OrderSignInfo> orderSignInfos = orderSignInfoServices.getOrderSignInfo();
        System.out.println("test 6");
        request.setAttribute("orderSign", orderSignInfos);
        System.out.println("test 7");
        request.setAttribute("orders", orders);
        System.out.println("test 8");
        request.setAttribute("nuPage", nuPage);
        System.out.println("test 9");
        request.setAttribute("loca", loca);
        System.out.println("test 10");
        request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("idOrder"));
            OrderService os = new OrderService();
            Order order = os.getOrder(id);

            if (order == null) {
                request.setAttribute("error", "Đơn hàng không tồn tại");
                request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/order-signurate-detail?orderId=" + order.getId());
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Không tồn mã đơn hang");
            request.getRequestDispatcher("management_ordered_signureate.jsp").forward(request, response);
        }
    }
}
