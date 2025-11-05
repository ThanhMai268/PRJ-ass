/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.OverviewDAO; 
import Model.Account; 
import Model.BestSeller;
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
@WebServlet(name="OverviewServlet", urlPatterns={"/OverviewServlet"})
public class OverviewServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // 1. Kiểm tra quyền Admin
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        
        if (acc == null || acc.getRole() != 1) { 
            response.sendRedirect(request.getContextPath() + "/Home"); 
            return;
        }

        // 2. Lấy dữ liệu từ DAO (Đã sử dụng OverviewDAO)
        OverviewDAO dao = new OverviewDAO();
        
        long totalRevenue = dao.getTotalRevenue();
        int totalOrders = dao.getTotalMonthlyOrders();
        int purchasingCustomers = dao.getPurchasingCustomers();
        int totalItemsSold = dao.getTotalItemsSold();
        List<BestSeller> bestSellersList = dao.getBestSellers(3); 

        // 3. Đặt dữ liệu vào request
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("monthlyOrders", totalOrders);
        request.setAttribute("purchasingCustomers", purchasingCustomers);
        request.setAttribute("itemsSold", totalItemsSold);
        request.setAttribute("bestSellers", bestSellersList); 
        
        // 4. Chuyển tiếp đến JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Overview";
    }// </editor-fold>

}
