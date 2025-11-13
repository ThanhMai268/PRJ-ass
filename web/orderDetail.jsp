<%--
    Document    : orderDetail.jsp (FILE CON)
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
    Order order = (Order) request.getAttribute("order");
    Customer customer = (Customer) request.getAttribute("customer");
    List<OrderDetailView> items = (List<OrderDetailView>) request.getAttribute("items");

    Map<Integer, String> statusMap = new HashMap<>();
    statusMap.put(0, "Pending");
    statusMap.put(1, "Processing");
    statusMap.put(2, "Shipped");
    statusMap.put(3, "Cancelled");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    String statusLabelClass = "label-warning"; // Pending
    if (order.getStatus() == 1) statusLabelClass = "label-info"; // Processing
    if (order.getStatus() == 2) statusLabelClass = "label-success"; // Shipped
    if (order.getStatus() == 3) statusLabelClass = "label-danger"; // Cancelled
    
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
        <style>
            .status-select-0 {
                background-color: #f0ad4e !important;
                color: white !important;
                font-weight: bold;
            }
            .status-select-1 {
                background-color: #3c8dbc !important;
                color: white !important;
                font-weight: bold;
            }
            .status-select-2 {
                background-color: #00a65a !important;
                color: white !important;
                font-weight: bold;
            }
            .status-select-3 {
                background-color: #d9534f !important;
                color: white !important;
                font-weight: bold;
            }
            .status-select-0 option {
                background-color: white;
                color: black;
            }
            .status-select-1 option {
                background-color: white;
                color: black;
            }
            .status-select-2 option {
                background-color: white;
                color: black;
            }
            .status-select-3 option {
                background-color: white;
                color: black;
            }
        </style>        

        <div class="row invoice-info">
            <div class="col-sm-6 invoice-col">
                <strong>Customer Details</strong>
                <address>
                    <strong><%= customer.getCustomerName() %></strong><br>
                    Address: <%= customer.getAddress() %><br>
                    Phone: <%= customer.getPhoneNumber() %><br>
                </address>
            </div>

            <div class="col-sm-6 invoice-col" id="status-container">
                <b>Order Status:</b> 

                <select class="form-control order-status" data-id="<%= order.getOrderID() %>" style="width: auto; display: inline-block; margin-left: 10px;">
                    <%
                        for (Map.Entry<Integer, String> entry : statusMap.entrySet()) {
                    %>
                    <option value="<%= entry.getKey() %>" <%= (order.getStatus() == entry.getKey()) ? "selected" : "" %>>
                        <%= entry.getValue() %>
                    </option>
                    <%
                        }
                    %>
                </select>
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
                            <td><%= String.format("%.2f", item.getPrice()) %>đ</td>
                            <td><%= String.format("%.2f", itemTotal) %>đ</td>
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
                                <td>$0.00</td> 
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
<script src="${pageContext.request.contextPath}/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/fastclick/fastclick.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/app.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/demo.js"></script>
<script>
    $(document).ready(function () {
        var originalStatus;

        var statusClassMap = {
            '0': 'label-warning',
            '1': 'label-info', 
            '2': 'label-success',
            '3': 'label-danger'
        };

        $('body').off('focus', '.order-status').on('focus', '.order-status', function () {
            originalStatus = $(this).val();
        });

        $('body').off('change', '.order-status').on('change', '.order-status', function () {
            var select = $(this);
            var orderId = select.data('id');
            var newStatus = select.val();

            var statusText = select.find("option:selected").text().trim();
            var statusBadge = $('#order-status-badge'); // Tìm badge bằng ID
            var newClass = statusClassMap[newStatus];
            var container = $('#status-container'); // Tìm container

            $.ajax({
                url: '${pageContext.request.contextPath}/OrderManagerServlet',
                type: 'POST',
                data: {
                    orderId: orderId,
                    status: newStatus
                },
                success: function (response) {
                    console.log('Updated order ' + orderId + ' to status ' + newStatus);
                    originalStatus = newStatus;
                    statusBadge.text(statusText);
                    statusBadge.removeClass('label-warning label-info label-success label-danger').addClass(newClass);
                    container.css('background-color', '#dff0d8').delay(500).queue(function () {
                        $(this).css('background-color', '').dequeue();
                    });
                },
                error: function () {
                    alert('Error updating order status!');
                    select.val(originalStatus); 
                    container.css('background-color', '#f2dede').delay(500).queue(function () {
                        $(this).css('background-color', '').dequeue();
                    });
                }
            });
        });
    });
</script>

