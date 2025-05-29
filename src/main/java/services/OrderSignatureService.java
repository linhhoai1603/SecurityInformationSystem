package services;

import dao.OrderSignatureDAO;
import models.OrderSignatures;

public class OrderSignatureService {
    OrderSignatureDAO dao;
    public OrderSignatureService() {
        dao = new OrderSignatureDAO();
    }

    public boolean insertOrderSignature(OrderSignatures orderSignatures) {
        return dao.insertOrderSignature(orderSignatures);
    }
}
