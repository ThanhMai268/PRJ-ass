/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.CustomerDAO;
import DAO.OrderDAO;
import Model.Customer;
import Model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="OrderManagerServlet", urlPatterns={"/OrderManagerServlet"})
public class OrderManagerServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy tham số lọc 'status'
        String statusParam = request.getParameter("status");
        int selectedStatus = -1; // Mặc định là "All Statuses"
        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                selectedStatus = Integer.parseInt(statusParam);
            } catch (NumberFormatException e) {
                selectedStatus = -1; // Nếu lỗi thì quay về mặc định
            }
        }

        // 2. Khởi tạo DAOs
        OrderDAO orderDAO = new OrderDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        // 3. Lấy dữ liệu từ DAOs
        List<Order> orderList = orderDAO.getOrdersByStatus(selectedStatus);
        Map<Integer, Double> orderTotals = orderDAO.getOrderTotals();
        Map<Integer, Customer> customerMap = customerDAO.getAllCustomersAsMap();

        // 4. Đặt attributes để gửi cho JSP
        request.setAttribute("orderList", orderList);
        request.setAttribute("orderTotals", orderTotals);
        request.setAttribute("customerMap", customerMap);
        request.setAttribute("selectedStatus", selectedStatus);
        
        
        request.setAttribute("pageView", "orderManager.jsp");
        // 5. Forward đến trang JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    /**
     * Xử lý POST request (Cập nhật trạng thái qua AJAX)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Lấy tham số từ AJAX
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int status = Integer.parseInt(request.getParameter("status"));

            // 2. Gọi DAO để cập nhật
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.updateOrderStatus(orderId, status);

            // 3. Gửi phản hồi lại cho AJAX
            if (success) {
                response.setContentType("text/plain");
                response.getWriter().write("Success");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update status");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input");
        }
    }
}