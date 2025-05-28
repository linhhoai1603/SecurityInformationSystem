package services;

import dao.OrderSignatureDAO;
import models.Delivery;
import models.OrderSignatures;

public class OrderSignatureService {
    OrderSignatureDAO dao;
    public OrderSignatureService() {
        dao = new OrderSignatureDAO();
    }

//    public int insertDeliveryReturnId(Delivery delivery) {
//        return dao.insertDeliveryReturnId(delivery);
//    }
//    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
//        return dao.insertOrderSignature(orderSignatures);
//    }
}
