package dao;

import connection.DBConnection;
import models.Order;
import models.OrderDetail;
import models.Payment;
import models.UserKeys;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;

public class PaymentDao {

    Jdbi jdbi;
    public PaymentDao() {
        jdbi = DBConnection.getConnetion();
    }

    public boolean insertPayment(Payment payment) {
        String sql = "INSERT INTO payments (id, idOrder, method, `status`, time, price)\n" +
                "VALUES(?, ?, ?, ?, ?, ?)";
        return jdbi.withHandle(handle -> {
            return handle.createUpdate(sql)
                    .bind(0, payment.getId())
                    .bind(1, payment.getOrder().getId())
                    .bind(2, payment.getMethod())
                    .bind(3, payment.getStatus())
                    .bind(4, payment.getTimePayment())
                    .bind(5, payment.getPrice())
                    .execute() > 0;
        });
    }


    public Payment getPaymentByIdOrder(int orderId) {
        String sql = "SELECT * FROM payments WHERE idOrder =:orderId";
            return jdbi.withHandle(handle -> {
                return handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            Payment payment = new Payment();

                            payment.setId(rs.getInt("id"));
                            Order order = new Order();
                            order.setId(rs.getInt("idOrder"));
                            payment.setOrder(order);
                            payment.setMethod(rs.getString("method"));
                            payment.setStatus(rs.getString("status"));
                            payment.setTimePayment(rs.getObject("time", LocalDateTime.class));
                            payment.setPrice(rs.getDouble("price"));

                            return payment;
                        }).findOne().orElse(null);
            });
    }

    public static void main(String[] args) {
        PaymentDao paymentDao = new PaymentDao();
        Payment payment = paymentDao.getPaymentByIdOrder(63);
        System.out.println(payment.toString());
    }
}
