/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

import DAO.OrderDAO;
import DAO.OrderDetailDAO;
import Model.Account;
import Model.OrderDetailView;
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
@WebServlet(name="ViewOrderDetailServlet", urlPatterns={"/ViewOrderDetail"})
public class ViewOrderDetailServlet extends HttpServlet {
   
    private Account getAcc(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return (s == null) ? null : (Account) s.getAttribute("acc");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Account acc = getAcc(req);
        if (acc == null) { resp.sendRedirect(req.getContextPath() + "/Login"); return; }

        String idRaw = req.getParameter("id");
        if (idRaw == null) { resp.sendError(400, "Missing order id"); return; }

        try {
            int orderId = Integer.parseInt(idRaw);

            // 1) Kiểm tra quyền + lấy summary
            OrderSummary order = new OrderDAO().findSummaryByIdForAccount(orderId, acc.getAid());
            if (order == null) {
                resp.sendError(404, "Order not found");
                return;
            }

            // 2) Lấy items
            List<OrderDetailView> items = new OrderDetailDAO().findItemsByOrderId(orderId);

            // 3) Đổ ra JSP
            req.setAttribute("order", order);
            req.setAttribute("items", items);
            req.getRequestDispatcher("/viewOrderDetail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(400, "Invalid order id");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Cannot load order detail: " + e.getMessage());
        }
    }

}
