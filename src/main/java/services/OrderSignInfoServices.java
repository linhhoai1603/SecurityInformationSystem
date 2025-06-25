package services;

import models.Order;
import models.OrderSignInfo;
import models.OrderSignatures;
import models.UserKeys;

import java.util.ArrayList;
import java.util.List;

public class OrderSignInfoServices {
    OrderService orderService;
    UserKeyService userKeyService;
    OrderSignatureService orderSignatureService;

    public OrderSignInfoServices() {
        orderService = new OrderService();
        userKeyService = new UserKeyService();
        orderSignatureService = new OrderSignatureService();
    }

    public OrderSignInfoServices(OrderService orderService, UserKeyService userKeyService, OrderSignatureService orderSignatureService) {
        this.orderService = orderService;
        this.userKeyService = userKeyService;
        this.orderSignatureService = orderSignatureService;
    }

    public List<OrderSignInfo> getOrderSignInfo() {
        List<OrderSignInfo> result = new ArrayList<OrderSignInfo>();

        List<Order> orders = orderService.getAllOrders();
        System.out.println("test 11");
        for (Order order : orders) {
            List<OrderSignatures> signaturesList = orderSignatureService.getSignaturesByIdOrder(order.getId());
            System.out.println("test 12");
            OrderSignatures signatures = null;
            if(signaturesList != null) {
                signatures = signaturesList.getLast();
            }
            System.out.println("test 13");
            UserKeys userKeys = null;
            if (signatures != null) {
                userKeys = signatures.getUserKeys();
            }
            System.out.println("test 14");
            result.add(new OrderSignInfo(order, signatures, userKeys));
        }
        System.out.println("test 15");
        return result;
    }
}
