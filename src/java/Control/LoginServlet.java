/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Control;

import DAO.AccountDAO;
import Model.Account;
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
 * @author dungdzpro
 */
@WebServlet(name = "LoginControl", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String pass  = request.getParameter("pass");

    AccountDAO dao = new AccountDAO();
    Account acc = dao.login(email, pass);

    if (acc == null) {
        // Sai tài khoản hoặc mật khẩu
        request.setAttribute("errorLogin", "Wrong email or password!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return; // dừng lại, tránh chạy tiếp
    }

    // Đăng nhập thành công → lưu session
    HttpSession session = request.getSession();
    session.setAttribute("acc", acc);

    // Kiểm tra quyền admin
    if (dao.isAdmin(email, pass)) {
        response.sendRedirect("OverviewServlet");
    } else {
        response.sendRedirect("Home");
    }
}


}
