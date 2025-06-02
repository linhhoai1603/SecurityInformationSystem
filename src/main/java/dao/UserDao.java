package dao;

import connection.DBConnection;
import models.*;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;


public class UserDao {

    private Jdbi jdbi;
    Handle handle;
    public UserDao(Jdbi jdbi) {
        this.jdbi = jdbi;
    }
    public UserDao(){
        this.jdbi = DBConnection.getJdbi();
    }

    public User findUserById(int id) {

        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean updateInfo(int id ,String email, String name, String phone) {
        String sql = """
                UPDATE users SET email = :email, fullName = :name, phoneNumber = :phone
                WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id", id)
                        .bind("name", name)
                        .bind("email", email)
                        .bind("phone", phone)
                        .execute() > 0
        );
    }
    public boolean updateAvatar(int id , String url) {
        String sql = """
                UPDATE users SET image = :image 
                WHERE id = :id
                """;
        return jdbi.withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("id",id)
                        .bind("image",url)
                        .execute() > 0
        );
    }
    public void beginTransaction() {
        handle = jdbi.open();
        handle.begin();
    }


    public void commitTransaction() {
        if (handle != null) {
            handle.commit();
        }
    }

    public void rollbackTransaction() {
        if (handle != null) {
            handle.rollback();
        }
    }

    public void closeTransaction() {
        if (handle != null) {
            handle.close();
            handle = null;
        }
    }

    public boolean emailExists(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT COUNT(*) FROM account_users au "
                                        + "JOIN users u ON au.idUser = u.id " // Sửa: idUser = u.id
                                        + "WHERE u.email = :email"
                        )
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public int insertUser(String email, String fullName, String phoneNumber, int idAddress, String image) {
        return jdbi.withHandle(handle ->
                handle.createUpdate(
                                "INSERT INTO users (email, fullName, phoneNumber, idAddress, image) " +
                                        "VALUES (:email, :fullName, :phoneNumber, :idAddress, :image)"
                        )
                        .bind("email", email)       // Dùng email
                        .bind("fullName", fullName)
                        .bind("phoneNumber", phoneNumber)
                        .bind("idAddress", idAddress)
                        .bind("image", image)
                        .executeAndReturnGeneratedKeys("id") // Lấy id auto-increment
                        .mapTo(Integer.class)
                        .one()
        );
    }




    public void insertAccountUser(int idUser, String username, String password,
                                  int role, int locked, int code) {
        jdbi.useHandle(handle ->
                handle.createUpdate(
                                "INSERT INTO account_users (idUser, username, password, role, locked, code) " +
                                        "VALUES (:idUser, :username, :password, :role, :locked, :code)"
                        )
                        .bind("idUser", idUser)
                        .bind("username", username)
                        .bind("password", password)
                        .bind("role", role)
                        .bind("locked", locked)
                        .bind("code", code)
                        .execute()
        );
    }



    public boolean usernameExists(String username) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT COUNT(*) FROM account_users " +
                                        "WHERE username = :username"
                        )
                        .bind("username", username)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }
    public boolean checkHaveEmail(String username, String email) {
        Integer idUser = getIdUserByUsername(username); // Lấy idUser dựa trên username
        if (idUser == null) {
            return false; // Trả về false nếu username không tồn tại
        }
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT COUNT(*) FROM users " +
                                        "WHERE id = :idUser AND email = :email"
                        )
                        .bind("idUser", idUser)
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public Integer getIdUserByUsername(String username) {
        return jdbi.withHandle(handle ->
                handle.createQuery(
                                "SELECT idUser FROM account_users " +
                                        "WHERE username = :username"
                        )
                        .bind("username", username)
                        .mapTo(Integer.class)
                        .findOnly()
        );
    }
    public List<AccountUser> getAllUser() {
        String query = "SELECT u.id AS userId, u.email, u.fullName, u.phoneNumber, " +
                "a.id AS addressId, a.province, a.city, a.commune, a.street, " +
                "COUNT(o.id) AS orderCount, SUM(o.lastPrice) AS totalSpent, acc.locked " +
                "FROM users u " +
                "JOIN addresses a ON u.idAddress = a.id " +
                "JOIN account_users acc ON u.id = acc.idUser " +
                "LEFT JOIN orders o ON u.id = o.idUser " +
                "GROUP BY u.id, a.id";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .map((rs, ctx) -> {
                            // Tạo đối tượng User
                            User user = new User();
                            user.setId(rs.getInt("userId"));
                            user.setEmail(rs.getString("email"));
                            user.setFullName(rs.getString("fullName"));
                            user.setNumberPhone(rs.getString("phoneNumber"));

                            // Tạo đối tượng Address
                            Address address = new Address();
                            address.setId(rs.getInt("addressId"));
                            address.setProvince(rs.getString("province"));
                            address.setCity(rs.getString("city"));
                            address.setCommune(rs.getString("commune"));
                            address.setStreet(rs.getString("street"));

                            // Gán Address vào User
                            user.setAddress(address);

                            // Tạo đối tượng AccountUser
                            AccountUser accountUser = new AccountUser();
                            accountUser.setLocked(rs.getInt("locked"));
                            accountUser.setUser(user);

                            // Gán số lượng đơn hàng và tổng tiền đã chi vào User
                            user.setOrderCount(rs.getInt("orderCount"));
                            user.setTotalSpent(rs.getDouble("totalSpent"));

                            return accountUser;
                        })
                        .list()
        );
    }
    public boolean lockUser(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE account_users SET locked = 1 WHERE idUser = :id")
                        .bind("id", id)
                        .execute() > 0
        );
    }
    public boolean unlockUser(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE account_users SET locked = 0 WHERE idUser = :id")
                        .bind("id", id)
                        .execute() > 0
        );
    }
    public List<AccountUser> findUserByName(String name) {
        String query = "SELECT u.id AS userId, u.email, u.fullName, u.phoneNumber, " +
                "a.id AS addressId, a.province, a.city, a.commune, a.street, " +
                "COUNT(o.id) AS orderCount, SUM(o.lastPrice) AS totalSpent, acc.locked " +
                "FROM users u " +
                "JOIN addresses a ON u.idAddress = a.id " +
                "JOIN account_users acc ON u.id = acc.idUser " +
                "LEFT JOIN orders o ON u.id = o.idUser " +
                "WHERE u.fullName LIKE :name " +
                "GROUP BY u.id, a.id";

        return jdbi.withHandle(handle ->
                handle.createQuery(query)
                        .bind("name", "%" + name + "%")
                        .map((rs, ctx) -> {
                            // Tạo đối tượng User
                            User user = new User();
                            user.setId(rs.getInt("userId"));
                            user.setEmail(rs.getString("email"));
                            user.setFullName(rs.getString("fullName"));
                            user.setNumberPhone(rs.getString("phoneNumber"));

                            // Tạo đối tượng Address
                            Address address = new Address();
                            address.setId(rs.getInt("addressId"));
                            address.setProvince(rs.getString("province"));
                            address.setCity(rs.getString("city"));
                            address.setCommune(rs.getString("commune"));
                            address.setStreet(rs.getString("street"));

                            // Gán Address vào User
                            user.setAddress(address);

                            // Tạo đối tượng AccountUser
                            AccountUser accountUser = new AccountUser();
                            accountUser.setLocked(rs.getInt("locked"));
                            accountUser.setUser(user);

                            // Gán số lượng đơn hàng và tổng tiền đã chi vào User
                            user.setOrderCount(rs.getInt("orderCount"));
                            user.setTotalSpent(rs.getDouble("totalSpent"));

                            return accountUser;
                        })
                        .list()
        );
    }

//    public Style getStyleByID(int idStyle){
//        String query = "SELECT s.id, s.name, s.image, s.quantity AS styleQuantity, p.id AS idProduct, p.name AS nameProduct, pr.lastPrice, p.idPrice, c.id AS idCategory, p.quantity " +
//                "FROM styles s " +
//                "JOIN products p ON s.idProduct = p.id " +
//                "JOIN prices pr ON p.idPrice = pr.id " +
//                "JOIN categories c ON p.idCategory = c.id " +
//                "WHERE s.id = :idStyle";
//        return jdbi.withHandle(handle -> {
//            return handle.createQuery(query)
//                    .bind("idStyle", idStyle)
//                    .map((rs, ctx) ->{
//                        Style style = new Style();
//                        style.setId(rs.getInt("id"));
//                        style.setName(rs.getString("name"));
//                        style.setImage(rs.getString("image"));
//                        style.setQuantity(rs.getInt("styleQuantity"));
//                        Product product = new Product();
//                        product.setId(rs.getInt("idProduct"));
//                        product.setName(rs.getString("nameProduct"));
//                        product.setQuantity(rs.getInt("quantity"));
//                        Price price = new Price();
//                        price.setId(rs.getInt("idPrice"));
//                        price.setLastPrice(rs.getDouble("lastPrice"));
//                        Category category = new Category();
//                        category.setId(rs.getInt("idCategory"));
//                        product.setCategory(category);
//                        product.setPrice(price);
//                        style.setProduct(product);
//                        return style;
//                    }).list().getFirst();
//        });
//    }

    public User getUserById(int idUser) {
        String sql = "SELECT * FROM users WHERE id = :idUser";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("idUser", idUser)
                    .map((rs, ctx) ->{
                        User user = new User();

                        user.setId(rs.getInt("id"));
                        user.setEmail(rs.getString("email"));
                        user.setFullName(rs.getString("fullName"));
                        user.setNumberPhone(rs.getString("phoneNumber"));
                        Address address = new Address();
                        address.setId(rs.getInt("idAddress"));
                        user.setAddress(address);
                        user.setImage(rs.getString("image"));

                        return user;
                    }).findOne().orElse(null);
        });
    }
}


