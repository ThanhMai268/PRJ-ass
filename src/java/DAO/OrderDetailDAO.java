/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.OrderDetailView;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dungdzpro
 */
public class OrderDetailDAO extends DBConnect {

    
    
    public void insert(int orderId, int productDetailId, int quantity, double price)  {
        String sql = "INSERT INTO [OrderDetail](OrderID, ProductDetailID, Quantity, Price) VALUES (?,?,?,?)";
        Connection conn = null;
        
        ResultSet rs = null;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, productDetailId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            ps.executeUpdate();
        } catch (Exception e) {
            setErrorCode(-1);}
    }
    public List<OrderDetailView> findItemsByOrderId(int orderId) throws SQLException {
        String sql =
            "SELECT p.ProductName,\n" +
            "       p.Image,  -- đổi tên cột ảnh cho đúng schema của bạn\n" +
            "       cl.ColorName,\n" +
            "       s.SizeValue,\n" +
            "       od.Quantity,\n" +
            "       od.Price\n" +
            "FROM OrderDetail od\n" +
            "JOIN ProductDetail pd ON pd.ProductDetailID = od.ProductDetailID\n" +
            "JOIN Product p       ON p.ProductID       = pd.ProductID\n" +
            "LEFT JOIN Size  s    ON s.SizeID          = pd.SizeID\n" +
            "LEFT JOIN Color cl   ON cl.ColorID        = pd.ColorID\n" +
            "WHERE od.OrderID = ?";

        List<OrderDetailView> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailView it = new OrderDetailView();
                    it.setProductName(rs.getString("ProductName"));
                    it.setImage(rs.getString("Image"));
                    it.setColorName(rs.getString("ColorName"));
                    it.setSizeValue(rs.getInt("SizeValue"));
                    it.setQuantity(rs.getInt("Quantity"));
                    it.setPrice(rs.getDouble("Price"));
                    list.add(it);
                }
            }
        }
        return list;
    }
}
