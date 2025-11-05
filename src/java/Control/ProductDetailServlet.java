/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Control;

import DAO.ColorDAO;
import DAO.ProductDAO;
import DAO.ProductDetailDAO;
import DAO.SizeDAO;
import Model.Color;
import Model.Product;
import Model.ProductDetail;
import Model.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author dungdzpro
 */
@WebServlet(name = "ProductDetailControl", urlPatterns = {"/ProductDetail"})
public class ProductDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1) Lấy pid (bắt buộc) + sizeId/colorId (tùy chọn qua ?sizeId=..&colorId=..)
        String pidRaw = request.getParameter("pid");
        if (pidRaw == null) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }
        int pid = Integer.parseInt(pidRaw);

        Integer selectedSizeId = parseNullableInt(request.getParameter("sizeId"));
        Integer selectedColorId = parseNullableInt(request.getParameter("colorId"));

        // 2) Gọi DAO đúng như bạn đang dùng
        ProductDAO tbpro = new ProductDAO();
        ProductDetailDAO tbprode = new ProductDetailDAO();
        ColorDAO tbColor = new ColorDAO();
        SizeDAO tbSize = new SizeDAO();

        Product pro = tbpro.getProductById(pid);
        List<ProductDetail> listprode = tbprode.getProductDetailByPid(pid);
        
        List<Size> listSize = tbSize.getSizeOfProduct(listprode);
        List<Color> listColor = tbColor.getColorOfProduct(listprode);

        // 3) Tạo stockMap (size:color -> quantity)
        Map<String, Integer> stockMap = new HashMap<>();
        for (ProductDetail d : listprode) {
            int sid = d.getSid();
            int cid = d.getCid();
            int qty = d.getQuantity();
            stockMap.put(sid + ":" + cid, qty);
        }

        // 4) Tập allowed theo lựa chọn hiện tại
        Set<Integer> allowedColors = null;
        if (selectedSizeId != null) {
            allowedColors = new HashSet<>();
            for (ProductDetail d : listprode) {
                if (d.getSid() == selectedSizeId && d.getQuantity() > 0) {
                    allowedColors.add(d.getCid());
                }
            }
        }

        Set<Integer> allowedSizes = null;
        if (selectedColorId != null) {
            allowedSizes = new HashSet<>();
            for (ProductDetail d : listprode) {
                if (d.getCid() == selectedColorId && d.getQuantity() > 0) {
                    allowedSizes.add(d.getSid());
                }
            }
        }

        // 5) Tồn kho của cặp đang chọn
        int currentStock = 0;
        if (selectedSizeId != null && selectedColorId != null) {
            currentStock = stockMap.getOrDefault(selectedSizeId + ":" + selectedColorId, 0);
            // Nếu cặp không còn hợp lệ → reset để JSP tự disable Add to Cart
            if (currentStock <= 0) {
                selectedSizeId = null;
                selectedColorId = null;
            }
        }

        // 6) Gắn attribute về JSP
        request.setAttribute("pro", pro);
        
//        request.setAttribute("listprode", listprode);
        request.setAttribute("listSize", listSize);
        request.setAttribute("listColor", listColor);

        request.setAttribute("allowedColors", allowedColors);
        request.setAttribute("allowedSizes", allowedSizes);
        request.setAttribute("selectedSizeId", selectedSizeId);
        request.setAttribute("selectedColorId", selectedColorId);
        request.setAttribute("currentStock", currentStock);

        // Forward
        request.getRequestDispatcher("productdetail.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private static Integer parseNullableInt(String s) {
        try {
            return (s == null || s.isEmpty()) ? null : Integer.valueOf(s);
        } catch (Exception e) {
            return null;
        }
    }
    public static void main(String[] args) {
        ProductDetailDAO tbprode = new ProductDetailDAO();
        List<ProductDetail> listprode = tbprode.getProductDetailByPid(2);
        SizeDAO tbSize = new SizeDAO();
        ColorDAO tbColor = new ColorDAO();
        List<Size> listSize = tbSize.getSizeOfProduct(listprode);
        List<Color> listColor = tbColor.getColorOfProduct(listprode);
        System.out.println(listColor);
    }
}
