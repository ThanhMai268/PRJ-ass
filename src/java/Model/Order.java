/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.security.Timestamp;

/**
 *
 * @author dungdzpro
 */
public class Order {
    private int orderID;
    private int CustomerID;
    private Timestamp OrderDate; // hoặc LocalDateTime 
    private int Status;

    public Order(int orderID, int CustomerID, Timestamp OrderDate, int Status) {
        this.orderID = orderID;
        this.CustomerID = CustomerID;
        this.OrderDate = OrderDate;
        this.Status = Status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public Timestamp getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Timestamp OrderDate) {
        this.OrderDate = OrderDate;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    

}  