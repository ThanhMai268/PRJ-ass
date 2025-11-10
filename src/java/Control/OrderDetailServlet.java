/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Control;

import DAO.CustomerDAO;
import DAO.OrderDAO;
import Model.Customer;
import Model.Order;
import Model.OrderDetailView;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/orderDetail"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String orderIdParam = request.getParameter("orderID");
        
        if (orderIdParam == null) {
            response.sendRedirect("OrderManagerServlet");
            return;
        }

        try {
            int orderID = Integer.parseInt(orderIdParam);

            OrderDAO orderDAO = new OrderDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            Order order = orderDAO.getOrderById(orderID);
            if (order == null) {
                response.sendRedirect("OrderManagerServlet");
                return;
            }

            Customer customer = customerDAO.getCustomerById(order.getCustomerID());

            List<OrderDetailView> items = orderDAO.getOrderDetails(orderID);

            double subtotal = 0;
            for (OrderDetailView item : items) {
                subtotal += item.getPrice() * item.getQuantity();
            }
            double shippingFee = 0.0;
            double grandTotal = subtotal + shippingFee;

            request.setAttribute("order", order);
            request.setAttribute("customer", customer);
            request.setAttribute("items", items);
            request.setAttribute("subtotal", String.format("%.2f", subtotal));
            request.setAttribute("grandTotal", String.format("%.2f", grandTotal));

            request.setAttribute("pageView", "orderDetail.jsp");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("OrderManagerServlet");
        }
    }
}