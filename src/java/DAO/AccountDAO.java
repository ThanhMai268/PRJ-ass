/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author dungdzpro
 */
public class AccountDAO extends DBConnect {

    public Account login(String email, String pass) {
        String query = "select * from Account where Email = ? and Password = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection(); // mở kết nối với SQL
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1); // lỗi lệnh SQL
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }

    public void signup(String email, String pass) {
        String query = "INSERT INTO Account (Email, Password, Role, Status) VALUES (?, ?, 2, 1)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1); // lỗi lệnh SQL
        } finally {
            close(conn, ps, null);
        }
    }

    public boolean checkAccountExist(String email) {
        String query = "SELECT * FROM Account WHERE Email = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1); // lỗi lệnh SQL
        } finally {
            close(conn, ps, rs);
        }
        return false;
    }

    public boolean isAdmin(String email, String pass) {
        String query = "select Role from Account where Email = ? and Password = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection(); // mở kết nối với SQL
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getInt(1) == 1) return true;
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            setErrorCode(-1); // lỗi lệnh SQL
        } finally {
            close(conn, ps, rs);
        }
        return false;
    }
}
