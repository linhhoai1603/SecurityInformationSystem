package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;

@WebServlet("/admin/check-session")
public class CheckSessionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null) {
            out.println("Không có session nào.");
            return;
        }

        out.println("Session ID: " + session.getId());
        out.println("Creation Time: " + new Date(session.getCreationTime()));
        out.println("Last Accessed: " + new Date(session.getLastAccessedTime()));
        out.println("--- Dữ liệu trong session ---");

        Enumeration<String> names = session.getAttributeNames();
        while (names.hasMoreElements()) {
            String key = names.nextElement();
            Object value = session.getAttribute(key);
            out.println(key + " = " + value);
        }
    }
}
