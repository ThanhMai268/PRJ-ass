/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dungdzpro
 */
public class OrderDetail {
    private int OrderDetailID;
    private int OrderID;
    private int ProductDetailID;
    private int Quantity;
    private double Price;

    public OrderDetail(int OrderDetailID, int OrderID, int ProductDetailID, int Quantity, double Price) {
        this.OrderDetailID = OrderDetailID;
        this.OrderID = OrderID;
        this.ProductDetailID = ProductDetailID;
        this.Quantity = Quantity;
        this.Price = Price;
    }

    public int getOrderDetailID() {
        return OrderDetailID;
    }

    public void setOrderDetailID(int OrderDetailID) {
        this.OrderDetailID = OrderDetailID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getProductDetailID() {
        return ProductDetailID;
    }

    public void setProductDetailID(int ProductDetailID) {
        this.ProductDetailID = ProductDetailID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }
    
}
