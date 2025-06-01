package models;

import com.google.gson.annotations.Expose;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Delivery implements Serializable {
    @Expose
    private int id;
    @Expose
    private int idOrder;
    @Expose
    private int idAddress;
    @Expose
    private String fullName;
    @Expose
    private String phoneNumber;
    @Expose
    private double area;
    @Expose
    private double deliveryFee;
    @Expose
    private String note;
    @Expose
    private String status;
    @Expose
    private LocalDateTime scheduledDateTime;
    @Expose
    private User user;
    @Expose
    private Address address;

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public int getIdAddress() {
        return idAddress;
    }

    public void setIdAddress(int idAddress) {
        this.idAddress = idAddress;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setNumberPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getScheduledDateTime() {
        return scheduledDateTime;
    }

    public void setScheduledDateTime(LocalDateTime scheduledDateTime) {
        this.scheduledDateTime = scheduledDateTime;
    }

    public Delivery(int idOrder, int idAddress, String fullName, String phoneNumber, double area, double deliveryFee, String note, String status) {
        this.idOrder = idOrder;
        this.idAddress = idAddress;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.area = area;
        this.deliveryFee = deliveryFee;
        this.note = note;
        this.status = status;
        this.scheduledDateTime = LocalDateTime.now().plusDays(2); // Ngày hiện tại + 2 ngày
    }
    public Delivery() {

    }


    @Override
    public String toString() {
        return "Delivery{" +
                "id=" + id +
                ", idOrder=" + idOrder +
                ", idAddress=" + idAddress +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", area=" + area +
                ", deliveryFee=" + deliveryFee +
                ", note='" + note + '\'' +
                ", status='" + status + '\'' +
                ", scheduledDateTime=" + scheduledDateTime +
                '}';
    }
}
