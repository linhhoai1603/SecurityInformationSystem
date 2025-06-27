package dao;

import connection.DBConnection;
import models.*;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;

public class OrderSignatureDAO {
    Jdbi jdbi;

    public OrderSignatureDAO() {
        this.jdbi = DBConnection.getConnetion();
    }


    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
        String query = "INSERT INTO `order_signatures` (`order_id`, `key_id`,`delivery_id` ,`digital_signature`, `verified`) \n" +
                "VALUES (?, ?, ?, ?, ?);";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, orderSignatures.getOrder().getId())
                    .bind(1, orderSignatures.getUserKeys().getId())
                    .bind(2, orderSignatures.getDelivery().getId())
                    .bind(3, orderSignatures.getDigitalSignature())
                    .bind(4, orderSignatures.getVerified())
                    .execute() > 0;
        });
    }

//    public List<OrderSignatures> getSignaturesByIdOrder(int orderId) {
//        String query = "SELECT \n" +
//                "os.id AS id_orderSignatures,\n" +
//                "os.order_id AS id_order,\n" +
//                "os.key_id AS id_userKey,\n" +
//                "os.delivery_id AS id_delivery,\n" +
//                "os.digital_signature AS digital_signature ,\n" +
//                "os.verified AS verify_status,\n" +
//                "os.create_at AS create_at, \n" +
//                "\n" +
//                "d.fullName AS fullName, \n" +
//                "d.phoneNumber AS phoneNumber,\n" +
//                "us.public_key AS public_key\n" +
//                "\n" +
//                "from order_signatures os \n" +
//                "JOIN orders o ON os.order_id = o.id \n" +
//                "JOIN user_keys us ON os.key_id = us.id \n" +
//                "JOIN deliveries d on os.delivery_id = d.id\n" +
//                "WHERE o.id = :orderId";
//
//        return jdbi.withHandle(handle -> {
//            return handle.createQuery(query)
//                    // Sử dụng tên tham số đúng khi bind
//                    .bind("orderId", orderId)
//                    .map((rs, ctx) -> {
//                        OrderSignatures signature = new OrderSignatures();
//
//                        signature.setId(rs.getInt("id_orderSignatures"));
//                        signature.setDigitalSignature(rs.getString("digital_signature"));
//                        signature.setVerified(rs.getString("verify_status"));
//                        signature.setCreate_at(rs.getObject("create_at", LocalDateTime.class));
//
//                        Order order = new Order();
//                        order.setId(rs.getInt("id_order"));
//                        signature.setOrder(order);
//
//                        UserKeys userKeys = new UserKeys();
//                        userKeys.setId(rs.getInt("id_userKey"));
//                        userKeys.setPublicKey(rs.getString("public_key"));
//                        signature.setUserKeys(userKeys);
//
//                        Delivery delivery = new Delivery();
//                        delivery.setId(rs.getInt("id_delivery"));
//                        delivery.setFullName(rs.getString("fullName"));
//                        delivery.setPhoneNumber(rs.getString("phoneNumber"));
//                        signature.setDelivery(delivery);
//
//                        return signature;
//                    }).list();
//
//        });
//    }

    // Phương thức để lấy DANH SÁCH các đối tượng OrderSignatures theo Order ID
    // Nếu phương thức này chạy được trong main, logic truy vấn và mapping là đúng.
    // Lỗi xảy ra ở frontend có thể do vấn đề ở Service, Servlet, hoặc cấu hình JDBI trong môi trường web.
    public List<OrderSignatures> getSignaturesByIdOrder(int orderId) {
        String query = "SELECT \n" +
                "os.id AS id_orderSignatures,\n" +
                "os.order_id AS id_order,\n" +
                "os.key_id AS id_userKey,\n" +
                "os.delivery_id AS id_delivery,\n" +
                "os.digital_signature AS digital_signature ,\n" +
                "os.verified AS verify_status,\n" +
                "os.create_at AS create_at, \n" +
                "\n" +
                "d.fullName AS fullName, \n" +
                "d.phoneNumber AS phoneNumber,\n" +
                "us.public_key AS public_key\n" +
                "\n" +
                "from order_signatures os \n" +
                "JOIN orders o ON os.order_id = o.id \n" +
                "JOIN user_keys us ON os.key_id = us.id \n" +
                "JOIN deliveries d on os.delivery_id = d.id\n" +
                "WHERE o.id = :orderId"; // Đảm bảo sử dụng tham số đặt tên :orderId

        // JDBI's withHandle block tự động quản lý kết nối và PreparedStatement.
        // Bất kỳ SQLException nào xảy ra trong quá trình thực thi query hoặc mapping
        // sẽ được wrapped trong một RuntimeException (thường là JdbiException) và ném ra khỏi block withHandle.
        // Việc bắt các ngoại lệ này thường được thực hiện ở lớp Service hoặc Servlet.
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    // Sử dụng tên tham số đúng khi bind
                    .bind("orderId", orderId) // Đảm bảo bind với tên "orderId"
                    .map((rs, ctx) -> {
                        // ** Phần mapping dữ liệu từ ResultSet vào đối tượng OrderSignatures **
                        // Nếu mã này chạy được trong main, các tên cột và kiểu dữ liệu ở đây là đúng
                        // VỚI DỮ LIỆU BẠN ĐÃ TEST.
                        // Nếu có dữ liệu khác trong DB gây lỗi khi chạy web, bạn cần debug tại đây.
                        OrderSignatures signature = new OrderSignatures();

                        try { // Thêm try-catch nhỏ ở đây để debug mapping từng hàng nếu cần
                            signature.setId(rs.getInt("id_orderSignatures"));
                            signature.setDigitalSignature(rs.getString("digital_signature"));
                            signature.setVerified(rs.getString("verify_status"));
                            // Lấy ngày tạo - đảm bảo kiểu dữ liệu phù hợp
                            // Sử dụng getObject với LocalDateTime nếu cột là TIMESTAMP/DATETIME
                            // Hoặc rs.getTimestamp("create_at") nếu bạn dùng java.sql.Timestamp và java.sql.Timestamp
                            try {
                                signature.setCreate_at(rs.getObject("create_at", LocalDateTime.class));
                            } catch (SQLException e) {
                                signature.setCreate_at(null);
                            }

                            Order order = new Order();
                            order.setId(rs.getInt("id_order"));
                            signature.setOrder(order); // Cần có setter setOrder trong OrderSignatures

                            UserKeys userKeys = new UserKeys();
                            userKeys.setId(rs.getInt("id_userKey"));
                            userKeys.setPublicKey(rs.getString("public_key"));
                            signature.setUserKeys(userKeys); // Cần có setter setUserKeys trong OrderSignatures

                            Delivery delivery = new Delivery();
                            delivery.setId(rs.getInt("id_delivery"));
                            delivery.setFullName(rs.getString("fullName"));
                            delivery.setPhoneNumber(rs.getString("phoneNumber"));
                            signature.setDelivery(delivery); // Cần có setter setDelivery trong OrderSignatures

                            return signature; // Trả về đối tượng signature đã điền dữ liệu
                        } catch (SQLException e) {
                            // Log lỗi cụ thể khi mapping một hàng dữ liệu nếu xảy ra
                            System.err.println("Error mapping row for orderId " + orderId + ": " + e.getMessage());
                            e.printStackTrace();
                            // Ném lại ngoại lệ để JDBI và lớp gọi bắt
                            throw new RuntimeException("Failed to map OrderSignatures data for orderId: " + orderId, e);
                        }

                    })
                    .list(); // <--- Sử dụng .list() để lấy tất cả kết quả vào danh sách
        });
    }

    public String getPublicKeyById(int id) {
        String sql = "SELECT u.public_key FROM order_signatures os \n" +
                "JOIN user_keys u ON os.key_id = u.id \n" +
                "WHERE os.id = ?";

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapTo(String.class)
                    .findFirst()
                    .orElse(null);
        });
    }

    public List<OrderSignatures> getSignaturesAll() {
        String sql = "SELECT \n" +
                "os.id AS id_orderSignatures,\n" +
                "os.order_id AS id_order,\n" +
                "os.key_id AS id_userKey,\n" +
                "os.delivery_id AS id_delivery,\n" +
                "os.digital_signature AS digital_signature,\n" +
                "os.verified AS verify_status,\n" +
                "os.create_at AS create_at,\n" +
                "d.fullName AS fullName,\n" +
                "d.phoneNumber AS phoneNumber,\n" +
                "uk.public_key AS public_key,\n" +
                "uk.user_id AS id_user,\n" +
                "o.timeOrder AS time_ordered,\n" +
                "o.statusOrder AS status,\n" +
                "o.totalPrice AS total_price,\n" +
                "o.lastPrice AS last_price\n" +
                "FROM order_signatures os\n" +
                "JOIN orders o ON os.order_id = o.id\n" +
                "JOIN user_keys uk ON os.key_id = uk.id\n" +
                "JOIN deliveries d ON os.delivery_id = d.id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            try {
                                OrderSignatures signature = new OrderSignatures();
                                signature.setId(rs.getInt("id_orderSignatures"));
                                signature.setDigitalSignature(rs.getString("digital_signature"));
                                signature.setVerified(rs.getString("verify_status"));
                                signature.setCreate_at(rs.getObject("create_at", LocalDateTime.class));

                                Order order = new Order();
                                order.setId(rs.getInt("id_order"));
                                order.setTimeOrdered(rs.getObject("time_ordered", LocalDateTime.class));
                                order.setStatus(rs.getString("status"));
                                order.setTotalPrice(rs.getDouble("total_price"));
                                order.setLastPrice(rs.getDouble("last_price"));
                                User user = new User();
                                user.setId(rs.getInt("id_user"));
                                order.setUser(user);
                                signature.setOrder(order);

                                UserKeys userKeys = new UserKeys();
                                userKeys.setId(rs.getInt("id_userKey"));
                                userKeys.setPublicKey(rs.getString("public_key"));
                                userKeys.setUser(user);
                                signature.setUserKeys(userKeys);

                                Delivery delivery = new Delivery();
                                delivery.setId(rs.getInt("id_delivery"));
                                delivery.setFullName(rs.getString("fullName"));
                                delivery.setPhoneNumber(rs.getString("phoneNumber"));
                                signature.setDelivery(delivery);

                                return signature;
                            } catch (SQLException e) {
                                System.err.println("Error OrderSignurateDao getSignALl:" + e.getMessage());
                                e.printStackTrace();
                                throw new RuntimeException("Failed to map OrderSignatures data", e);
                            }
                        }).list()
        );
    }

    public static void main(String[] args) {
        OrderSignatureDAO dao = new OrderSignatureDAO();
        System.out.println(dao.getPublicKeyById(10));
    }

