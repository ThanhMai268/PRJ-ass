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
                        <span>My Orders</span>
                    </p>
                </div></div>
        </div>
    </div>

    <div class="colorlib-product">
        <div class="container">
            <div class="row row-pb-lg">
                <div class="col-md-12">
                    <h2 class="mb-3">My Orders</h2>

                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>
                            <a class="btn btn-primary" href="<c:url value='/Home'/>">Tiếp tục mua sắm</a>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead>
                                        <tr>
                                            <th>#Order</th>
                                            <th>Ngày đặt</th>
                                            <th>Trạng thái</th>
                                            <th class="text-end">Tổng tiền</th>
                                            <th class="text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${orders}" varStatus="st">
                                            <tr>
                                                <td><strong>${st.index + 1}</strong></td> <!-- STT: 1,2,3,... -->
                                                <td><fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${o.status == 1}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                                        <c:when test="${o.status == 0}"><span class="badge bg-info text-dark">Processing</span></c:when>
                                                        <c:when test="${o.status == 2}"><span class="badge bg-success">Completed</span></c:when>
                                                        <c:otherwise><span class="badge bg-secondary">Unknown</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <fmt:formatNumber value="${o.total}" pattern="#,##0.##"/><span> ₫</span>
                                                </td>
                                                <td class="text-center">
                                                    <a class="btn btn-sm btn-outline-primary"
                                                       href="<c:url value='/ViewOrderDetail'><c:param name='id' value='${o.orderId}'/></c:url>">
                                                           Xem chi tiết
                                                       </a>
                                                    </td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>

                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/footer.jspf" %>
</html>
