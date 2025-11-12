<%--
    Document    : dashboard.jsp (FILE CHA)
    Created on  : Nov 3, 2025, 12:32:58 AM
    Author      : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>ShoesShop | Dashboard</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
        <link rel="stylesheet" href="plugins/morris/morris.css">
        <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
        <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
        <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
        <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

        <style>
            /* Căn giữa và tăng cỡ chữ cho bảng Best Sellers */
            #bestSellerBox .table > tbody > tr > td,
            #bestSellerBox .table > thead > tr > th {
                text-align: center;
                vertical-align: middle !important;
                font-size: 15px;
            }
            @media (min-width: 768px) {
                .navbar-nav>li>a {
                    padding-top: 11px;
                    padding-bottom: 15px;
                }
            }
        </style>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <header class="main-header">
                <a href="${pageContext.request.contextPath}/OverviewServlet" class="logo">
                    <span class="logo-mini"><b>S</b>S</span>
                    <span class="logo-lg"><b>Shoes</b>Shop</span>
                </a>
                <nav class="navbar navbar-static-top">
                    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>

                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">

                            <li>
                                <i class="fa fa-envelope-o" style="color:white; font-size:18px; padding:15px; position:relative;">
                                    <span class="label label-success" style="position:absolute; top:8px; right:8px; font-size:10px;">4</span>
                                </i>
                            </li>
                            <li>
                                <i class="fa fa-bell-o" style="color:white; font-size:18px; padding:15px; position:relative;">
                                    <span class="label label-warning" style="position:absolute; top:8px; right:8px; font-size:10px;">10</span>
                                </i>
                            </li>
                            <li>
                                <i class="fa fa-flag-o" style="color:white; font-size:18px; padding:15px; position:relative;">
                                    <span class="label label-danger" style="position:absolute; top:8px; right:8px; font-size:10px;">9</span>
                                </i>
                            </li>

                            <li style="padding:10px;">
                                <img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image" style="width:25px; height:25px; border-radius:50%;">
                                <span style="color:white; margin-left:5px;">Admin</span>
                            </li>

                            <li>
                                <a href="<c:url value='/Logout'/>">
                                    <i class="fa fa-sign-out-alt"></i> Logout
                                </a>
                            </li>

                        </ul>
                    </div>
                </nav>

            </header>
            <aside class="main-sidebar">
                <section class="sidebar">
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Admin</p>
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </form>
                    <ul class="sidebar-menu">

                        <%-- Biến 'pageView' sẽ được set từ Servlet --%>
                        <c:set var="activePage" value="${pageView}" />

                        <%-- 
                           Sử dụng JSTL/EL để kiểm tra 'activePage' và thêm class 'active'
                           (Bỏ 'active treeview' cố định cũ)
                        --%>

                        <li class="${(empty activePage || activePage == 'overview.jsp') ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/OverviewServlet">
                                <i class="fa fa-cogs"></i> <span>Overview</span>
                            </a>
                        </li>
                        <li class="${(activePage == 'productManager.jsp' || activePage == 'addProduct.jsp' || activePage == 'editProduct.jsp') ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/ProductManagerServlet">
                                <i class="fa fa-cubes"></i> <span>Product Management</span>
                            </a>
                        </li>
                        <li class="${(activePage == 'orderManager.jsp' || activePage == 'orderDetail.jsp') ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/OrderManagerServlet"> 
                                <i class="fa fa-cart-arrow-down"></i> <span>Sale Management</span>
                            </a>
                        </li>
                    </ul>
                </section>
            </aside>

            <div class="content-wrapper">

                <%-- 
                  Kiểm tra xem Servlet có set 'pageView' không.
                  Nếu có, nạp trang đó.
                  Nếu không (lần đầu vào trang), nạp 'overview.jsp' làm mặc định.
                --%>
                <c:choose>
                    <c:when test="${not empty pageView}">
                        <jsp:include page="${pageView}" />
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="overview.jsp" />
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
        <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
        <script src="plugins/fastclick/fastclick.js"></script>
        <script src="dist/js/app.min.js"></script>
        <script src="dist/js/demo.js"></script>
    </body>
</html>