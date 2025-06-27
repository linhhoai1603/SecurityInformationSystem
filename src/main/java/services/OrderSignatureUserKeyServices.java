package services;

import models.Order;
import models.OrderSignatures;

import java.util.ArrayList;
import java.util.List;

public class OrderSignatureUserKeyServices {
    OrderService orderService;
    UserKeyService userKeyService;
    OrderSignatureService orderSignatureService;

    public OrderSignatureUserKeyServices() {
        orderService = new OrderService();
        userKeyService = new UserKeyService();
        orderSignatureService = new OrderSignatureService();
    }

    public OrderSignatureUserKeyServices(OrderService orderService, UserKeyService userKeyService, OrderSignatureService orderSignatureService) {
        this.orderService = orderService;
        this.userKeyService = userKeyService;
        this.orderSignatureService = orderSignatureService;
    }

    public List<OrderSignatures> getOrderSignaturesHasAndNotSigned() {
        List<OrderSignatures> orderSignatures = new ArrayList<OrderSignatures>();

        return orderSignatures;
    }

}
