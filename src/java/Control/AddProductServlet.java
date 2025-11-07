/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;
import DAO.ProductDAO;
import Model.Product;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="AddProductServlet", urlPatterns={"/AddProductServlet"})
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProductDAO dao = new ProductDAO();
        List<String> brandList = dao.getAllBrand(); 
        List<String> categoryList = dao.getALlCategory();
        
        request.setAttribute("brandList", brandList);
        request.setAttribute("categoryList", categoryList);
        
        request.setAttribute("pageView", "addProduct.jsp");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String productName = request.getParameter("product_name");
        String imageUrl = request.getParameter("product_image_url");
        String priceStr = request.getParameter("product_price");
        String brand = request.getParameter("brand_name"); 
        String category = request.getParameter("category_name");
        
        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) { e.printStackTrace(); }
        
        Product newProduct = new Product(0, productName, imageUrl, price, category, brand, 1);
        
        ProductDAO dao = new ProductDAO();
        dao.addProduct(newProduct); 
        
        response.sendRedirect("ProductManagerServlet"); 
    }
}