//    public static void main(String[] args) {
//        // Đặt Order ID bạn muốn test vào đây
//        int testOrderId = 59; // Hoặc bất kỳ ID đơn hàng nào tồn tại trong DB của bạn
//
//        System.out.println("Testing getSignaturesByIdOrder for Order ID: " + testOrderId);
//
//        try {
//            // Tạo instance của DAO
//            OrderSignatureDAO dao = new OrderSignatureDAO();
//
//            // Gọi phương thức cần test
//            List<OrderSignatures> signatures = dao.getSignaturesByIdOrder(testOrderId);
//
//            // In kết quả
//            for(OrderSignatures signature : signatures){
//                if (signature != null) {
//                    System.out.println("Found Order Signature:");
//                    System.out.println("  ID: " + signature.getId());
//                    System.out.println("  Order ID: " + (signature.getOrder() != null ? signature.getOrder().getId() : "N/A"));
//                    System.out.println("  Public Key: " + (signature.getUserKeys() != null ? signature.getUserKeys().getPublicKey() : "N/A"));
//                    System.out.println("  Delivery FullName: " + (signature.getDelivery() != null ? signature.getDelivery().getFullName() : "N/A"));
//                    System.out.println("  Digital Signature (snippet): " + (signature.getDigitalSignature() != null ? signature.getDigitalSignature().substring(0, Math.min(signature.getDigitalSignature().length(), 50)) + "..." : "N/A")); // In một phần
//                    System.out.println("  Verified Status: " + signature.getVerified());
//                    System.out.println("  Create At: " + signature.getCreate_at());
//                    // Thêm các thông tin khác bạn muốn in
//                } else {
//                    System.out.println("No Order Signature found for Order ID: " + testOrderId);
//                }
//            }
//
//        } catch (Exception e) {
//            // Bắt các ngoại lệ có thể xảy ra (ví dụ: lỗi kết nối DB)
//            System.err.println("An error occurred during testing:");
//            e.printStackTrace();
//        }
//    }


