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
import java.sql.Statement;
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
    public Integer findIdByAccountId(int accountId) throws SQLException {
        String sql = "SELECT CustomerID FROM [Customer] WHERE AccountID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : null;
            }
        }
    }

   
    public int insert(String name, String phone, int accountId, String address) throws SQLException {
        String sql = "INSERT INTO [Customer](CustomerName, PhoneNumber, AccountID, [Address]) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setInt(3, accountId);
            ps.setString(4, address);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        // fallback nếu không bật generated keys
        String q = "SELECT TOP 1 CustomerID FROM [Customer] WHERE AccountID=? ORDER BY CustomerID DESC";
        try (PreparedStatement ps = conn.prepareStatement(q)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Cannot fetch CustomerID after insert");
    }

    
    public void updateInfo(int customerId, String name, String phone, String address) throws SQLException {
        String sql = "UPDATE [Customer] SET CustomerName=?, PhoneNumber=?, [Address]=? WHERE CustomerID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setInt(4, customerId);
            ps.executeUpdate();
        }
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