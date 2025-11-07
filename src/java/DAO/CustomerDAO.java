/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Customer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

// THAY ĐỔI: Kế thừa từ DBConnect của bạn
public class CustomerDAO extends DBConnect {

    public Map<Integer, Customer> getAllCustomersAsMap() {
        Map<Integer, Customer> customerMap = new HashMap<>();
        String sql = "SELECT CustomerID, CustomerName, PhoneNumber, AccountID, Address " +
                     "FROM Customer";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhoneNumber(rs.getString("PhoneNumber"));
                c.setAccountID(rs.getInt("AccountID"));
                c.setAddress(rs.getString("Address"));
                
                customerMap.put(c.getCustomerID(), c);
            }
        } catch (SQLException e) {
            setErrorCode(-1); 
            System.err.println("Error getting customer map: " + e.getMessage());
        }
        return customerMap;
    }
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT CustomerID, CustomerName, PhoneNumber, AccountID, Address " +
                     "FROM Customer WHERE CustomerID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setCustomerID(rs.getInt("CustomerID"));
                    c.setCustomerName(rs.getString("CustomerName"));
                    c.setPhoneNumber(rs.getString("PhoneNumber"));
                    c.setAccountID(rs.getInt("AccountID"));
                    c.setAddress(rs.getString("Address"));
                    return c;
                }
            }
        } catch (SQLException e) {
            setErrorCode(-1);
            System.err.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }
}