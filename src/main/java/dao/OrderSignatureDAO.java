package dao;

import connection.DBConnection;
import models.*;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class OrderSignatureDAO {
    Jdbi jdbi;
    public OrderSignatureDAO(){
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

    public static void main(String[] args) {
        // Lấy thời gian hiện tại
        LocalDateTime now = LocalDateTime.now();

        // Định dạng thời gian nếu cần
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = now.format(formatter);

        // Get Jdbi instance
        Jdbi jdbi = DBConnection.getJdbi();

        jdbi.useHandle(handle -> {
            // Instantiate necessary DAOs with the shared handle if they support it,
            // or rely on DBConnection providing the static Jdbi instance they use internally.
            // Since DAOs currently use DBConnection.getConnetion()/getJdbi() internally,
            // they will use the same static Jdbi instance we got here.
            UserDao userDao = new UserDao();
            AddressDao addressDao = new AddressDao();
            OrderDAO orderDao = new OrderDAO();
            DeliveryDAO deliveryDao = new DeliveryDAO();
            UserKeyDAO userKeyDao = new UserKeyDAO();

            try {
                // Insert sample Address
                Address sampleAddress = new Address();
                sampleAddress.setCity("Sample City");
                sampleAddress.setProvince("Sample Province");
                sampleAddress.setCommune("Sample Commune");
                sampleAddress.setStreet("Sample Street");
                int addressId = addressDao.insertAddressReturnId(sampleAddress);
                System.out.println("Inserted Address with ID: " + addressId);

                // Insert sample User
                int userId = userDao.insertUser("testuser@example.com", "Test User", "1234567890", addressId, "sample_image_url");
                System.out.println("Inserted User with ID: " + userId);

                // Create User object with generated ID for UserKeys
                User userForKeys = new User();
                userForKeys.setId(userId);

                // Create sample UserKeys object
                UserKeys userKeysToInsert = new UserKeys();
                userKeysToInsert.setUser(userForKeys);
                userKeysToInsert.setPublicKey("sample_public_key"); // Using the sample public key
                userKeysToInsert.setCreate_at(now); // Using the LocalDateTime object

                // Insert sample UserKeys and get the generated ID
                int userKeyId = userKeyDao.insertUserKey(userKeysToInsert);
                System.out.println("Inserted UserKeys with ID: " + userKeyId);


                // Create User and Address objects with generated IDs for Order and Delivery
                User userForOrder = new User();
                userForOrder.setId(userId);

                Address addressForDelivery = new Address();
                addressForDelivery.setId(addressId);

                // Insert sample Order
                Order sampleOrder = new Order();
                sampleOrder.setTimeOrdered(now);
                sampleOrder.setUser(userForOrder);
                sampleOrder.setStatus("Pending");
                sampleOrder.setTotalPrice(100.0);
                sampleOrder.setLastPrice(90.0);
                // Assuming a voucher is optional, setting to null for this test
                sampleOrder.setVoucher(null);
                int orderId = orderDao.insertOrder(sampleOrder);
                System.out.println("Inserted Order with ID: " + orderId);

                // Create Order object with generated ID for Delivery
                Order orderForDelivery = new Order();
                orderForDelivery.setId(orderId);

                // Insert sample Delivery
                Delivery sampleDelivery = new Delivery();
                sampleDelivery.setIdOrder(orderId);
                sampleDelivery.setIdAddress(addressId);
                sampleDelivery.setFullName("Test Recipient");
                sampleDelivery.setNumberPhone("0987654321");
                sampleDelivery.setArea(10.5);
                sampleDelivery.setDeliveryFee(5.0);
                sampleDelivery.setNote("Deliver to front door");
                sampleDelivery.setStatus("Processing");
                sampleDelivery.setScheduledDateTime(now.plusDays(1)); // Scheduled for tomorrow
                int deliveryId = deliveryDao.insertDeliveryReturnId(sampleDelivery);
                System.out.println("Inserted Delivery with ID: " + deliveryId);

                // Create Order, UserKeys, and Delivery objects with generated IDs for OrderSignatures
                Order orderForSignature = new Order();
                orderForSignature.setId(orderId);

                UserKeys userKeysForSignature = new UserKeys();
                userKeysForSignature.setId(userKeyId);

                Delivery deliveryForSignature = new Delivery();
                deliveryForSignature.setId(deliveryId);


                // Tạo đối tượng OrderSignatures mẫu
                OrderSignatures orderSignatures = new OrderSignatures();
                orderSignatures.setOrder(orderForSignature);
                orderSignatures.setUserKeys(userKeysForSignature);
                orderSignatures.setDelivery(deliveryForSignature);
                orderSignatures.setDigitalSignature("dummy_signature_for_testing");
                orderSignatures.setVerified("verified"); // Using the user's updated value
                orderSignatures.setCreate_at(now);

                OrderSignatureDAO orderSignatureDAO = new OrderSignatureDAO();

                // Gọi phương thức insertOrderSignature và in kết quả
                boolean success = orderSignatureDAO.insertOrderSignature(orderSignatures);
                System.out.println("Insert OrderSignature successful: " + success);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }); // This closes the handle after the block finishes or an exception occurs.
    }
}
