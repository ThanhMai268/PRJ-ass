/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Color;
import Model.ProductDetail;
import Model.Size;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author dungdzpro
 */
public class ColorDAO extends DBConnect {
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    public List<Color> getColorOfProduct(List<ProductDetail> listProductDetail) {
        List<Color> listColor = new ArrayList<>();
        // Giả sử ProductDetail có khóa SizeID → join Size để lấy (SizeID, SizeValue)
        String sql
                = "SELECT c.ColorID, c.ColorName,c.Status "
                + "FROM ProductDetail p "
                + "JOIN Color c ON p.ColorID = c.ColorID "
                + "WHERE p.ProductDetailID = ?";

        // Khử trùng lặp size
        Set<Integer> seen = new HashSet<>();

        try (Connection conn = new DBConnect().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {

            for (ProductDetail pd : listProductDetail) {
                ps.setInt(1, pd.getPdid());
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int colorId = rs.getInt("ColorID");
                        String colorName = rs.getString("ColorName");
                        int status = rs.getInt("Status");
                        if (seen.add(colorId)) {
                            listColor.add(new Color(colorId, colorName,status));
                        }
                    }
                }
            }
        } catch (Exception e) {
            setErrorCode(-1);
            return null;
        }
        return listColor;
    }
}
