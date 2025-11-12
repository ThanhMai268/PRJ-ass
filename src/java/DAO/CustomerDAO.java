/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class CustomerDAO extends DBConnect {

    public Map<Integer, Customer> getAllCustomersAsMap() {
        Map<Integer, Customer> customerMap = new HashMap<>();
        String sql = "SELECT CustomerID, CustomerName, PhoneNumber, AccountID, Address FROM Customer";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhoneNumber(rs.getString("PhoneNumber"));
                c.setAccountID(rs.getInt("AccountID"));
                c.setAddress(rs.getString("Address"));
                customerMap.put(c.getCustomerID(), c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return customerMap;
    }

    public Integer findIdByAccountId(int accountId) {
        String sql = "SELECT CustomerID FROM Customer WHERE AccountID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }

    public int insert(String name, String phone, int accountId, String address) {
        String sql = "INSERT INTO Customer (CustomerName, PhoneNumber, AccountID, Address) VALUES (?,?,?,?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setInt(3, accountId);
            ps.setString(4, address);
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

            // Fallback nếu không bật generated keys
            close(null, ps, rs); rs = null; ps = null;
            String q = "SELECT TOP 1 CustomerID FROM Customer WHERE AccountID=? ORDER BY CustomerID DESC";
            ps = conn.prepareStatement(q);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }

        // Thất bại
        return -1;
    }

    public void updateInfo(int customerId, String name, String phone, String address) {
        String sql = "UPDATE Customer SET CustomerName=?, PhoneNumber=?, Address=? WHERE CustomerID=?";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setInt(4, customerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, null);
        }
    }

    public Customer getCustomerById(int customerId) {
        String sql = "SELECT CustomerID, CustomerName, PhoneNumber, AccountID, Address FROM Customer WHERE CustomerID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhoneNumber(rs.getString("PhoneNumber"));
                c.setAccountID(rs.getInt("AccountID"));
                c.setAddress(rs.getString("Address"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }
}
