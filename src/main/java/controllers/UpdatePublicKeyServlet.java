package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.User;
import models.UserKeys;
import services.UserInForServies;
import services.UserKeyService;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;

@WebServlet(value = "/update-public-key")
@MultipartConfig
public class UpdatePublicKeyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String manualKey = request.getParameter("manualKey");
        String publicKey = request.getParameter("publicKey");

        if (manualKey != null && !manualKey.trim().isEmpty()) {
            publicKey = manualKey;
        } else {
            Part filePart = request.getPart("keyFile");
            if (filePart != null && filePart.getSize() > 0) {
                System.out.println(filePart.getName());
                InputStream inputStream = filePart.getInputStream();
                publicKey = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            }
        }

        UserKeyService userKeyService = new UserKeyService();
        if (publicKey != null && !publicKey.trim().isEmpty()) {
            HttpSession session = request.getSession();
            UserKeys userKeys = (UserKeys) session.getAttribute("userKeys");
            User user = (User) session.getAttribute("user");
            System.out.println(user.getId());

//            if (userKeys == null) {
                boolean inserted = userKeyService.insertUserKey(user.getId(), publicKey);
                if (inserted) {
                    userKeys = userKeyService.getCurrentUserKey(user.getId());
                    session.setAttribute("userKeys", userKeys);
                    request.setAttribute("message", "Thêm khóa xác nhận thành công!");
                } else {
                    request.setAttribute("message", "Thêm khóa thất bại.");
                }
//            } else {
//                boolean updated = userKeyService.updateUserKey(user.getId(), publicKey);
//                if (updated) {
//                    userKeys.setPublicKey(publicKey);
//                    userKeys.setCreate_at(LocalDateTime.now());
//                    session.setAttribute("userKeys", userKeys);
//                    request.setAttribute("message", "Cập nhật khóa xác nhận thành công!");
//                } else {
//                    request.setAttribute("message", "Cập nhật khóa thất bại.");
//                }
//            }

            request.setAttribute("userKeys", userKeys);
        }

        request.getRequestDispatcher("enter-public-key.jsp").forward(request, response);
    }
}
