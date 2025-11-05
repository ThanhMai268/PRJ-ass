/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;


public class OverviewDAO extends DBConnect { 

    PreparedStatement ps = null;
    ResultSet rs = null;
    private static final int STATUS_COMPLETED = 2; 

    public OverviewDAO() {
        super();
    }
    
    private void openConnection() throws Exception {
        conn = new DBConnect().getConnection();
    }

//  Lấy Tổng Doanh thu
    public long getTotalRevenue() {
        String query = "SELECT SUM(OD.Quantity * OD.Price) AS TotalRevenue FROM [Order] O JOIN OrderDetail OD ON O.OrderID = OD.OrderID WHERE O.Status = ?";
        long revenue = 0;
        try {
            openConnection(); 
            ps = conn.prepareStatement(query);
            ps.setInt(1, STATUS_COMPLETED);
            rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getLong("TotalRevenue"); 
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        } 
        return revenue;
    }

// Đếm Tổng Đơn hàng 
    public int getTotalOrders() {
        String query = "SELECT COUNT(OrderID) AS TotalOrders FROM [Order]";
        int count = 0;
        try {
            openConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("TotalOrders");
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        }
        return count;
    }
    
// Đếm Số lượng Khách hàng Mua hàng Duy nhất
    public int getPurchasingCustomers() {
        String query = "SELECT COUNT(DISTINCT CustomerID) AS PurchasingCustomers FROM [Order]";
        int count = 0;
        try {
            openConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("PurchasingCustomers");
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        }
        return count;
    }
    
// Đếm Tổng Mặt hàng đã bán
    public int getTotalItemsSold() {
        String query = "SELECT SUM(OD.Quantity) AS TotalItemsSold FROM [Order] O "
                   + "INNER JOIN OrderDetail OD ON O.OrderID = OD.OrderID "
                   + "WHERE O.Status = ?";
        int count = 0;
        try {
            openConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, STATUS_COMPLETED);
            rs = ps.executeQuery();
            if (rs.next()) {
                Object result = rs.getObject("TotalItemsSold");
                count = (result != null) ? ((Number) result).intValue() : 0;
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        }
        return count;
    }
    
// Sản phẩm bán chạy nhất
    public List<String> getBestSellers(int topN) {
        List<String> list = new ArrayList<>();
        String query = "SELECT TOP 3 P.ProductName, SUM(OD.Quantity) AS TotalSold " +
                     "FROM OrderDetail OD " +
                     "INNER JOIN [Order] O ON OD.OrderID = O.OrderID " +
                     "INNER JOIN ProductDetail PD ON OD.ProductDetailID = PD.ProductDetailID " +
                     "INNER JOIN Product P ON PD.ProductID = P.ProductID " +
                     "WHERE O.Status = ? " +
                     "GROUP BY P.ProductName " +
                     "ORDER BY TotalSold DESC";
        
        try {
            openConnection();
            ps = conn.prepareStatement(query);
            
            ps.setInt(1, topN);
            ps.setInt(2, STATUS_COMPLETED);
            
            rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("ProductName");
                int sold = rs.getInt("TotalSold");
                list.add(name + " (Bán: " + sold + ")"); 
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        }
        return list;
    }
}