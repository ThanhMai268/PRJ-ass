/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.BestSeller;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class OverviewDAO extends DBConnect {    
    private static final int STATUS_COMPLETED = 2;

    public OverviewDAO() {
        super();
    }

    private void openConnection() throws Exception {
        if (conn == null || conn.isClosed()) {
            conn = new DBConnect().getConnection();
        }
    }

    // Lấy Tổng Doanh thu
    public long getTotalRevenue() {
        String query = "SELECT SUM(OD.Quantity * OD.Price) AS TotalRevenue FROM [Order] O JOIN OrderDetail OD ON O.OrderID = OD.OrderID WHERE O.Status = ?";
        long revenue = 0;
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
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
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return revenue;
    }

    // Đếm Tổng Đơn hàng
    public int getTotalMonthlyOrders() {
        // SỬA LỖI 3: Tối ưu hiệu năng câu query
        String query = "SELECT COUNT(OrderID) AS TotalMonthlyOrders "
                     + "FROM [Order] "
                     + "WHERE OrderDate >= DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) "
                     + "AND OrderDate < DATEADD(month, DATEDIFF(month, 0, GETDATE()) + 1, 0)";
        int count = 0;
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            openConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("TotalMonthlyOrders");
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    // Đếm Số lượng Khách hàng Mua hàng Duy nhất
    public int getPurchasingCustomers() {
        String query = "SELECT COUNT(DISTINCT CustomerID) AS PurchasingCustomers FROM [Order]";
        int count = 0;
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
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
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    // Đếm Tổng Mặt hàng đã bán
    public int getTotalItemsSold() {
        String query = "SELECT SUM(OD.Quantity) AS TotalItemsSold FROM [Order] O "
                     + "INNER JOIN OrderDetail OD ON O.OrderID = OD.OrderID "
                     + "WHERE O.Status = ?";
        int count = 0;
        
        PreparedStatement ps = null;
        ResultSet rs = null;
        
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
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    // Sản phẩm bán chạy nhất
    public List<BestSeller> getBestSellers(int topN) {
        List<BestSeller> list = new ArrayList<>();
        String query = "SELECT TOP (?) P.ProductName, SUM(OD.Quantity) AS TotalSold, P.Image "
                     + "FROM OrderDetail OD "
                     + "INNER JOIN [Order] O ON OD.OrderID = O.OrderID "
                     + "INNER JOIN ProductDetail PD ON OD.ProductDetailID = PD.ProductDetailID "
                     + "INNER JOIN Product P ON PD.ProductID = P.ProductID "
                     + "WHERE O.Status = ? "
                     + "GROUP BY P.ProductName, P.Image "
                     + "ORDER BY TotalSold DESC";
        
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            openConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, topN);
            ps.setInt(2, STATUS_COMPLETED);
            rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("ProductName");
                int sold = rs.getInt("TotalSold");
                String imageUrl = rs.getString("Image"); // Lấy ảnh từ DB
                list.add(new BestSeller(name, sold, imageUrl));            
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        } finally {
            // SỬA LỖI 2: Đóng tất cả tài nguyên
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null && !conn.isClosed()) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}