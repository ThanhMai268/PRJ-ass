/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.Connection; 
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DBConnect {
    static String dbUser = "sa";
    static String dbPass = "123456";
    static String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=ShoeShopDB;encrypt=true;trustServerCertificate=true";
    
    protected Connection conn; //Connection là 1 property lưu kết nối CSDL
    protected int erorrCode; //-2: lỗi kết nối, -1 Lỗi SQL, 0: không lỗi
    public DBConnect() //Constructor cài đặt lệnh kết nối CSDL và lưu vào conn
    {
        conn=null;
        erorrCode = -2;//qui ước -2 là lỗi kết lỗi
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            erorrCode = 0; //không lỗi
        } catch (ClassNotFoundException|SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    //thêm phương thức getConneection
    public Connection getConnection()
    {
        return conn;
    }
    public int getErrorCode()
    {
        return erorrCode;
    }
    public void setErrorCode(int errorCode)
    {
        this.erorrCode = errorCode;
    }
    public void close(Connection conn, PreparedStatement ps, ResultSet rs) {
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
}
