package dao;

import connection.DBConnection;
import models.*;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

public class UserKeyDAO {
    Jdbi jdbi;

    public UserKeyDAO() {
        this.jdbi = DBConnection.getConnetion();
    }

//    public int insertUserKey(UserKeys userKeys) {
//        String sql = "INSERT INTO user_keys (user_id, public_key, created_at) VALUES (?, ?, ?)";
//        return jdbi.withHandle(handle -> handle.createUpdate(sql)
//                .bind(0, userKeys.getUser().getId())
//                .bind(1, userKeys.getPublicKey())
//                .bind(2, userKeys.getCreate_at())
//                .executeAndReturnGeneratedKeys("id")
//                .mapTo(Integer.class)
//                .findOnly());
//    }

    public boolean userKeyExist(int userId) {
        String sql = "SELECT COUNT(*) FROM users WHERE id = :userId AND idUserKey IS NOT NULL";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .findOnly() > 0);
    }

    public UserKeys getUserKey(int keyId) {
        String sql = "SELECT * FROM user_keys WHERE id = :keyId";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("keyId", keyId)
//                        .mapToBean(UserKeys.class)
                        .map((rs, ctx) -> {
                            UserKeys userKeys = new UserKeys();
                            userKeys.setId(rs.getInt("id"));
                            userKeys.setPublicKey(rs.getString("public_key"));

                            Timestamp ts = rs.getTimestamp("created_at");
                            userKeys.setCreate_at(ts != null ? ts.toLocalDateTime() : null);
                            return userKeys;
                        })
                        .findOne()
                        .orElse(null));
    }

    public boolean insertUserKey(int userId, String publicKey) {
        String sql = "INSERT INTO user_keys (public_key, created_at) VALUES (:pubKey, NOW())";
        String sql_updateUsers = "UPDATE users SET idUserKey = :idUserKey WHERE id = :id";
        return jdbi.withHandle(handle -> {
            Integer keyId = handle.createUpdate(sql)
                    .bind("pubKey", publicKey)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .findOnly();

            if (keyId == null) {
                return false;
            }


            int rowAffected = handle.createUpdate(sql_updateUsers)
                    .bind("idUserKey", keyId)
                    .bind("id", userId)
                    .execute();

            return rowAffected > 0;
        });
    }

    public boolean updateUserKey(int keyId, String publicKey) {
        String sql = """
                UPDATE user_keys SET public_key = :pubKey, created_at = NOW()
                WHERE id = :id""";
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", keyId)
                        .bind("publicKey", publicKey)
                        .execute() > 0
        );
    }

//    public List<Order> getOrdersByUserId(int userId) {
//        String query = "SELECT * FROM orders WHERE idUser = :idUser ORDER BY timeOrder DESC";
//
//        return jdbi.withHandle(handle -> handle.createQuery(query)
//                .bind("idUser", userId)
//                .map((rs, ctx) -> {
//                    // Handle user
//                    User user = new User();
//                    user.setId(rs.getInt("idUser"));
//
//                    // Handle voucher
//                    Voucher voucher = new Voucher();
//                    Integer idVoucher = (Integer) rs.getObject("idVoucher");
//                    if (idVoucher != null) {
//                        voucher.setIdVoucher(idVoucher);
//                    } else {
//                        voucher.setIdVoucher(null);
//                    }
//
//                    // Handle order
//                    Order order = new Order();
//                    order.setId(rs.getInt("id"));
//                    order.setTimeOrdered(rs.getObject("timeOrder", LocalDateTime.class));
//                    order.setUser(user);
//                    order.setVoucher(voucher);
//                    order.setStatus(rs.getString("statusOrder"));
//                    order.setTotalPrice(rs.getDouble("totalPrice"));
//                    order.setLastPrice(rs.getDouble("lastPrice"));
//
//                    return order;
//                }).list());
//    }

//    public UserKeys getCurrentUserKey(int userId) {
//        String sql = """
//                SELECT * FROM user_keys WHERE user_id = :idUser
//                ORDER BY id DESC
//                LIMIT 1;
//                """;
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql)
//                .bind("idUser", userId)
//                .map((rs, ctx) -> {
//                    UserKeys userKey = new UserKeys();
//                    userKey.setId(rs.getInt("id"));
//
//                    User user = new User();
//                    user.setId(rs.getInt("user_id"));
//                    userKey.setUser(user);
//
//                    userKey.setPublicKey(rs.getString("public_key"));
//                    userKey.setCreate_at(rs.getObject("created_at", LocalDateTime.class));
//                    return userKey;
//                })
//                .findFirst() // Use findFirst() since we limit to 1 result
//                .orElse(null)); // Return null if no record is found
//    }

//    public static void main(String[] args) {
//        UserKeyDAO userKeysDAO = new UserKeyDAO();
//        UserKeys retrievedUserKey = userKeysDAO.getCurrentUserKey(11);
//
//        if (retrievedUserKey != null) {
//            System.out.println("Retrieved UserKey:");
//            System.out.println("  ID: " + retrievedUserKey.getId());
//            System.out.println("  User ID: " + retrievedUserKey.getUser().getId());
//            System.out.println("  Public Key: " + retrievedUserKey.getPublicKey());
//            System.out.println("  Created At: " + retrievedUserKey.getCreate_at());
//        } else {
//            System.out.println("Could not retrieve UserKey");
//        }
//    }

//    public static void main(String[] args) {
//        // Instantiate necessary DAOs
//        AddressDao addressDao = new AddressDao();
//        UserDao userDao = new UserDao();
//        UserKeyDAO userKeyDao = new UserKeyDAO();
//
//        try {
//            // Insert sample Address
//            Address sampleAddress = new Address();
//            sampleAddress.setCity("Test City for UserKey");
//            sampleAddress.setProvince("Test Province for UserKey");
//            sampleAddress.setCommune("Test Commune for UserKey");
//            sampleAddress.setStreet("Test Street for UserKey");
//            int addressId = addressDao.insertAddressReturnId(sampleAddress);
//            System.out.println("Inserted Address with ID: " + addressId);
//
//            // Insert sample User
//            // The insertUser method in UserDao seems to require parameters directly, not a User object.
//            // Let's use the parameters.
//            int userId = userDao.insertUser("userkeytest@example.com", "User Key Test", "0987123456", addressId, "sample_userkey_image.png");
//            System.out.println("Inserted User with ID: " + userId);
//
//            // Create User object with generated ID for UserKeys
//            User userForKeys = new User();
//            userForKeys.setId(userId);
//
//            // Create sample UserKeys object
//            UserKeys userKeysToInsert = new UserKeys();
//            userKeysToInsert.setUser(userForKeys);
//            userKeysToInsert.setPublicKey("sample_public_key_for_testing");
//            userKeysToInsert.setCreate_at(LocalDateTime.now());
//
//            // Insert UserKeys and get the generated ID
//            int userKeyId = userKeyDao.insertUserKey(userKeysToInsert);
//            System.out.println("Inserted UserKey with ID: " + userKeyId);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }


}
