package services;


import dao.PaymentDao;
import models.Payment;

public class PaymentService {

    PaymentDao dao = new PaymentDao();
    public PaymentService() {
        dao = new PaymentDao();
    }

    public boolean insertPayment(Payment payment) {
        return dao.insertPayment(payment);
    }

}
