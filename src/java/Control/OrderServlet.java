/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.OrderDAO;
import Model.Account;
import Model.OrderSummary;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;


/**
 *
 * @author dungdzpro
 */
@WebServlet(name="OrderServlet", urlPatterns={"/Order"})
public class OrderServlet extends HttpServlet {
   
   private Account getAcc(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return (s == null) ? null : (Account) s.getAttribute("acc");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = getAcc(req);
        if (acc == null) {
            resp.sendRedirect(req.getContextPath() + "/Login");
            return;
        }

        try {
            List<OrderSummary> orders = new OrderDAO().findSummariesByAccount(acc.getAid());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/order.jsp").forward(req, resp); // trang list
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Cannot load orders: " + e.getMessage());
        }
    }
}
