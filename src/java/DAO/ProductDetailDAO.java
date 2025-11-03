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

    public ProductDetailDAO() {
        super();
    }
    public List<ProductDetail> getProductDetailByPid(int pid){
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
}
