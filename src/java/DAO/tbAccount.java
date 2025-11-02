/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import Model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author dungdzpro
 */
public class tbAccount extends DBConnect {
     PreparedStatement ps = null;
    ResultSet rs = null;

    public Account login(String email,String pass) {
        
        String query = "select * from Account where Email = ? and Password = ? ";
        try {
            conn = new DBConnect().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getInt(4));
            }
        } catch (Exception e) {
            setErrorCode(-1);//lỗi lệnh SQL
            return null;
        }
        return null;
    }
}
