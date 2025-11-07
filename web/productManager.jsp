<!DOCTYPE HTML>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="DAO.ProductDAO" %>
<%@ page import="java.util.*" %>
<html>
    <head>
        <title>Footwear - Free Bootstrap 4 Template by Colorlib</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Rokkitt:100,300,400,700" rel="stylesheet">

        <!-- Animate.css -->
        <link rel="stylesheet" href="css/animate.css">
        <!-- Icomoon Icon Fonts-->
        <link rel="stylesheet" href="css/icomoon.css">
        <!-- Ion Icon Fonts-->
        <link rel="stylesheet" href="css/ionicons.min.css">
        <!-- Bootstrap  -->
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <!-- Magnific Popup -->
        <link rel="stylesheet" href="css/magnific-popup.css">

        <!-- Flexslider  -->
        <link rel="stylesheet" href="css/flexslider.css">

        <!-- Owl Carousel -->
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">

        <!-- Date Picker -->
        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <!-- Flaticons  -->
        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

        <!-- Theme style  -->
        <link rel="stylesheet" href="css/style.css">

    </head>
    <body>

        <div class="colorlib-loader"></div>

        <div id="page">
            <nav class="colorlib-nav" role="navigation">
                <div class="top-menu" style="padding:10px !important;">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-7 col-md-9">
                                <div id="colorlib-logo"><a href="index.html">Footwear</a></div>
                            </div>
                            <div class="col-sm-5 col-md-3">
                                <form action="#" class="search-wrap">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sale">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-8 offset-sm-2 text-center">
                                <div class="row">
                                    <div class="owl-carousel2">
                                        <div class="item">
                                            <div class="col">
                                                <h3><a href="#">25% off (Almost) Everything! Use Code: Summer Sale</a></h3>
                                            </div>
                                        </div>
                                        <div class="item">
                                            <div class="col">
                                                <h3><a href="#">Our biggest sale yet 50% off all summer shoes</a></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span><a href="index.html">Admin</a></span> / <span>Product Manager</span></p>
                        </div>
                    </div>
                </div>
            </div>

            <%
                ProductDAO dao = new ProductDAO();
                List<Product> products = (List<Product>) request.getAttribute("products");
                List<String> brands = (List<String>) request.getAttribute("brands");
                String selectedBrand = (String) request.getAttribute("selectedBrand");
            %>

            <div class="colorlib-product" style="padding-top:40px !important;">
                <div class="container">
                    <div class="row row-pb-lg" style="padding-bottom:0 !important;">
                        <div class="row row-pb-lg" style="padding-bottom:0 !important;">
                            <div class="col-md-10 offset-md-1">

                                <div class="product-name d-flex align-items-center justify-content-between" style="background:none !important; flex-wrap: wrap;">

                                    <div class="one-forth text-left px-4" style="display: flex; align-items: center; gap: 10px;">
                                        <form method="get" action="ProductManagerControl" class="d-flex align-items-center">
                                            <select name="brand" class="form-select" style="background:none !important; width:200px; font-size: 16px; margin-left: 10px;">

                                                <option value="all" <%= selectedBrand.equals("all") ? "selected" : "" %>>All Brands</option>
                                                <%
                                                    for(String b : brands) {
                                                %>
                                                <option value="<%=b%>" <%= selectedBrand.equals(b) ? "selected" : "" %>><%=b%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <button type="submit" class="btn btn-sm" style="background-color: #f0f0f0; color: #333; margin-left:5px; font-size: 14px;">Filter</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row row-pb-lg">
                        <div class="product-name d-flex">
                            <div class="one-forth text-left px-4">
                                <span>Product Details</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Price</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Quantity</span>
                            </div>
                            <div class="one-eight text-center">
                                <span>Status</span>
                            </div>
                            <div class="one-eight text-center px-4">
                                <span>Edit</span>
                            </div>
                        </div>
                        <%
                            Map<Integer, Integer> qtyMap = dao.getProductQuantities();
                        %>
                        <%
                            if (products != null) {
                            for (Product p : products) {
                        %>
                        <div class="product-cart d-flex">

                            <div class="one-forth">
                                <div class="product-img" style="background-image: url('images/<%= p.getImage() %>');"></div>
                                <div class="display-tc">
                                    <h3><%= p.getName() %></h3>
                                </div>
                            </div>

                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="price">$<%= p.getPrice() %></span>
                                </div>
                            </div>

                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span><%= qtyMap.get(p.getId()) != null ? qtyMap.get(p.getId()) : 0 %></span>
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <input type="checkbox" class="product-status" 
                                           data-id="<%= p.getId() %>" 
                                           <%= (p.getStatus() == 1) ? "checked" : "" %> />
                                </div>
                            </div>
                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <a href="editProduct?pid=<%= p.getId() %>" class="icon-pencil3" style="font-size: 120%;"></a>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                        %>

                    </div>
                </div>
            </div>
        </div>

        <footer id="colorlib-footer" role="contentinfo" style="padding-top:0px !important;">
            <div class="container">
                <div class="row row-pb-md">


                    <div class="col footer-col">
                        <h4>Contact Information</h4>
                        <ul class="colorlib-footer-links">
                            <li>291 South 21th Street, <br> Suite 721 New York NY 10016</li>
                            <li><a href="tel://1234567920">+ 1235 2355 98</a></li>
                            <li><a href="mailto:info@yoursite.com">info@yoursite.com</a></li>
                            <li><a href="#">yoursite.com</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="copy">
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <p>
                            <span><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></span> 
                            <span class="block">Demo Images: <a href="http://unsplash.co/" target="_blank">Unsplash</a> , <a href="http://pexels.com/" target="_blank">Pexels.com</a></span>
                        </p>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <div class="gototop js-top">
        <a href="#" class="js-gotop"><i class="ion-ios-arrow-up"></i></a>
    </div>

    <!-- jQuery -->
    <script src="js/jquery.min.js"></script>
    <!-- popper -->
    <script src="js/popper.min.js"></script>
    <!-- bootstrap 4.1 -->
    <script src="js/bootstrap.min.js"></script>
    <!-- jQuery easing -->
    <script src="js/jquery.easing.1.3.js"></script>
    <!-- Waypoints -->
    <script src="js/jquery.waypoints.min.js"></script>
    <!-- Flexslider -->
    <script src="js/jquery.flexslider-min.js"></script>
    <!-- Owl carousel -->
    <script src="js/owl.carousel.min.js"></script>
    <!-- Magnific Popup -->
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/magnific-popup-options.js"></script>
    <!-- Date Picker -->
    <script src="js/bootstrap-datepicker.js"></script>
    <!-- Stellar Parallax -->
    <script src="js/jquery.stellar.min.js"></script>
    <!-- Main -->
    <script src="js/main.js"></script>
    <script>
                                    $(document).ready(function () {
                                        $('.product-status').change(function () {
                                            var checkbox = $(this);
                                            var productId = checkbox.data('id');
                                            var status = checkbox.is(':checked') ? 1 : 0;

                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/ProductManagerControl',
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
</body>
</html>
