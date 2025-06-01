package dao;

import connection.DBConnection;
import models.Order;
import models.OrderDetail;
import models.Payment;
import models.UserKeys;
import org.jdbi.v3.core.Jdbi;

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

}
