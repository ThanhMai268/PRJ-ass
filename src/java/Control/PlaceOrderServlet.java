/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.CustomerDAO;
import DAO.OrderDAO;
import DAO.OrderDetailDAO;
import DAO.ProductDAO;
import DAO.ProductDetailDAO;
import Model.Account;
import Model.CartItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

/**
 *
 * @author dungdzpro
 */
@WebServlet(name="PlaceOrderServlet", urlPatterns={"/PlaceOrder"})
public class PlaceOrderServlet extends HttpServlet {
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PlaceOrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PlaceOrderServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Account getAcc(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return (s == null) ? null : (Account) s.getAttribute("acc");
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpServletRequest req, String userId) {
        HttpSession s = req.getSession(false);
        if (s == null) return new ArrayList<>();
        Object obj = s.getAttribute("cart_u" + userId);
        return (obj == null) ? new ArrayList<>() : (List<CartItem>) obj;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = getAcc(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/Login");
            return;
        }
        req.setCharacterEncoding("UTF-8");

        String firstName = req.getParameter("firstName");
        String lastName  = req.getParameter("lastName");
        String fullName  = ((firstName == null ? "" : firstName.trim()) + " " +
                            (lastName  == null ? "" : lastName.trim())).trim();
        String phone     = req.getParameter("phone");
        String address   = req.getParameter("address");

        String userId = String.valueOf(acc.getAid());
        List<CartItem> cart = getCart(req, userId);
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/Cart");
            return;
        }

        try {
            CustomerDAO customerDAO       = new CustomerDAO();
            OrderDAO orderDAO             = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ProductDetailDAO pdDAO        = new ProductDetailDAO();
            ProductDAO pDAO = new ProductDAO();

            // 1) Customer
            Integer customerId = customerDAO.findIdByAccountId(acc.getAid());
            if (customerId == null) {
                customerId = customerDAO.insert(fullName, phone, acc.getAid(), address);
            } else {
                customerDAO.updateInfo(customerId, fullName, phone, address);
            }
            
            // 2) Order
            int orderId = orderDAO.insert(LocalDateTime.now(), customerId, 0);

            // 3) OrderDetails (price = double)
            for (CartItem it : cart) {
                int pdId = pdDAO.getProductDetailByAttribute(it.getProductId(), it.getColorId(), it.getSizeId()).getPdid();
                int qty  = it.getQuantity();

                // ưu tiên lấy từ item nếu có
                Double unitPrice = it.getPrice(); // giả định CartItem có kiểu Double
                if (unitPrice == null) {
                    unitPrice = pDAO.getProductById(it.getProductId()).getPrice(); // có thể trả null
                }
                if (unitPrice == null) {
                    // fallback: tính từ subtotal()
                    double sub = it.subtotal(); // đảm bảo subtotal() trả double
                    unitPrice = sub / Math.max(qty, 1);
                }

                orderDetailDAO.insert(orderId, pdId, qty, unitPrice);
            }

            // clear cart + redirect
            req.getSession().removeAttribute("cart_u" + userId);
            resp.sendRedirect(req.getContextPath() + "/orderComplete.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("orderError", "Đặt hàng thất bại: " + e.getMessage());
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }

}
