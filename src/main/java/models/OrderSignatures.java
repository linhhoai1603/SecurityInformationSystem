package models;

import com.google.gson.annotations.Expose;

import java.io.Serializable;
import java.time.LocalDateTime;

public class OrderSignatures implements Serializable {
    @Expose // Thêm @Expose
    private int id;
    @Expose // Thêm @Expose để serialize đối tượng Order (với các trường @Expose bên trong nó)
    private Order order;
    @Expose // Thêm @Expose để serialize đối tượng UserKeys (với các trường @Expose bên trong nó)
    private UserKeys userKeys;
    @Expose // Thêm @Expose để serialize đối tượng Delivery (với các trường @Expose bên trong nó)
    private Delivery delivery;
    @Expose // Thêm @Expose
    private String digitalSignature;
    @Expose // Thêm @Expose
    private String verified;
    @Expose // Thêm @Expose (đã xử lý TypeAdapter cho LocalDateTime trong Servlet)
    private LocalDateTime create_at;;

    public OrderSignatures(Order order, UserKeys userKeys, Delivery delivery, String digitalSignature, String verified) {
        this.order = order;
        this.userKeys = userKeys;
        this.delivery = delivery;
        this.digitalSignature = digitalSignature;
        this.verified = verified;
        this.create_at = LocalDateTime.now();
    }

    public OrderSignatures() {

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

    public String getVerified() {
        return verified;
    }

    public void setVerified(String verified) {
        this.verified = verified;
    }

    public LocalDateTime getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "OrderSignatures{" +
                "id=" + id +
                ", order=" + order +
                ", userKeys=" + userKeys +
                ", delivery=" + delivery +
                ", digitalSignature='" + digitalSignature + '\'' +
                ", verified='" + verified + '\'' +
                ", create_at=" + create_at +
                '}';
    }
}
