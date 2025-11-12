/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.OrderDetailView;
import Model.OrderSummary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Statement;
import java.sql.Timestamp;

// THAY ĐỔI: Kế thừa từ DBConnect của bạn
public class OrderDAO extends DBConnect {

    /**
     * Lấy danh sách các đơn hàng, lọc theo trạng thái.
     */
    public List<Order> getOrdersByStatus(int status) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT OrderID, OrderDate, CustomerID, Status FROM [Order]";

        if (status != -1) { // -1 = All Statuses
            sql += " WHERE Status = ?";
        }
        sql += " ORDER BY OrderDate DESC"; 

        // THAY ĐỔI: Dùng biến 'conn'
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (status != -1) {
                ps.setInt(1, status);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setOrderDate(rs.getTimestamp("OrderDate"));
                    o.setCustomerID(rs.getInt("CustomerID"));
                    o.setStatus(rs.getInt("Status"));
                    orderList.add(o);
                }
            }
        } catch (SQLException e) {
            // THAY ĐỔI: Set mã lỗi
            setErrorCode(-1);
            System.err.println("Error getting orders by status: " + e.getMessage());
        }
        return orderList;
    }

    /**
     * Tính tổng tiền cho tất cả các đơn hàng.
     */
    public Map<Integer, Double> getOrderTotals() {
        Map<Integer, Double> orderTotals = new HashMap<>();
        String sql = "SELECT OrderID, SUM(Quantity * Price) AS Total " +
                     "FROM OrderDetail " +
                     "GROUP BY OrderID";

        // THAY ĐỔI: Dùng biến 'conn'
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                orderTotals.put(rs.getInt("OrderID"), rs.getDouble("Total"));
            }
        } catch (SQLException e) {
            // THAY ĐỔI: Set mã lỗi
            setErrorCode(-1);
            System.err.println("Error getting order totals: " + e.getMessage());
        }
        return orderTotals;
    }

    /**
     * Cập nhật trạng thái của một đơn hàng.
     */
    public boolean updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE [Order] SET Status = ? WHERE OrderID = ?";
        
        // THAY ĐỔI: Dùng biến 'conn'
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // THAY ĐỔI: Set mã lỗi
            setErrorCode(-1);
            System.err.println("Error updating order status: " + e.getMessage());
            return false;
        }
    }
    public Order getOrderById(int orderId) {
        String sql = "SELECT OrderID, OrderDate, CustomerID, Status FROM [Order] WHERE OrderID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order o = new Order();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setOrderDate(rs.getTimestamp("OrderDate"));
                    o.setCustomerID(rs.getInt("CustomerID"));
                    o.setStatus(rs.getInt("Status"));
                    return o;
                }
            }
        } catch (SQLException e) {
            setErrorCode(-1);
            System.err.println("Error getting order by ID: " + e.getMessage());
        }
        return null;
    }

    public List<OrderDetailView> getOrderDetails(int orderId) {
        List<OrderDetailView> items = new ArrayList<>();
        String sql = "SELECT p.ProductName, p.Image, c.ColorName, s.SizeValue, od.Quantity, od.Price " +
                     "FROM OrderDetail od " +
                     "JOIN ProductDetail pd ON od.ProductDetailID = pd.ProductDetailID " +
                     "JOIN Product p ON pd.ProductID = p.ProductID " +
                     "JOIN Color c ON pd.ColorID = c.ColorID " +
                     "JOIN Size s ON pd.SizeID = s.SizeID " +
                     "WHERE od.OrderID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailView item = new OrderDetailView();
                    item.setProductName(rs.getString("ProductName"));
                    item.setImage(rs.getString("Image"));
                    item.setColorName(rs.getString("ColorName"));
                    item.setSizeValue(rs.getInt("SizeValue"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setPrice(rs.getDouble("Price"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            setErrorCode(-1);
            System.err.println("Error getting order details view: " + e.getMessage());
        }
        return items;
    }
    public int insert(LocalDateTime orderDate, int customerId, int status) throws SQLException {
        String sql = "INSERT INTO [Order](OrderDate, CustomerID, Status) VALUES (?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setTimestamp(1, Timestamp.valueOf(orderDate));
            ps.setInt(2, customerId);
            ps.setInt(3, status);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        // fallback
        String q = "SELECT TOP 1 OrderID FROM [Order] WHERE CustomerID=? ORDER BY OrderID DESC";
        try (PreparedStatement ps = conn.prepareStatement(q)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Cannot fetch OrderID after insert");
    }
     /** Danh sách đơn theo AccountID (để đổ ra /Orders) */
    public List<OrderSummary> findSummariesByAccount(int accountId) throws SQLException {
        String sql =
            "SELECT o.OrderID, o.OrderDate, o.Status,\n" +
            "       COALESCE(SUM(od.Quantity * od.Price), 0) AS total\n" +
            "FROM [Order] o\n" +
            "JOIN Customer c ON c.CustomerID = o.CustomerID\n" +
            "LEFT JOIN OrderDetail od ON od.OrderID = o.OrderID\n" +
            "WHERE c.AccountID = ?\n" +
            "GROUP BY o.OrderID, o.OrderDate, o.Status\n" +
            "ORDER BY o.OrderID DESC";
        Connection conn = null;
        
        ResultSet rs = null;
        List<OrderSummary> list = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            
                while (rs.next()) {
                    OrderSummary o = new OrderSummary();
                    o.setOrderId(rs.getInt("OrderID"));
                    o.setOrderDate(rs.getTimestamp("OrderDate"));
                    o.setStatus(rs.getInt("Status"));
                    o.setTotal(rs.getDouble("total"));
                    list.add(o);
                }
            }catch(Exception e){
            setErrorCode(-1);
        }
        return list;
    }

    /** Tóm tắt 1 đơn + kiểm tra sở hữu theo AccountID (chống xem chéo) */
    public OrderSummary findSummaryByIdForAccount(int orderId, int accountId) throws SQLException {
        String sql =
            "SELECT TOP 1 o.OrderID, o.OrderDate, o.Status,\n" +
            "       c.CustomerName, c.PhoneNumber, c.[Address],\n" +
            "       COALESCE(SUM(od.Quantity * od.Price), 0) AS total\n" +
            "FROM [Order] o\n" +
            "JOIN Customer c ON c.CustomerID = o.CustomerID\n" +
            "LEFT JOIN OrderDetail od ON od.OrderID = o.OrderID\n" +
            "WHERE o.OrderID = ? AND c.AccountID = ?\n" +
            "GROUP BY o.OrderID, o.OrderDate, o.Status, c.CustomerName, c.PhoneNumber, c.[Address]";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OrderSummary o = new OrderSummary();
                    o.setOrderId(rs.getInt("OrderID"));
                    o.setOrderDate(rs.getTimestamp("OrderDate"));
                    o.setStatus(rs.getInt("Status"));
                    o.setCustomerName(rs.getString("CustomerName"));
                    o.setPhone(rs.getString("PhoneNumber"));
                    o.setAddress(rs.getString("Address"));
                    o.setTotal(rs.getDouble("total"));
                    return o;
                }
            }
        }
        return null; // không tồn tại hoặc không thuộc account này
    }
}