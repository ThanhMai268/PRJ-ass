/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;
import DAO.ProductDAO;
import Model.Account;
import Model.Product;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="AddProductServlet", urlPatterns={"/AddProductServlet"})
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        if (acc == null || acc.getRole() != 1) { 
            response.sendRedirect(request.getContextPath() + "/Home"); 
            return;
        }
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
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        if (acc == null || acc.getRole() != 1) { 
            response.sendRedirect(request.getContextPath() + "/Home"); 
            return;
        }
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

        System.out.println("--- [AddProductServlet] Running doPost ---");
        System.out.println("Calling dao.addProduct...");
        
        int newProductID = dao.addProduct(newProduct);
        
        System.out.println("ProductID returned from DAO: " + newProductID); 
        
        if (newProductID > 0) {
            System.out.println("ID > 0, calling addDefaultVariants...");
            int rowsInserted = dao.addDefaultVariants(newProductID);
            System.out.println("addDefaultVariants finished. Rows inserted: " + rowsInserted);

        } else {
            System.out.println("ID <= 0, SKIPPING addDefaultVariants.");
        }
        
        System.out.println("Redirecting to ProductManagerServlet...");
        response.sendRedirect("ProductManagerServlet"); 
    }
}