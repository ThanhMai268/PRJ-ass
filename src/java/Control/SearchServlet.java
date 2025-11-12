/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author dungdzpro
 */
@WebServlet(name="SearchServlet", urlPatterns={"/Search"})
public class SearchServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");  // lấy tên sản phẩm
        if (name == null) name = "";

        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.searchByNameContains(name);  // chỉ tìm đúng tên

        req.setAttribute("name", name);
        req.setAttribute("listPro", list);

        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }
    

}
