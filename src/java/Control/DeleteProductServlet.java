/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Control;

import DAO.ProductDAO;
import Model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeleteProductServlet", urlPatterns = {"/DeleteProductServlet"})
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        if (acc == null || acc.getRole() != 1) { 
            response.sendRedirect(request.getContextPath() + "/Home"); 
            return;
        }
        int pid = 0;
        try {
            pid = Integer.parseInt(request.getParameter("pid"));
        } catch (NumberFormatException e) {
            System.err.println("Invalid PID: " + e.getMessage());
        }

        if (pid > 0) {
            ProductDAO dao = new ProductDAO();
            
            boolean success = dao.deleteProductPermanently(pid); 
            
            if (!success) {
                System.err.println("Could not delete product ID: " + pid + ". Check for constraints.");
            }
        }

        response.sendRedirect("ProductManagerServlet");
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
        doGet(request, response);
    }
}

