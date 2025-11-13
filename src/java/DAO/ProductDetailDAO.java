/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.ProductDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dungdzpro
 */
public class ProductDetailDAO extends DBConnect {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<ProductDetail> getProductDetailByPid(int pid) {
        List<ProductDetail> list = new ArrayList<>();
        String query = "select * from ProductDetail where ProductID = ?";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductDetail(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return list;
    }

    public ProductDetail getProductDetailByAttribute(int pid, int cid, int sid) {

        String query = "select * from ProductDetail where ProductID = ? and ColorID = ? and SizeID = ?";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            ps.setInt(2, cid);
            ps.setInt(3, sid);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new ProductDetail(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)
                );
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return null;
    }

    public boolean decreaseStock(int productDetailId, int qty) {
        String sql = "UPDATE ProductDetail "
                + "SET Quantity = Quantity - ? "
                + "WHERE ProductDetailID = ? AND Quantity >= ?";
        conn = null;
        PreparedStatement ps = null;
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, qty);
            ps.setInt(2, productDetailId);
            ps.setInt(3, qty);
            int rows = ps.executeUpdate();
            return rows > 0; // true nếu đủ hàng và đã trừ thành công
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
            return false;
        } finally {
            close(conn, ps, null);
        }
    }

}
