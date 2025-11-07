/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductManagerServlet", urlPatterns = {"/ProductManagerServlet"})
public class ProductManagerServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

        String selectedBrand = request.getParameter("brand");
        if (selectedBrand == null || selectedBrand.isEmpty()) {
            selectedBrand = "all";
        }

        List<Product> products;
        if ("all".equalsIgnoreCase(selectedBrand)) {
            products = dao.getAllProduct();
        } else {
            products = dao.getProductByBrand(selectedBrand.trim());
        }

        List<String> brands = dao.getAllBrand();
        Map<Integer, Integer> qtyMap = dao.getProductQuantities();

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("selectedBrand", selectedBrand);
        request.setAttribute("qtyMap", qtyMap);
        
        request.setAttribute("pageView", "productManager.jsp");
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý AJAX update status
        String productIdStr = request.getParameter("productId");
        String statusStr = request.getParameter("status");

        if (productIdStr != null && statusStr != null) {
            int productId = Integer.parseInt(productIdStr);
            int status = Integer.parseInt(statusStr);

            ProductDAO dao = new ProductDAO();
            boolean updated = dao.updateStatus(productId, status); // method trong DAO

            response.setContentType("text/plain");
            if (updated) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail");
            }
        } else {
            response.getWriter().write("invalid");
        }
    }

    @Override
    public String getServletInfo() {
        return "ProductManagerController";
    }// </editor-fold>

}