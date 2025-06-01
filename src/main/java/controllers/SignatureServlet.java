package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder; // Import GsonBuilder
import com.google.gson.JsonPrimitive; // Import JsonPrimitive
import com.google.gson.JsonSerializer; // Import JsonSerializer
import com.google.gson.JsonDeserializer; // Import JsonDeserializer (nếu cần deserialize)
import com.google.gson.JsonElement; // Import JsonElement
import com.google.gson.JsonParseException; // Import JsonParseException

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.OrderSignatures;
import services.OrderSignatureService;

import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDateTime; // Import LocalDateTime
import java.time.format.DateTimeFormatter; // Import DateTimeFormatter

// Đảm bảo URL mapping khớp với URL fetch trong ordered.jsp
@WebServlet(name = "SignatureServlet", value = "/Signature")
public class SignatureServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SignatureServlet.class.getName());

    private OrderSignatureService signatureService;

    // Tạo một instance Gson với TypeAdapter cho LocalDateTime
    private Gson gson; // Khai báo Gson instance

    @Override
    public void init() throws ServletException {
        super.init();
        LOGGER.info("SignatureServlet initializing...");
        try {
            signatureService = new OrderSignatureService();
            LOGGER.info("OrderSignatureService initialized successfully.");

            GsonBuilder gsonBuilder = new GsonBuilder();

            // *** THÊM DÒNG NÀY ĐỂ CHỈ SERIALIZE CÁC TRƯỜNG CÓ @Expose ***
            gsonBuilder.excludeFieldsWithoutExposeAnnotation();

            // Đăng ký Type Adapter cho LocalDateTime (giữ nguyên phần này)
            gsonBuilder.registerTypeAdapter(LocalDateTime.class, (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) -> {
                DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
                return new JsonPrimitive(formatter.format(src));
            });
            gsonBuilder.registerTypeAdapter(LocalDateTime.class, (JsonDeserializer<LocalDateTime>) (json, typeOfT, context) -> {
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
                    return LocalDateTime.parse(json.getAsString(), formatter);
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Failed to parse LocalDateTime: " + json.getAsString(), e);
                    throw new JsonParseException("Failed to parse LocalDateTime: " + json.getAsString(), e);
                }
            });

            gson = gsonBuilder.create();
            LOGGER.info("Gson with LocalDateTime adapter and @Expose exclusion created successfully.");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during SignatureServlet initialization", e);
            throw new ServletException("Failed to initialize SignatureServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("SignatureServlet received GET request.");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int orderId = -1;
        String orderIdParam = request.getParameter("orderId");
        LOGGER.log(Level.INFO, "Received orderId parameter: ''{0}''", orderIdParam);

        try {
            if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
                orderId = Integer.parseInt(orderIdParam);
                LOGGER.log(Level.INFO, "Parsed orderId: {0}", orderId);
            } else {
                LOGGER.warning("Order ID parameter is missing or empty.");
                sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Order ID parameter is missing or empty.");
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid Order ID format: " + orderIdParam, e);
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid Order ID format.");
            return;
        }

        List<OrderSignatures> orderSignatures = null;
        try {
            LOGGER.log(Level.INFO, "Calling OrderSignatureService.getSignaturesByIdOrder with orderId: {0}", orderId);
            orderSignatures = signatureService.getSignaturesByIdOrder(orderId);
            LOGGER.log(Level.INFO, "OrderSignatureService.getSignaturesByIdOrder returned {0} signatures.", orderSignatures != null ? orderSignatures.size() : 0);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error calling OrderSignatureService.getSignaturesByIdOrder", e);
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving signature details from database.");
            return;
        }

        // Chuyển đổi danh sách OrderSignatures thành JSON array string
        // Sử dụng instance Gson đã được tạo trong init()
        String jsonResponse;
        try {
            jsonResponse = gson.toJson(orderSignatures); // Dòng này bây giờ sẽ sử dụng TypeAdapter cho LocalDateTime
            LOGGER.log(Level.INFO, "Successfully serialized data to JSON. JSON length: {0}", jsonResponse.length());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during JSON serialization", e);
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing data for display.");
            return;
        }

        // Ghi JSON vào response output stream
        try {
            PrintWriter out = response.getWriter();
            out.write(jsonResponse);
            out.flush();
            LOGGER.info("JSON response sent successfully.");
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing JSON response to client", e);
        }
    }

    private void sendErrorResponse(HttpServletResponse response, int statusCode, String message) throws IOException {
        if (!response.isCommitted()) {
            response.setStatus(statusCode);
            response.setContentType("text/plain");
            response.getWriter().write(message);
            response.getWriter().flush();
            LOGGER.log(Level.SEVERE, "Sent error response: Status {0}, Message: {1}", new Object[]{statusCode, message});
        } else {
            LOGGER.warning("Response already committed. Could not send error: Status " + statusCode + ", Message: " + message);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        LOGGER.info("SignatureServlet destroyed.");
    }
}