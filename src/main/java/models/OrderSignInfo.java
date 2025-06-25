package models;

import java.io.Serializable;

public class OrderSignInfo implements Serializable {
    private Order order;
    private OrderSignatures orderSignatures;
    private UserKeys userKeys;

    public OrderSignInfo() {
    }

    public OrderSignInfo(Order order, OrderSignatures orderSignatures, UserKeys userKeys) {
        this.order = order;
        this.orderSignatures = orderSignatures;
        this.userKeys = userKeys;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public OrderSignatures getOrderSignatures() {
        return orderSignatures;
    }

    public void setOrderSignatures(OrderSignatures orderSignatures) {
        this.orderSignatures = orderSignatures;
    }

    public UserKeys getUserKeys() {
        return userKeys;
    }

    public void setUserKeys(UserKeys userKeys) {
        this.userKeys = userKeys;
    }
}
