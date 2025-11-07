<%--
    Document    : orderDetail.jsp (FILE CON - Giao diện Hóa đơn AdminLTE)
    Author      : ADMIN
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Model.Order" %>
<%@ page import="Model.Customer" %>
<%@ page import="Model.OrderDetailView" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // --- GIỮ NGUYÊN LOGIC SCRIPTLET CỦA BẠN ---
    Order order = (Order) request.getAttribute("order");
    Customer customer = (Customer) request.getAttribute("customer");
    List<OrderDetailView> items = (List<OrderDetailView>) request.getAttribute("items");

    Map<Integer, String> statusMap = new HashMap<>();
    statusMap.put(0, "Pending");
    statusMap.put(1, "Processing");
    statusMap.put(2, "Shipped");
    statusMap.put(3, "Cancelled");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    // Thêm logic để gán màu cho Status
    String statusLabelClass = "label-warning"; // Pending
    if (order.getStatus() == 1) statusLabelClass = "label-info"; // Processing
    if (order.getStatus() == 2) statusLabelClass = "label-success"; // Shipped
    if (order.getStatus() == 3) statusLabelClass = "label-danger"; // Cancelled
    
    // --- KẾT THÚC LOGIC SCRIPTLET ---
%>

<section class="content-header">
    <h1>
        Order Details
        <small>#<%= order.getOrderID() %></small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/OverviewServlet"><i class="fa fa-cogs"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/OrderManagerServlet">Sale Management</a></li>
        <li class="active">Order #<%= order.getOrderID() %></li>
    </ol>
</section>

<section class="content">

    <section class="invoice">
        <div class="row">
            <div class="col-xs-12">
                <h2 class="page-header">
                    <i class="fa fa-file-text-o"></i> Order ID: #<%= order.getOrderID() %>
                    <small class="pull-right">Order Date: <%= sdf.format(order.getOrderDate()) %></small>
                </h2>
            </div>
        </div>

        <div class="row invoice-info">
            <div class="col-sm-6 invoice-col">
                <strong>Customer Details</strong>
                <address>
                    <strong><%= customer.getCustomerName() %></strong><br>
                    Address: <%= customer.getAddress() %><br>
                    Phone: <%= customer.getPhoneNumber() %><br>
                    <%-- Email: <%= customer.getEmail() %> --%> <%-- (Bạn có thể thêm nếu có) --%>
                </address>
            </div>
            <div class="col-sm-6 invoice-col">
                <b>Order Status:</b> 
                <span class="label <%= statusLabelClass %>" style="font-size: 14px;"><%= statusMap.get(order.getStatus()) %></span>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th style="width: 10%;">Image</th>
                            <th>Product</th>
                            <th style="width: 15%;">Details (Size/Color)</th>
                            <th style="width: 10%;">Qty</th>
                            <th style="width: 15%;">Price</th>
                            <th style="width: 15%;">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (OrderDetailView item : items) {
                                double itemTotal = item.getPrice() * item.getQuantity();
                        %>
                        <tr>
                            <td>
                                <img src="images/<%= item.getImage() %>" alt="<%= item.getProductName() %>" 
                                     style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
                            </td>
                            <td><%= item.getProductName() %></td>
                            <td>
                                Size: <%= item.getSizeValue() %><br>
                                Color: <%= item.getColorName() %>
                            </td>
                            <td><%= item.getQuantity() %></td>
                            <td>$<%= String.format("%.2f", item.getPrice()) %></td>
                            <td>$<%= String.format("%.2f", itemTotal) %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <a href="OrderManagerServlet" class="btn btn-default"><i class="fa fa-arrow-left"></i> Back to Order List</a>
            </div>

            <div class="col-xs-6">
                <p class="lead">Amount Due</p>
                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th style="width:50%">Subtotal:</th>
                                <td>$<%= request.getAttribute("subtotal") %></td>
                            </tr>
                            <tr>
                                <th>Shipping:</th>
                                <td>$0.00</td> <%-- (Lấy từ code servlet của bạn) --%>
                            </tr>
                            <tr>
                                <th>Grand Total:</th>
                                <td><strong>$<%= request.getAttribute("grandTotal") %></strong></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section> 
</section>