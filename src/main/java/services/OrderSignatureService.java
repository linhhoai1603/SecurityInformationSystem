package services;

import dao.OrderSignatureDAO;
import models.OrderSignatures;

import java.util.List;

public class OrderSignatureService {
    OrderSignatureDAO dao;
    public OrderSignatureService() {
        dao = new OrderSignatureDAO();
    }

    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
        return dao.insertOrderSignature(orderSignatures);
    }

    public List<OrderSignatures> getSignaturesByIdOrder(int orderId) {
        return dao.getSignaturesByIdOrder(orderId);
    }
}
