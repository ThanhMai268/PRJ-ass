<%--
    Document    : productManager.jsp (FILE CON - Giao diện AdminLTE)
    Author      : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="DAO.ProductDAO" %>
<%@ page import="java.util.*" %>

<%
    ProductDAO dao = new ProductDAO();
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<String> brands = (List<String>) request.getAttribute("brands");
    String selectedBrand = (String) request.getAttribute("selectedBrand");
    Map<Integer, Integer> qtyMap = dao.getProductQuantities();
%>

<section class="content-header">
    <h1>
        Product Management
        <small>Manage product list</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/OverviewServlet"><i class="fa fa-cogs"></i> Home</a></li>
        <li class="active">Product Management</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">

            <div class="box">
                <div class="box-header with-border">

                    <form method="get" action="ProductManagerServlet" class="form-inline" style="margin: 0; display: inline-block;">
                        <div class="form-group" style="margin-right: 5px;">
                            <select name="brand" class="form-control input-sm">

                                <option value="all" <%= "all".equals(selectedBrand) ? "selected" : "" %>>All Brands</option>
                                <%
                                    if (brands != null) {
                                        for(String b : brands) {
                                %>
                                <option value="<%=b%>" <%= b.equals(selectedBrand) ? "selected" : "" %>><%=b%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-sm btn-default"><i class="fa fa-filter"></i> Filter</button>
                    </form>

                    <div class="box-tools">
                        <a href="AddProductServlet" class="btn btn-sm btn-success">
                            <i class="fa fa-plus"></i> Add Product
                        </a>
                    </div>

                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 10%;">Image</th>
                                <th>Product Details</th>
                                <th style="width: 15%;">Price</th>
                                <th style="width: 10%;">Quantity</th>
                                <th style="width: 10%;">Status (Active)</th>
                                <th style="width: 10%;">Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (products != null && !products.isEmpty()) {
                                    for (Product p : products) {
                            %>
                            <tr>
                                <td>
                                    <img src="images/<%= p.getImage() %>" alt="<%= p.getName() %>" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
                                </td>
                                <td><%= p.getName() %></td>
                                <td><%= p.getPrice() %>đ</td>
                                <td class="text-center">
                                    <%= qtyMap.get(p.getId()) != null ? qtyMap.get(p.getId()) : 0 %>
                                </td>
                                <td class="text-center">
                                    <input type="checkbox" class="product-status" 
                                           data-id="<%= p.getId() %>" 
                                           <%= (p.getStatus() == 1) ? "checked" : "" %> 
                                           style="transform: scale(1.3);">
                                </td>
                                <td class="text-center">
                                    <a href="editProduct?pid=<%= p.getId() %>" class="btn btn-xs btn-primary">
                                        <i class="fa fa-pencil"></i> Edit
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center">No products found.</td>
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
<script src="${pageContext.request.contextPath}/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/fastclick/fastclick.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/app.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/demo.js"></script>                 

<script>
    $(document).ready(function () {

    // Dùng .off() để tránh việc gán sự kiện nhiều lần khi nạp lại trang
    $('body').off('change', '.product-status').on('change', '.product-status', function () {
    var checkbox = $(this);
    var productId = checkbox.data('id');
    var status = checkbox.is(':checked') ? 1 : 0;
    $.ajax({
    url: '${pageContext.request.contextPath}/ProductManagerServlet',
            type: 'POST',
            data: {productId: productId, status: status},
            success: function (response) {
            console.log('Updated product ' + productId + ' to status ' + status);
                },
                error: function () {
                    alert('Error updating product status!');
                    checkbox.prop('checked', !checkbox.is(':checked')); // rollback
                }
            });
        });
    });
</script>