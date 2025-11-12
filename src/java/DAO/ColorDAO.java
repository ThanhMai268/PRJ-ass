/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Color;
import Model.ProductDetail;
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

    public List<Color> getColorOfProduct(List<ProductDetail> listProductDetail) {
        List<Color> listColor = new ArrayList<>();

        String sql = "SELECT c.ColorID, c.ColorName, c.Status "
                   + "FROM ProductDetail p "
                   + "JOIN Color c ON p.ColorID = c.ColorID "
                   + "WHERE p.ProductDetailID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // Khử trùng lặp theo ColorID
        Set<Integer> seen = new HashSet<>();

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);

            for (ProductDetail pd : listProductDetail) {
                // đóng rs cũ trước khi dùng lại ps (an toàn khi vòng lặp)
                if (rs != null) { try { rs.close(); } catch (Exception ignored) {} }
                ps.setInt(1, pd.getPdid());
                rs = ps.executeQuery();
                while (rs.next()) {
                    int colorId = rs.getInt("ColorID");
                    String colorName = rs.getString("ColorName");
                    int status = rs.getInt("Status");
                    if (seen.add(colorId)) {
                        listColor.add(new Color(colorId, colorName, status));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
            return null;
        } finally {
            close(conn, ps, rs);
        }
        return listColor;
    }

    public String getColorNameById(int cid) {
        String query = "SELECT ColorName FROM Color WHERE ColorID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
            return "";
        } finally {
            close(conn, ps, rs);
        }
        return "";
    }
}
