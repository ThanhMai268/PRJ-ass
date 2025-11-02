/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author dungdzpro
 */
public class Customer {
    private int CustomerID;
    private String CustomerName;
    private String PhoneNumber;
    private int AccountID;
    private String Address;

    public Customer(int CustomerID, String CustomerName, String PhoneNumber, int AccountID, String Address) {
        this.CustomerID = CustomerID;
        this.CustomerName = CustomerName;
        this.PhoneNumber = PhoneNumber;
        this.AccountID = AccountID;
        this.Address = Address;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String CustomerName) {
        this.CustomerName = CustomerName;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    
}
