/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class OrderNotification {
    private int orderId;
    private String customerName;
    private double totalValue;

    public OrderNotification(int orderId, String customerName, double totalValue) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalValue = totalValue;
    }

    // Bổ sung Getters (cần thiết cho JSTL)
    public int getOrderId() {
        return orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public double getTotalValue() {
        return totalValue;
    }
}
