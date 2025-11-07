/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import java.util.List;

// ĐỔI TỪ JAVAX SANG JAKARTA
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="EditProductServlet", urlPatterns={"/editProduct"})
public class EditProductServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String id_raw = request.getParameter("pid");
            int id = Integer.parseInt(id_raw);
            
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);
            List<String> brandList = dao.getAllBrand();
            List<String> categoryList = dao.getALlCategory();
            
            request.setAttribute("productToEdit", product);
            request.setAttribute("brandList", brandList);
            request.setAttribute("categoryList", categoryList);
            
            request.setAttribute("pageView", "EditProduct.jsp");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("ProductManagerServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            String id_raw = request.getParameter("product_id");
            String name = request.getParameter("product_name");
            String image = request.getParameter("product_image_url");
            String price_raw = request.getParameter("product_price");
            String brand = request.getParameter("brand_name");
            String category = request.getParameter("category_name");
            
            int id = Integer.parseInt(id_raw);
            double price = Double.parseDouble(price_raw);

            ProductDAO dao = new ProductDAO();
            dao.updateProduct(id, name, image, price, category, brand);

            response.sendRedirect("ProductManagerServlet");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("editProduct?pid=" + request.getParameter("product_id") + "&error=true");
        }
    }
}
