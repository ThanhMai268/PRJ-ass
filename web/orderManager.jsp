<%--
    Document    : saleManagement.jsp (FILE CON - Giao diện AdminLTE)
    Author      : ADMIN
--%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Model.Order" %>
<%@ page import="Model.Customer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // --- GIỮ NGUYÊN LOGIC SCRIPTLET CỦA BẠN ---
    List<Order> orders = (List<Order>) request.getAttribute("orderList");
    Map<Integer, Double> orderTotals = (Map<Integer, Double>) request.getAttribute("orderTotals");
    Map<Integer, Customer> customerMap = (Map<Integer, Customer>) request.getAttribute("customerMap");
    int selectedStatus = (Integer) request.getAttribute("selectedStatus");

    Map<Integer, String> statusMap = new HashMap<>();
    statusMap.put(0, "Pending");
    statusMap.put(1, "Processing");
    statusMap.put(2, "Shipped");
    statusMap.put(3, "Cancelled");
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    // --- KẾT THÚC LOGIC SCRIPTLET ---
%>

<section class="content-header">
    <h1>
        Sale Management
        <small>Manage order list</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/OverviewServlet"><i class="fa fa-cogs"></i> Home</a></li>
        <li class="active">Sale Management</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            
            <div class="box">
                
                <div class="box-header with-border">
                    
                    <form method="get" action="OrderManagerServlet" class="form-inline" style="margin: 0; display: inline-block;">
                        <div class="form-group" style="margin-right: 5px;">
                            <label for="status_filter">Filter by status: </label>
                            <select name="status" id="status_filter" class="form-control input-sm">
                                <option value="-1" <%= (selectedStatus == -1) ? "selected" : "" %>>All Statuses</option>
                                <%
                                    for (Map.Entry<Integer, String> entry : statusMap.entrySet()) {
                                %>
                                <option value="<%= entry.getKey() %>" <%= (selectedStatus == entry.getKey()) ? "selected" : "" %>>
                                    <%= entry.getValue() %>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-sm btn-default"><i class="fa fa-filter"></i> Filter</button>
                    </form>
                    
                    <div class="box-tools">
                        </div>
                    
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 5%;">ID</th>
                                <th style="width: 20%;">Customer</th>
                                <th style="width: 20%;">Order Date</th>
                                <th style="width: 15%;">Total</th>
                                <th style="width: 20%;">Status</th>
                                <th style="width: 10%;" class="text-center">Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (orders != null && !orders.isEmpty()) {
                                    for (Order o : orders) {
                                        Customer c = customerMap.get(o.getCustomerID());
                                        Double total = orderTotals.get(o.getOrderID());
                                        String customerName = (c != null) ? c.getCustomerName() : "N/A";
                                        String customerPhone = (c != null && c.getPhoneNumber() != null) ? c.getPhoneNumber() : "N/A";
                                        String orderTotalStr = (total != null) ? String.format("$%.2f", total) : "$0.00";
                            %>
                            <tr>
                                <td>#<%= o.getOrderID() %></td>
                                <td>
                                    <strong><%= customerName %></strong>
                                    <br>
                                    <small><%= customerPhone %></small>
                                </td>
                                <td><%= (o.getOrderDate() != null) ? sdf.format(o.getOrderDate()) : "N/A" %></td>
                                <td><%= orderTotalStr %></td>
                                <td>
                                    <select class="form-control order-status" data-id="<%= o.getOrderID() %>">
                                        <%
                                            for (Map.Entry<Integer, String> entry : statusMap.entrySet()) {
                                        %>
                                        <option value="<%= entry.getKey() %>" <%= (o.getStatus() == entry.getKey()) ? "selected" : "" %>>
                                            <%= entry.getValue() %>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                                <td class="text-center">
                                    <a href="orderDetail?orderID=<%= o.getOrderID() %>" class="btn btn-xs btn-info">
                                        <i class="fa fa-eye"></i> View
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center">No orders found.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                </div>
            </div>
    </div>
</section>
<script>
    $(document).ready(function () {
        var originalStatus;
        
        // Dùng .off() để tránh gán sự kiện nhiều lần khi nạp lại trang
        $('body').off('focus', '.order-status').on('focus', '.order-status', function () {
            originalStatus = $(this).val();
        });

        $('body').off('change', '.order-status').on('change', '.order-status', function () {
            var select = $(this);
            var orderId = select.data('id');
            var newStatus = select.val();

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
                    // Thêm hiệu ứng "highlight" khi thành công
                    select.closest('tr').css('background-color', '#dff0d8').delay(500).queue(function(){
                        $(this).css('background-color', '').dequeue();
                    });
                },
                error: function () {
                    alert('Error updating order status!');
                    select.val(originalStatus); // Rollback
                    // Thêm hiệu ứng "lỗi"
                    select.closest('tr').css('background-color', '#f2dede').delay(500).queue(function(){
                        $(this).css('background-color', '').dequeue();
                    });
                }
            });
        });
    });
</script>