//    public static void main(String[] args) {
//        // Lấy thời gian hiện tại
//        LocalDateTime now = LocalDateTime.now();
//
//        // Định dạng thời gian nếu cần
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//        String formattedDateTime = now.format(formatter);
//
//        // Get Jdbi instance
//        Jdbi jdbi = DBConnection.getJdbi();
//
//        jdbi.useHandle(handle -> {
//            // Instantiate necessary DAOs with the shared handle if they support it,
//            // or rely on DBConnection providing the static Jdbi instance they use internally.
//            // Since DAOs currently use DBConnection.getConnetion()/getJdbi() internally,
//            // they will use the same static Jdbi instance we got here.
//            UserDao userDao = new UserDao();
//            AddressDao addressDao = new AddressDao();
//            OrderDAO orderDao = new OrderDAO();
//            DeliveryDAO deliveryDao = new DeliveryDAO();
//            UserKeyDAO userKeyDao = new UserKeyDAO();
//
//            try {
//                // Insert sample Address
//                Address sampleAddress = new Address();
//                sampleAddress.setCity("Sample City");
//                sampleAddress.setProvince("Sample Province");
//                sampleAddress.setCommune("Sample Commune");
//                sampleAddress.setStreet("Sample Street");
//                int addressId = addressDao.insertAddressReturnId(sampleAddress);
//                System.out.println("Inserted Address with ID: " + addressId);
//
//                // Insert sample User
//                int userId = userDao.insertUser("testuser@example.com", "Test User", "1234567890", addressId, "sample_image_url");
//                System.out.println("Inserted User with ID: " + userId);
//
//                // Create User object with generated ID for UserKeys
//                User userForKeys = new User();
//                userForKeys.setId(userId);
//
//                // Create sample UserKeys object
//                UserKeys userKeysToInsert = new UserKeys();
//                userKeysToInsert.setUser(userForKeys);
//                userKeysToInsert.setPublicKey("sample_public_key"); // Using the sample public key
//                userKeysToInsert.setCreate_at(now); // Using the LocalDateTime object
//
//                // Insert sample UserKeys and get the generated ID
//                int userKeyId = userKeyDao.insertUserKey(userKeysToInsert);
//                System.out.println("Inserted UserKeys with ID: " + userKeyId);
//
//
//                // Create User and Address objects with generated IDs for Order and Delivery
//                User userForOrder = new User();
//                userForOrder.setId(userId);
//
//                Address addressForDelivery = new Address();
//                addressForDelivery.setId(addressId);
//
//                // Insert sample Order
//                Order sampleOrder = new Order();
//                sampleOrder.setTimeOrdered(now);
//                sampleOrder.setUser(userForOrder);
//                sampleOrder.setStatus("Pending");
//                sampleOrder.setTotalPrice(100.0);
//                sampleOrder.setLastPrice(90.0);
//                // Assuming a voucher is optional, setting to null for this test
//                sampleOrder.setVoucher(null);
//                int orderId = orderDao.insertOrder(sampleOrder);
//                System.out.println("Inserted Order with ID: " + orderId);
//
//                // Create Order object with generated ID for Delivery
//                Order orderForDelivery = new Order();
//                orderForDelivery.setId(orderId);
//
//                // Insert sample Delivery
//                Delivery sampleDelivery = new Delivery();
//                sampleDelivery.setIdOrder(orderId);
//                sampleDelivery.setIdAddress(addressId);
//                sampleDelivery.setFullName("Test Recipient");
//                sampleDelivery.setNumberPhone("0987654321");
//                sampleDelivery.setArea(10.5);
//                sampleDelivery.setDeliveryFee(5.0);
//                sampleDelivery.setNote("Deliver to front door");
//                sampleDelivery.setStatus("Processing");
//                sampleDelivery.setScheduledDateTime(now.plusDays(1)); // Scheduled for tomorrow
//                int deliveryId = deliveryDao.insertDeliveryReturnId(sampleDelivery);
//                System.out.println("Inserted Delivery with ID: " + deliveryId);
//
//                // Create Order, UserKeys, and Delivery objects with generated IDs for OrderSignatures
//                Order orderForSignature = new Order();
//                orderForSignature.setId(orderId);
//
//                UserKeys userKeysForSignature = new UserKeys();
//                userKeysForSignature.setId(userKeyId);
//
//                Delivery deliveryForSignature = new Delivery();
//                deliveryForSignature.setId(deliveryId);
//
//
//                // Tạo đối tượng OrderSignatures mẫu
//                OrderSignatures orderSignatures = new OrderSignatures();
//                orderSignatures.setOrder(orderForSignature);
//                orderSignatures.setUserKeys(userKeysForSignature);
//                orderSignatures.setDelivery(deliveryForSignature);
//                orderSignatures.setDigitalSignature("dummy_signature_for_testing");
//                orderSignatures.setVerified("verified"); // Using the user's updated value
//                orderSignatures.setCreate_at(now);
//
//                OrderSignatureDAO orderSignatureDAO = new OrderSignatureDAO();
//
//                // Gọi phương thức insertOrderSignature và in kết quả
//                boolean success = orderSignatureDAO.insertOrderSignature(orderSignatures);
//                System.out.println("Insert OrderSignature successful: " + success);
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }); // This closes the handle after the block finishes or an exception occurs.
//    }


}
