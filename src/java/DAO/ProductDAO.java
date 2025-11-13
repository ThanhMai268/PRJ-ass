package DAO;

import Model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDAO {

    private int errorCode;

    public void setErrorCode(int i) {
        this.errorCode = i;
    }

    private void close(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
        }
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (Exception e) {
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
        }
    }
public class ProductDAO extends DBConnect {

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product where Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return list;
    }

    public List<Product> getProductByBrand(String brand) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Product where Brand = ? and Status = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, brand.trim());
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return list;
    }

    public Product getProductById(int pid) {
        String query = "select * from product where ProductID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                );
            }
        } catch (Exception e) {
            setErrorCode(-1);
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }

    public List<String> getALlCategory() {
        List<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT Category FROM Product WHERE Status = 1 ORDER BY Category";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Category"));
            }
        } catch (Exception e) {
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return list;
    }

    public List<Product> getProductByCatgory(String cate) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product where Category = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, cate);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return list;
    }

    public boolean updateStatus(int productId, int status) {
        String sql = "UPDATE Product SET Status = ? WHERE ProductID = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, productId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            close(conn, ps, null);
        }
    }

    public Map<Integer, Integer> getProductQuantities() {
        Map<Integer, Integer> quantities = new HashMap<>();
        String sql = "SELECT p.ProductID, SUM(pd.Quantity) AS TotalQuantity "
                + "FROM Product p "
                + "JOIN ProductDetail pd ON p.ProductID = pd.ProductID "
                + "GROUP BY p.ProductID";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int quantity = rs.getInt("TotalQuantity");
                quantities.put(productId, quantity);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return quantities;
    }

    public List<String> getAllBrand() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT Brand FROM Product";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("Brand"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return brands;
    }

    public void addProduct(Product product) {
        String query = "INSERT INTO Product (ProductName, Image, Price, Category, Brand, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, product.getName());
            ps.setString(2, product.getImage());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getCategory());
            ps.setString(5, product.getBrand());
            ps.setInt(6, 1);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, null);
        }
    }

    public boolean updateProduct(int id, String name, String image, double price, String category, String brand) {
        String query = "UPDATE Product SET ProductName = ?, Image = ?, Price = ?, "
                + "Category = ?, Brand = ? WHERE ProductID = ?";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setDouble(3, price);
            ps.setString(4, category);
            ps.setString(5, brand);
            ps.setInt(6, id);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
            return false;
        } finally {
            close(conn, ps, null);
        }
    }

    public boolean deleteProductPermanently(int productId) {

        String sql1_DeleteOrderDetails = "DELETE FROM OrderDetail WHERE ProductDetailID IN (SELECT ProductDetailID FROM ProductDetail WHERE ProductID = ?)";
        String sql2_DeleteProductDetails = "DELETE FROM ProductDetail WHERE ProductID = ?";
        String sql3_DeleteProduct = "DELETE FROM Product WHERE ProductID = ?";

        Connection conn = null;

        try {
            conn = new DBConnect().getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(sql1_DeleteOrderDetails)) {
                ps1.setInt(1, productId);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = conn.prepareStatement(sql2_DeleteProductDetails)) {
                ps2.setInt(1, productId);
                ps2.executeUpdate();
            }

            try (PreparedStatement ps3 = conn.prepareStatement(sql3_DeleteProduct)) {
                ps3.setInt(1, productId);
                int rowsAffected = ps3.executeUpdate();

                conn.commit();
                return rowsAffected > 0;
            }

        } catch (SQLException e) {
            System.err.println("Transaction Error while deleting product: " + e.getMessage());
            try {
                conn.rollback();
            } catch (SQLException ex) {
                System.err.println("Rollback Error: " + ex.getMessage());
            }
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                System.err.println("Error resetting AutoCommit: " + e.getMessage());
            }
        }
    }

    public List<Product> getAllProductForAdmin() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1);
        } finally {
            close(conn, ps, rs);
        }
        return list;
    }
    public List<Product> searchByNameContains(String keyword) {
    List<Product> list = new ArrayList<>();
    if (keyword == null) keyword = "";
    keyword = keyword.trim();
    if (keyword.isEmpty()) return list; // tránh trả tất cả sản phẩm nếu không nhập gì

    String sql = "SELECT * FROM Product " +
                 "WHERE LOWER(ProductName) LIKE ? AND Status = 1";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = new DBConnect().getConnection();
        ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + keyword.toLowerCase() + "%");
        rs = ps.executeQuery();

        while (rs.next()) {
            list.add(new Product(
                rs.getInt(1),      // ProductID
                rs.getString(2),   // ProductName
                rs.getString(3),   // Image
                rs.getDouble(4),   // Price
                rs.getString(5),   // Category
                rs.getString(6),   // Brand
                rs.getInt(7)       // Status
            ));
        }
    } catch (Exception e) {
        e.printStackTrace();
        setErrorCode(-1);
    } finally {
        close(conn, ps, rs);
    }
    return list;
}


}
