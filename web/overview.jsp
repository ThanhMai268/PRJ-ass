<%--
    Document    : overview.jsp (FILE CON)
    Created on  : Nov 8, 2025
    Author      : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<section class="content-header">
    <h1>
        Overview
        <small>Statistics & reports</small>
    </h1>
</section>

<section class="content">
    <div class="row">

        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>
                        <fmt:setLocale value="en_US"/>
                        <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencyCode="USD"/>
                    </h3>
                    <p>Monthly Revenue</p>
                </div>
                <div class="icon">
                    <i class="ion ion-stats-bars"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3><c:out value="${monthlyOrders}" default="0"/></h3>
                    <p>Monthly Orders</p>
                </div>
                <div class="icon">
                    <i class="ion ion-bag"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3><c:out value="${monthlyCustomers}" default="0"/></h3>
                    <p>Monthly Customers</p>
                </div>
                <div class="icon">
                    <i class="ion ion-person-add"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>

        <div class="col-lg-3 col-xs-6">
            <div class="small-box bg-red">
                <div class="inner">
                    <h3><c:out value="${monthlyItemsSold}" default="0"/></h3>
                    <p>Monthly Items Sold</p>
                </div>
                <div class="icon">
                    <i class="ion ion-bag"></i>
                </div>
                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>

    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="box box-success">
                <div class="box-header with-border">
                    <h3 class="box-title" style="font-size: 25px;">
                        <i class="fa fa-bar-chart"></i> 
                        Bar Chart
                    </h3>
                </div>
                <div class="box-body">
                    <div class="chart">
                        <canvas id="barChart" style="height:230px"></canvas>
                    </div>
                </div>
            </div>
            <div class="box box-success">
                <div class="box-header">
                    <h3 class="box-title" style="font-size: 25px;">
                        <i class="fa fa-bell-o"></i> 
                        Notifications
                    </h3>
                </div>
                <div class="box-body" style="height: 250px; width: 100%; overflow-y: auto;">

                    <c:if test="${empty notificationList}">
                        <p style="padding: 10px; color: #777;">Không có thông báo mới.</p>
                    </c:if>

                    <ul style="list-style-type: none; padding-left: 10px;">
                        <c:forEach var="noti" items="${notificationList}">
                            <li style="padding: 8px 0; border-bottom: 1px solid #f4f4f4;">
                                <fmt:formatNumber value="${noti.totalValue}" type="currency" currencySymbol="" minFractionDigits="0" var="formattedTotal" />

                                <i class="fa fa.fa-shopping-cart text-green"></i> 
                                Bạn vừa có đơn hàng mới từ <strong>${noti.customerName}</strong>
                                có mã đơn hàng <strong>#${noti.orderId}</strong>
                                với tổng giá trị <strong>${formattedTotal}đ</strong>.
                            </li>
                        </c:forEach>
                    </ul>

                </div>
            </div>
        </div>
        <div class="col-md-6">

            <div class="box box-solid bg-aqua" id="bestSellerBox">

                <div class="box-header">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm pull-right" data-widget="collapse" data-toggle="tooltip" title="Collapse" style="margin-right: 5px;">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                    <i class="fa ion-ribbon-b"></i>

                    <h3 class="box-title" style="font-size: 40px; font-weight: bool;">
                        Best Sellers
                    </h3>
                </div>

                <div class="box-body no-padding">

                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 100px; font-size: 18px">#</th>
                                <th style="width: 100px; font-size: 18px">Image</th>
                                <th style="font-size: 18px">Product Name</th>
                                <th style="font-size: 18px">Sold</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${bestSellers}" varStatus="loop">
                                <tr>
                                    <td style="font-size: 20px;">#${loop.count}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/images/${item.imageUrl}" alt="Ảnh" style="width: 50px; height: 50px; object-fit: cover;">
                                    </td>
                                    <td>${item.name}</td>
                                    <td style="font-size: 20px;">${item.sold}</td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty bestSellers}">
                                <tr>
                                    <td colspan="4" class="text-center">Chưa có sản phẩm bán chạy.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

        <script>
            // 1. Lấy dữ liệu từ Servlet (Phần này đã đúng)
            var jsChartLabels = [
            <c:forEach var="label" items="${chartLabels}" varStatus="loop">
            "${label}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            var jsChartValues = [
            <c:forEach var="value" items="${chartValues}" varStatus="loop">
                ${value}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            // 2. SỬA LỖI:
            // Bỏ $(function() {...}) và dùng JS thuần để lấy canvas.
            // Script này nằm sau thẻ <canvas> nên nó có thể thấy 'barChart' ngay.
            var barChartCanvas = document.getElementById('barChart').getContext('2d');

            // 3. Định nghĩa dữ liệu (Giữ nguyên)
            var barChartData = {
                labels: jsChartLabels, // Dữ liệu nhãn (trục X)
                datasets: [
                    {
                        label: 'Sản phẩm bán ra',
                        backgroundColor: 'rgba(92, 184, 92, 0.8)', // Màu xanh lá
                        borderColor: 'rgba(92, 184, 92, 1)',
                        borderWidth: 1,
                        data: jsChartValues // Dữ liệu số (trục Y)
                    }
                ]
            };

            // 4. Tùy chọn cho biểu đồ (Giữ nguyên)
            var barChartOptions = {
                maintainAspectRatio: false,
                responsive: true,
                legend: {
                    display: false // Ẩn chú thích (vì chỉ có 1 bộ dữ liệu)
                },
                scales: {
                    xAxes: [{
                            gridLines: {display: false}
                        }],
                    yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                // Chỉ hiển thị số nguyên trên trục Y
                                callback: function (value) {
                                    if (Number.isInteger(value)) {
                                        return value;
                                    }
                                }
                            }
                        }]
                }
            };

            // 5. Tạo biểu đồ (Giữ nguyên)
            new Chart(barChartCanvas, {
                type: 'bar',
                data: barChartData,
                options: barChartOptions
            });

        </script>

    </div>
</section>