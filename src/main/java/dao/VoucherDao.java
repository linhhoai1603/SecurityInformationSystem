package dao;

import connection.DBConnection;
import models.Voucher;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class VoucherDao {
    private Jdbi jdbi;
    public VoucherDao() {
        jdbi = DBConnection.getConnetion();
    }
    public List<Voucher> getAllVouchers() {
        String query = "SELECT * FROM vouchers;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .mapToBean(Voucher.class)
                    .list();
        });
    }
    public List<Voucher> getVoucherByValid(int valid) {
        String query = "SELECT * FROM vouchers WHERE valid = :valid;";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .bind("valid", valid)
                            .map((rs, ctx) -> {
                                Voucher voucher = new Voucher();
                                voucher.setIdVoucher(rs.getInt("idVoucher"));
                                voucher.setCode(rs.getString("code"));
                                voucher.setDiscountAmount(rs.getDouble("discountAmount"));
                                voucher.setConditionAmount(rs.getDouble("condition_amount"));
                                voucher.setValid(rs.getInt("valid"));
                                return voucher;
                            }).list()
            );
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy danh sách voucher: " + e.getMessage());
            return null;
        }
    }

    public Voucher getVoucherByCode(String code){
        String query = "SELECT * FROM vouchers WHERE code = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, code)
                    .mapToBean(Voucher.class).findOne().orElse(null);
        });
    }


    public boolean updateVoucher(String id, double amount, double price) {
        String query = "UPDATE vouchers SET amount = :amount, condition_amount = :price WHERE idVoucher = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("amount", amount)
                            .bind("price", price)
                            .bind("id", id)
                            .execute()
            );
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean addVoucher(String code, int id, double amount, double condition) {

        String query = "INSERT INTO vouchers (idVoucher,code, amount, condition_amount, valid) " +
                "VALUES (:id,:code, :amount, :condition, 1)";
        try {
            int rowsInserted = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("id", id)
                            .bind("code", code)
                            .bind("amount", amount)
                            .bind("condition", condition)
                            .execute()
            );
            return rowsInserted > 0;
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm voucher: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteVoucher(int id) {
        String query = "UPDATE vouchers SET valid = 0 WHERE idVoucher = :id";
        try {
            int rowsUpdated = jdbi.withHandle(handle ->
                    handle.createUpdate(query)
                            .bind("id", id)
                            .execute()
            );
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa voucher: " + e.getMessage());
            return false; // Trả về false nếu có lỗi
        }
    }

    public Voucher getVoucherById(int idVoucher) {
        String query = "SELECT * FROM vouchers WHERE id = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idVoucher)
                    .mapToBean(Voucher.class)
                    .findOne()
                    .orElse(null);
        });
    }


    public Voucher getVoucherByOrderId(int orderId) {
        String sql = "SELECT v.* FROM vouchers v JOIN orders o ON v.idVoucher = o.idVoucher\n" +
                "WHERE o.id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, orderId)
                    .mapToBean(Voucher.class)
                    .findOne()
                    .orElse(null);
        });
    }

    public static void main(String[] args) {
        VoucherDao dao = new VoucherDao();
        System.out.println(dao.getVoucherByOrderId(59));
    }
}
