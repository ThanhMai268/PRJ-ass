/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dungdzpro
 */
public class tbProduct extends DBConnect {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public tbProduct() {
        super();//gọi hàm tạo của lớp cha DBConnect để kết nối CSDL
    }

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from product";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return list;
    }

    public List<Product> getProductByBrand(String brand) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where Brand = ?";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, brand);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return list;
    }

    public Product getProductById(int pid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where ProductID = = ?";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4)
                );
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return null;
    }
    public List<String> getALlCategory() {
        List<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT Category FROM Product WHERE Status = 1 ORDER BY Category";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Category"));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return list;
    }
    public List<Product> getProductByCatgory(String cate) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where Category = ?";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, cate);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return list;
    }
}
