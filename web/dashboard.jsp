<%-- 
    Document   : dashborad
    Created on : Nov 3, 2025, 12:32:58 AM
    Author     : ADMIN
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
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.6 -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
        <!-- Morris chart -->
        <link rel="stylesheet" href="plugins/morris/morris.css">
        <!-- jvectormap -->
        <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
        <!-- Date Picker -->
        <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
        <!-- Daterange picker -->
        <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
        <!-- bootstrap wysihtml5 - text editor -->
        <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

        <style>
        /* Căn giữa và tăng cỡ chữ cho bảng Best Sellers */
        #bestSellerBox .table > tbody > tr > td,
        #bestSellerBox .table > thead > tr > th {
            text-align: center;
            vertical-align: middle !important;
            font-size: 15px; 
        }
    </style>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">

            <header class="main-header">
                <!-- Logo -->
                <a href="index2.html" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini"><b>S</b>S</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><b>Shoes</b>Shop</span>
                </a>
                <!-- Header Navbar: style can be found in header.less -->
                <nav class="navbar navbar-static-top">
                    <!-- Sidebar toggle button -->
                    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>

                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">

                            <!-- Giữ lại icon + số thông báo -->
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

                            <!-- Avatar + tên Admin -->
                            <li style="padding:10px;">
                                <img src="dist/img/user2-160x160.jpg" class="user-image" alt="User Image" style="width:25px; height:25px; border-radius:50%;">
                                <span style="color:white; margin-left:5px;">Admin</span>
                            </li>

                            <!-- Icon cài đặt -->
                            <li>
                                <i class="fa fa-gears" style="color:white; font-size:18px; padding:15px;"></i>
                            </li>

                        </ul>
                    </div>
                </nav>

            </header>
            <aside class="main-sidebar">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                        </div>
                        <div class="pull-left info">
                            <p>Admin</p>
                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
                    <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </form>
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <li class="active treeview">
                            <a href="#">
                                <i class="fa fa-cogs"></i> <span>Overview</span>
                            </a>
                        </li>
                        <li class="active treeview">
                            <a href="#">
                                <i class="fa fa-cubes"></i> <span>Product Management</span>
                            </a>
                        </li>
                        <li class="active treeview">
                            <a href="#">
                                <i class="fa fa-cart-arrow-down"></i> <span>Sale Management</span>
                            </a>
                        </li>
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>
            <div class="content-wrapper">
                <section class="content-header">
                    <h1>
                        Overview
                        <small>Statistics & reports</small>
                    </h1>
                </section>

                <!-- Main content -->
                <section class="content">
                    <div class="row">

                        <div class="col-lg-3 col-xs-6">
                            <div class="small-box bg-green">
                                <div class="inner">
                                    <h3>
                                        <fmt:setLocale value="en_US"/>
                                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencyCode="USD"/>
                                    </h3>
                                    <p>Total Revenue</p>
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
                                    <h3><c:out value="${purchasingCustomers}" default="0"/></h3>
                                    <p>Purchasing Customers</p>
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
                                    <h3><c:out value="${itemsSold}" default="0"/></h3>
                                    <p>Items Sold</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-bag"></i>
                                </div>
                                <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>

                    </div>

                    <!-- /.content-wrapper -->
                    <!-- ./wrapper -->

                    <div class="row">
                        <div class="col-md-6">
                            <!-- BAR CHART -->
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
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                            <div class="box box-success">
                                <div class="box-header">
                                    <h3 class="box-title" style="font-size: 25px;">
                                        <i class="fa fa-bell-o"></i> 
                                        Notifications
                                    </h3>
                                </div>
                                <div class="box-body">
                                    <div style="height: 250px; width: 100%;"></div>
                                </div>
                            </div>
                        </div>
                        <!-- Map box -->
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
                        <!-- jQuery 2.2.3 -->
                        <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
                        <!-- Bootstrap 3.3.6 -->
                        <script src="bootstrap/js/bootstrap.min.js"></script>
                        <!-- SlimScroll -->
                        <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
                        <!-- FastClick -->
                        <script src="plugins/fastclick/fastclick.js"></script>
                        <!-- AdminLTE App -->
                        <script src="dist/js/app.min.js"></script>
                        <!-- AdminLTE for demo purposes -->
                        <script src="dist/js/demo.js"></script>

                </section>
            </div>
        </div>
    </body>
</html>

