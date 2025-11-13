/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Control;

import DAO.ColorDAO;
import DAO.ProductDAO;
import DAO.SizeDAO;
import Model.Account;
import Model.CartItem;
import Model.ProductDetail;
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
import java.util.Optional;

/**
 *
 * @author dungdzpro
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/Cart"})
public class CartServlet extends HttpServlet {

    private Object getAcc(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return (s == null) ? null : s.getAttribute("acc"); // hoặc "user"
    }

    private String getUserId(Object acc) {
        return String.valueOf(((Account) acc).getAid());

    }

    private List<CartItem> getOrCreateCart(HttpServletRequest req, String userId) {
        HttpSession session = req.getSession(true);
        String key = "cart_u" + userId;   // mỗi acc một key riêng
        Object obj = session.getAttribute(key);
        if (obj == null) {
            List<CartItem> cart = new ArrayList<>();
            session.setAttribute(key, cart);
            return cart;
        }
        return (List<CartItem>) obj;
    }

    private void putTotals(HttpServletRequest req, List<CartItem> cart) {
        long subtotal = 0;
        for (CartItem it : cart) {
            subtotal += it.subtotal();
        }
        long total = subtotal;

        req.setAttribute("cartItems", cart);
        req.setAttribute("cartSubtotal", subtotal);
        req.setAttribute("cartTotal", total);
    }

    private CartItem toCartItem(ProductDetail pd) {
        CartItem it = new CartItem();
        ProductDAO tbProduct = new ProductDAO();
        SizeDAO tbSize = new SizeDAO();
        ColorDAO tbColor = new ColorDAO();

        var p = tbProduct.getProductById(pd.getPid()); // gọi 1 lần
        it.setProductId(pd.getPid());
        it.setColorId(pd.getCid());
        it.setSizeId(pd.getSid());
        it.setPrice(p.getPrice());                 // giả sử long/BigDecimal; nếu double thì bạn quy về long VND
        it.setName(p.getName());
        it.setImageUrl(p.getImage());

        it.setColorName(tbColor.getColorNameById(pd.getCid()));
        it.setSizeValue(tbSize.getSizeValueById(pd.getSid()));

        return it;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Object acc = getAcc(request);
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/Login?errorAddToCart=1");
            return;
        }

        String uid = getUserId(acc);
        List<CartItem> cart = getOrCreateCart(request, uid);
        putTotals(request, cart);
        request.setAttribute(uid, acc);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object acc = getAcc(request);
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/Login?errorAddToCart=1");
            return;
        }

        String uid = getUserId(acc);
        List<CartItem> cart = getOrCreateCart(request, uid);

        String action = java.util.Optional.ofNullable(request.getParameter("action")).orElse("add");

        switch (action) {
            case "add" -> {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int sizeId = Integer.parseInt(request.getParameter("sizeId"));
                int colorId = Integer.parseInt(request.getParameter("colorId"));
                int quantity = Math.max(1, Integer.parseInt(request.getParameter("quantity")));

                // LẤY currentStock gửi từ productdetail.jsp (nếu có)
                String maxStockRaw = request.getParameter("maxStock");
                int maxStock = Integer.MAX_VALUE;
                if (maxStockRaw != null && !maxStockRaw.isBlank()) {
                    try {
                        maxStock = Integer.parseInt(maxStockRaw);
                    } catch (NumberFormatException e) {
                        maxStock = Integer.MAX_VALUE; // nếu parse lỗi thì coi như không giới hạn
                    }
                }

                // Map sang CartItem (tên/giá/ảnh/sizeName/colorName… từ DAO)
                ProductDetail pd = new ProductDetail();
                pd.setPid(productId);
                pd.setSid(sizeId);
                pd.setCid(colorId);
                CartItem newItem = toCartItem(pd);

                // Tìm item cũ trong cart
                int idx = cart.indexOf(newItem);
                CartItem target;

                if (idx >= 0) {
                    // Đang update từ cart.jsp (nút +/-): quantity là GIÁ TRỊ MỚI
                    target = cart.get(idx);

                    // Nếu lần này không gửi maxStock (request từ cart.jsp),
                    // dùng lại maxQuantity đã lưu trước đó
                    if (maxStock == Integer.MAX_VALUE && target.getMaxQuantity() > 0) {
                        maxStock = target.getMaxQuantity();
                    }

                    int newQty = quantity;
                    if (maxStock != Integer.MAX_VALUE && newQty > maxStock) {
                        newQty = maxStock; // không cho vượt
                    }

                    target.setQuantity(newQty);
                    target.setMaxQuantity(maxStock);
                } else {
                    // Add từ productdetail.jsp (lần đầu)
                    target = newItem;

                    int newQty = quantity;
                    if (maxStock != Integer.MAX_VALUE && newQty > maxStock) {
                        newQty = maxStock;
                    }

                    target.setQuantity(newQty);
                    target.setMaxQuantity(maxStock);
                    cart.add(target);
                }
            }

            case "remove" -> {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int sizeId = Integer.parseInt(request.getParameter("sizeId"));
                int colorId = Integer.parseInt(request.getParameter("colorId"));

                CartItem key = new CartItem();
                key.setProductId(productId);
                key.setSizeId(sizeId);
                key.setColorId(colorId);
                cart.remove(key);
            }

            case "clear" ->
                cart.clear();
        }

        response.sendRedirect(request.getContextPath() + "/Cart");
    }

}
