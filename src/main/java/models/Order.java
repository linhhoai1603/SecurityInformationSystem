package models;

import com.google.gson.annotations.Expose;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Order implements Serializable {
    @Expose // Thêm annotation này
    private int id;
    // @Expose // Thêm annotation này nếu muốn serialize User object bên trong Order
    private User user;
    @Expose // Thêm annotation này
    private LocalDateTime timeOrdered;
    // @Expose // Thêm annotation này nếu muốn serialize Voucher object bên trong Order
    private Voucher voucher;
    @Expose // Thêm annotation này
    private String status;
    @Expose // Thêm annotation này
    private double totalPrice;
    @Expose // Thêm annotation này
    private double lastPrice;
    // @Expose // Thêm annotation này nếu muốn serialize danh sách OrderDetail bên trong Order
    private List<OrderDetail> listOfDetailOrder = new ArrayList<OrderDetail>();
    public Order() {

    }
    public Order(int id, User user, List<OrderDetail> listOfDetailOrder, String status ) {
        this.id = id;
        this.user = user;
        this.timeOrdered = LocalDateTime.now();
        this.status = status;
        this.listOfDetailOrder = listOfDetailOrder;
        this.totalPrice = calculTotalPrice();
    }

    public double getLastPrice() {
        return lastPrice;
    }

    public void setLastPrice(double lastPrice) {
        this.lastPrice = lastPrice;
    }

    private double calculTotalPrice() {
        return 0.0;
    }

    public double calculateLastPrice() {
        return 0.0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getTimeOrdered() {
        return timeOrdered;
    }

    public void setTimeOrdered(LocalDateTime timeOrdered) {
        this.timeOrdered = timeOrdered;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<OrderDetail> getListOfDetailOrder() {
        return listOfDetailOrder;
    }

    public void setListOfDetailOrder(List<OrderDetail> listOfDetailOrder) {
        this.listOfDetailOrder = listOfDetailOrder;
    }
    public Order(User user, Voucher voucher, String status, double totalPrice, double lastPrice) {
        this.user = user;
        this.timeOrdered = LocalDateTime.now();
        this.voucher = voucher;
        this.status = status;
        this.totalPrice = totalPrice;
        this.lastPrice = lastPrice;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", user=" + user.getId() +
                ", timeOrdered=" + timeOrdered +
                ", voucher=" + voucher +
                ", status='" + status + '\'' +
                ", totalPrice=" + totalPrice +
                ", lastPrice=" + lastPrice +
                ", listOfDetailOrder=" + listOfDetailOrder +
                '}';
    }
}
