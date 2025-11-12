<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE HTML>
<html>
  <%@ include file="/header.jspf" %>

  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <div class="breadcrumbs">
    <div class="container">
      <div class="row"><div class="col">
        <p class="bread">
          <span><a href="<c:url value='/Home'/>">Home</a></span> /
          <span><a href="<c:url value='/Orders'/>">My Orders</a></span> /
          <span>Order #${order.orderId}</span>
        </p>
      </div></div>
    </div>
  </div>

  <div class="colorlib-product">
    <div class="container">
      <div class="row row-pb-lg">

        <div class="col-lg-8">
          <h2 class="mb-3">Order #${order.orderId}</h2>
          <p class="mb-1"><b>Ngày đặt:</b> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></p>
          <p class="mb-3">
            <b>Trạng thái:</b>
            <c:choose>
              <c:when test="${order.status == 0}"><span class="badge bg-warning text-dark">Pending</span></c:when>
              <c:when test="${order.status == 1}"><span class="badge bg-info text-dark">Processing</span></c:when>
              <c:when test="${order.status == 2}"><span class="badge bg-success">Completed</span></c:when>
              <c:otherwise><span class="badge bg-secondary">Unknown</span></c:otherwise>
            </c:choose>
          </p>

          <c:choose>
            <c:when test="${empty items}">
              <div class="alert alert-info">Đơn hàng này chưa có sản phẩm.</div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table table-bordered align-middle">
                  <thead>
                    <tr>
                      <th>Ảnh</th>
                      <th>Sản phẩm</th>
                      <th>Phân loại</th>
                      <th class="text-end">Đơn giá</th>
                      <th class="text-center">SL</th>
                      <th class="text-end">Thành tiền</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="it" items="${items}">
                      <tr>
                        <td style="width:90px">
                          <c:choose>
                            <c:when test="${empty it.image}">
                              <img src="<c:url value='/images/no-image.png'/>" class="img-fluid" style="max-width:80px; max-height:80px;" alt="no-image">
                            </c:when>
                            <c:otherwise>
                              <img src="<c:url value='/images/${it.image}'/>" class="img-fluid" style="max-width:80px; max-height:80px;" alt="${it.productName}">
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td><c:out value="${it.productName}"/></td>
                        <td><small>Size: ${it.sizeValue} / Color: <c:out value="${it.colorName}"/></small></td>
                        <td class="text-end"><fmt:formatNumber value="${it.price}" pattern="#,##0.##"/><span> ₫</span></td>
                        <td class="text-center">${it.quantity}</td>
                        <td class="text-end"><fmt:formatNumber value="${it.price * it.quantity}" pattern="#,##0.##"/><span> ₫</span></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                  <tfoot>
                    <tr>
                      <th colspan="5" class="text-end">Tổng cộng</th>
                      <th class="text-end"><fmt:formatNumber value="${order.total}" pattern="#,##0.##"/><span> ₫</span></th>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </c:otherwise>
          </c:choose>

          <a class="btn btn-outline-secondary mt-2" href="<c:url value='/Order'/>">← Quay lại danh sách</a>
        </div>

        <div class="col-lg-4">
          <div class="card"><div class="card-body">
            <h5 class="card-title mb-3">Thông tin giao hàng</h5>
            <p class="mb-1"><b>Tên:</b> <c:out value="${order.customerName}"/></p>
            <p class="mb-1"><b>SĐT:</b> <c:out value="${order.phone}"/></p>
            <p class="mb-0"><b>Địa chỉ:</b> <c:out value="${order.address}"/></p>
          </div></div>
        </div>

      </div>
    </div>
  </div>

  <%@ include file="/footer.jspf" %>
</html>
