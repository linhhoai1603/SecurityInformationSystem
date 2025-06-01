package models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Payment implements Serializable {
   private int id;
   private Order order;
   private String method;
   private String status;
   private LocalDateTime timePayment;
   private double price;
   public Payment(){

   }

    public Payment(Order order, String method, String status) {
        this.order = order;
        this.method = method;
        this.status = status;
    }

   public Payment(Order order, String method, String status, LocalDateTime timePayment) {
       this.order = order;
       this.method = method;
       this.status = status;
       this.timePayment = timePayment;
       this.price = order.calculateLastPrice();
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

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getTimePayment() {
        return timePayment;
    }

    public void setTimePayment(LocalDateTime timePayment) {
        this.timePayment = timePayment;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Payment(int id, Order order, String method, String status, LocalDateTime timePayment, double price) {
        this.id = id;
        this.order = order;
        this.method = method;
        this.status = status;
        this.timePayment = timePayment;
        this.price = price;
    }
}
