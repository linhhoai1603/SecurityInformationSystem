package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import services.UserInForServies;
import services.UserKeyService;
import services.UserService;

import java.io.IOException;

@WebServlet(value = "/personal-inf")
public class PersonalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                UserService userService = new UserService();
                user = userService.getUserById(user.getId());

                session.setAttribute("user", user);
                request.setAttribute("user", user);
                request.getRequestDispatcher("user.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int idUser = user.getId();
        int idAddress = user.getAddress() != null ? user.getAddress().getId() : -1;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullName");
        String phone = request.getParameter("phoneNumber");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String commune = request.getParameter("commune");
        String street = request.getParameter("street");
        String pubKey = request.getParameter("pubKey");

        UserInForServies sv = new UserInForServies();

        email = (email == null || email.isEmpty()) ? user.getEmail() : email;
        fullname = (fullname == null || fullname.isEmpty()) ? user.getFullName() : fullname;
        phone = (phone == null || phone.isEmpty()) ? user.getNumberPhone() : phone;
        province = (province == null || province.isEmpty()) ? user.getAddress().getProvince() : province;
        city = (city == null || city.isEmpty()) ? user.getAddress().getCity() : city;
        commune = (commune == null || commune.isEmpty()) ? user.getAddress().getCommune() : commune;
        street = (street == null || street.isEmpty()) ? user.getAddress().getStreet() : street;

        if (sv.updateInfo(idUser, idAddress, email, fullname, phone, province, city, commune, street)) {
            user.setEmail(email);
            user.setFullName(fullname);
            user.setNumberPhone(phone);

            if (user.getAddress() != null) {
                user.getAddress().setProvince(province);
                user.getAddress().setCity(city);
                user.getAddress().setCommune(commune);
                user.getAddress().setStreet(street);
            }

            // Cập nhật lại đối tượng user trong session
            session.setAttribute("user", user);

            System.out.println("Chua thuc hien xac nhan form nhap du lieu cua pub key");
            if (pubKey != null && !pubKey.isEmpty()) {
                System.out.println("Dang thuc hien save pub key - Personal Servlet");
                UserKeyService userKeyService = new UserKeyService();
                boolean success = userKeyService.saveOrUpdateUserKey(idUser, pubKey);
                System.out.println("Sau khi thuc hien save pub - UserKeyService");
                if (!success) {
                    request.setAttribute("message", "Cập nhật thông tin thành công nhưng cập nhật khóa công khai thất bại.");
                    request.setAttribute("messageType", "error");
                }
            }
            request.setAttribute("message", "Cập nhật thành công!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại.");
            request.setAttribute("messageType", "error");
        }
        request.getRequestDispatcher("user.jsp").forward(request, response);
    }

}
