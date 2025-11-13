<%--
    Document    : editProduct.jsp (FILE CON - Giao diện AdminLTE)
    Author      : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section class="content-header">
    <h1>
        Edit Product
        <small>Update product details</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/OverviewServlet"><i class="fa fa-cogs"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/ProductManagerServlet">Product Management</a></li>
        <li class="active">Edit Product</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">

            <div class="box box-warning"> 
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Product Information</h3>
                </div>

                <form role="form" action="editProduct" method="post">
                    <div class="box-body">

                        <input type="hidden" name="product_id" value="${productToEdit.id}" />

                        <div class="form-group">
                            <label for="product_name">Name</label>
                            <input type="text" class="form-control" id="product_name" name="product_name" 
                                   value="${productToEdit.name}" required>
                        </div>

                        <div class="form-group">
                            <label for="product_image_url">Image link</label>
                            <input type="text" class="form-control" id="product_image_url" name="product_image_url" 
                                   value="${productToEdit.image}">
                        </div>

                        <div class="form-group">
                            <label for="product_price">Price</label>
                            <input type="number" step="0.01" class="form-control" id="product_price" name="product_price" 
                                   value="${productToEdit.price}" min="0" required>
                        </div>

                        <div class="form-group">
                            <label for="brand">Brand</label>
                            <select name="brand_name" id="brand" class="form-control" required>
                                <option value="">Select Brand</option>
                                <c:forEach var="brand" items="${brandList}">
                                    <option value="${brand}" ${brand == productToEdit.brand ? 'selected' : ''}>
                                        ${brand}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="category">Category</label>
                            <select name="category_name" id="category" class="form-control" required>
                                <option value="">Select Category</option>
                                <c:forEach var="cat" items="${categoryList}">
                                    <option value="${cat}" ${cat == productToEdit.category ? 'selected' : ''}>
                                        ${cat}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div class="box-footer">
                        <button type="submit" class="btn btn-warning">Save</button>
                        <a href="DeleteProductServlet?pid=${productToEdit.id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to PERMANENTLY DELETE this product? All related order data will also be deleted.');">Delete</a>
                        <a href="ProductManagerServlet" class="btn btn-default pull-right">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

