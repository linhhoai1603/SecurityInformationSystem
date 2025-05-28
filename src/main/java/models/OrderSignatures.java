package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class OrderSignatures implements Serializable {
    private int id;
    private Order order;
    private UserKeys userKeys;
    private Delivery delivery;
    private String digitalSignature;
    private boolean verified;
    private LocalDateTime create_at;

    public OrderSignatures(int id, Order order, UserKeys userKeys, Delivery delivery, String digitalSignature, boolean verified, LocalDateTime create_at) {
        this.id = id;
        this.order = order;
        this.userKeys = userKeys;
        this.delivery = delivery;
        this.digitalSignature = digitalSignature;
        this.verified = verified;
        this.create_at = create_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public UserKeys getUserKeys() {
        return userKeys;
    }

    public void setUserKeys(UserKeys userKeys) {
        this.userKeys = userKeys;
    }

    public Delivery getDelivery() {
        return delivery;
    }

    public void setDelivery(Delivery delivery) {
        this.delivery = delivery;
    }

    public String getDigitalSignature() {
        return digitalSignature;
    }

    public void setDigitalSignature(String digitalSignature) {
        this.digitalSignature = digitalSignature;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public LocalDateTime getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }
}
