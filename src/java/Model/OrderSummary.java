/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;
import java.sql.Timestamp;

/**
 *
 * @author dungdzpro
 */
public class OrderSummary {
    private int orderId;
    private Timestamp orderDate;
    private int status;          // 0: Pending, 1: Processing, 2: Completed (tuỳ bạn)
    private double total;        // tổng tiền của đơn
    private String customerName; // billing
    private String phone;
    private String address;

    public OrderSummary() {
    }

    public OrderSummary(int orderId, Timestamp orderDate, int status, double total, String customerName, String phone, String address) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.total = total;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
}
