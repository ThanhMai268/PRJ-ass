/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Control;

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

/**
 *
 * @author dungdzpro
 */
@WebServlet(name="CheckoutServlet", urlPatterns={"/Checkout"})
public class CheckoutServlet extends HttpServlet {

    private Object getAcc(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return (s == null) ? null : s.getAttribute("acc");
    }

    private String getUserId(Object acc) {
        return String.valueOf(((Account) acc).getAid());
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpServletRequest req, String userId) {
        HttpSession session = req.getSession(false);
        if (session == null) return new ArrayList<>();
        String key = "cart_u" + userId;
        Object obj = session.getAttribute(key);
        return (obj == null) ? new ArrayList<>() : (List<CartItem>) obj;
    }

    private void putTotals(HttpServletRequest req, List<CartItem> cart) {
        long subtotal = 0;
        for (CartItem it : cart) subtotal += it.subtotal();
        long total = subtotal; // + ship/discount nếu có
        req.setAttribute("cartItems", cart);
        req.setAttribute("cartSubtotal", subtotal);
        req.setAttribute("cartTotal", total);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Bắt buộc login
        Object acc = getAcc(request);
        if (acc == null) {
            response.sendRedirect(request.getContextPath()+"/Login?errorCheckout=1");
            return;
        }

        // 2) Lấy giỏ từ session theo user
        String uid = getUserId(acc);
        List<CartItem> cart = getCart(request, uid);

        // Không có gì trong giỏ → quay lại Cart
        if (cart.isEmpty()) {
            response.sendRedirect(request.getContextPath()+"/Cart?empty=1");
            return;
        }

        // 3) Tính tiền & đổ attribute cho JSP
        putTotals(request, cart);

        // (tùy chọn) lưu “bản nháp” order vào session để khóa snapshot khi điền địa chỉ:
        // request.getSession().setAttribute("orderDraft", new ArrayList<>(cart));

        // 4) Forward sang checkout.jsp
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }
}
