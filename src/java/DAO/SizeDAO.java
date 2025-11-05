/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Product;
import Model.ProductDetail;
import Model.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.sql.Connection; 
/**
 *
 * @author dungdzpro
 */
public class SizeDAO extends DBConnect {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public SizeDAO() {
        super();
    }

    public List<Size> getSizeOfProduct(List<ProductDetail> listProductDetail) {
        List<Size> listSize = new ArrayList<>();
        // Giả sử ProductDetail có khóa SizeID → join Size để lấy (SizeID, SizeValue)
        String sql
                = "SELECT s.SizeID, s.SizeValue "
                + "FROM ProductDetail p "
                + "JOIN Size s ON p.SizeID = s.SizeID "
                + "WHERE p.ProductDetailID = ?";

        // Khử trùng lặp size
        Set<Integer> seen = new HashSet<>();

        try (Connection conn = new DBConnect().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {

            for (ProductDetail pd : listProductDetail) {
                ps.setInt(1, pd.getPdid());
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int sizeId = rs.getInt("SizeID");
                        int sizeVal = rs.getInt("SizeValue");
                        if (seen.add(sizeId)) {
                            listSize.add(new Size(sizeId, sizeVal));
                        }
                    }
                }
            }
        } catch (Exception e) {
            setErrorCode(-1);
            return null;
        }
        return listSize;
    }
    
    public String getSizeValueById(int sid) {
        
        String query = "select SizeValue from Size where SizeID = ?";
        String sizeValue = "";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return "";
        }
        return "";
    }
}
