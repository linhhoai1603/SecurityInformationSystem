package dao;

import connection.DBConnection;
import models.Delivery;
import models.OrderSignatures;
import org.jdbi.v3.core.Jdbi;

public class OrderSignatureDAO {
    Jdbi jdbi;
    public OrderSignatureDAO(){
        this.jdbi = DBConnection.getConnetion();
    }

//    public boolean insertDelivery(Delivery delivery){
//        String query = "insert into deliveries (idOrder, idAddress, fullName, phoneNumber, area, deliveryFee, note, status, scheduledDateTime) values (?,?,?,?,?,?,?,?,?)";
//        return jdbi.withHandle(handle -> {
//            return handle.createUpdate(query)
//                    .bind(0, delivery.getIdOrder())
//                    .bind(1, delivery.getIdAddress())
//                    .bind(2, delivery.getFullName())
//                    .bind(3, delivery.getPhoneNumber())
//                    .bind(4, delivery.getArea())
//                    .bind(5, delivery.getDeliveryFee())
//                    .bind(6, delivery.getNote())
//                    .bind(7, delivery.getStatus())
//                    .bind(8, delivery.getScheduledDateTime())
//                    .execute() > 0;
//        });
//    }

//    return jdbi.withHandle(handle -> handle.createUpdate(query)
//            .bind(0, order.getTimeOrdered())
//            .bind(1, order.getUser().getId())
//            .bind(2, order.getVoucher() != null ? order.getVoucher().getIdVoucher() : null) // Check for null voucher
//            .bind(3, order.getStatus())
//            .bind(4, order.getTotalPrice())
//            .bind(5, order.getLastPrice())
//            .executeAndReturnGeneratedKeys("id")
//                .mapTo(Integer.class)
//                .findOnly());

//    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
//        String query = "INSERT INTO `order_signatures` (`order_id`, `key_id`, `digital_signature`, `verified`, `create_at`) \n" +
//                "VALUES (?, ?, ?, ?, ?);";
//        return jdbi.withHandle(handle -> {
//            return handle.createUpdate(query)
//                    .bind(0, orderSignatures.getOrder().getId())
//                    .bind(1, orderSignatures.getUserKeys().getId())
//                    .bind(2, orderSignatures.getDigitalSignature())
//                    .bind(3, orderSignatures.getV)
//        })
//    }
}
