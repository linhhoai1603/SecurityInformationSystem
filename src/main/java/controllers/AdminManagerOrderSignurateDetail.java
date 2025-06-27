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
    }
}
