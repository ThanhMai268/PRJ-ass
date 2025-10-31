<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
    <%@ include file="/header.jspf" %>



    <aside id="colorlib-hero">
        <div class="flexslider">
            <ul class="slides">
                <li style="background-image: url(images/img_bg_1.jpg);">
                    <div class="overlay"></div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                <div class="slider-text-inner">
                                    <div class="desc">
                                        <h1 class="head-1">Men's</h1>
                                        <h2 class="head-2">Shoes</h2>
                                        <h2 class="head-3">Collection</h2>
                                        <p class="category"><span>New trending shoes</span></p>
                                        <!--                                                <p><a href="#" class="btn btn-primary">Shop Collection</a></p>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li style="background-image: url(images/img_bg_2.jpg);">
                    <div class="overlay"></div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                <div class="slider-text-inner">
                                    <div class="desc">
                                        <h1 class="head-1">Huge</h1>
                                        <h2 class="head-2">Sale</h2>
                                        <h2 class="head-3"><strong class="font-weight-bold">50%</strong> Off</h2>
                                        <p class="category"><span>Big sale sandals</span></p>
                                        <!--                                                <p><a href="#" class="btn btn-primary">Shop Collection</a></p>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li style="background-image: url(images/img_bg_3.jpg);">
                    <div class="overlay"></div>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3 text-center slider-text">
                                <div class="slider-text-inner">
                                    <div class="desc">
                                        <h1 class="head-1">New</h1>
                                        <h2 class="head-2">Arrival</h2>
                                        <h2 class="head-3">up to <strong class="font-weight-bold">30%</strong> off</h2>
                                        <p class="category"><span>New stylish shoes for men</span></p>
                                        <!--                                                <p><a href="#" class="btn btn-primary">Shop Collection</a></p>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </aside>
    <div class="colorlib-partner">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 offset-sm-2 text-center colorlib-heading colorlib-heading-sm">
                    <h2>Trusted Partners</h2>
                </div>
            </div>
            <div class="row">
                <div class="col partner-col text-center">
                    <a href="Brand?bid=Adidas">
                        <img src="images/brand-1.jpg" class="img-fluid" alt="Brand 1">
                    </a>
                </div>

                <div class="col partner-col text-center">
                    <a href="Brand?bid=Nike">
                        <img src="images/brand-2.jpg" class="img-fluid" alt="Brand 2">
                    </a>
                </div>

                <div class="col partner-col text-center">
                    <a href="Brand?bid=Bitis">
                        <img src="images/brand-3.jpg" class="img-fluid" alt="Brand 3">
                    </a>
                </div>

                <div class="col partner-col text-center">
                    <a href="Brand?bid=Converse">
                        <img src="images/brand-4.jpg" class="img-fluid" alt="Brand 4">
                    </a>
                </div>

                <div class="col partner-col text-center">
                    <a href="Brand?bid=Puma">
                        <img src="images/brand-5.jpg" class="img-fluid" alt="Brand 5">
                    </a>
                </div>
            </div>

        </div>
    </div>
    <!--            <div class="colorlib-intro">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <h2 class="intro">It started with a simple idea: Create quality, well-designed products that I wanted myself.</h2>
                            </div>
                        </div>
                    </div>
                </div>-->
    <!--            <div class="colorlib-product">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6 text-center">
                                <div class="featured">
                                    <a href="#" class="featured-img" style="background-image: url(images/men.jpg);"></a>
                                    <div class="desc">
                                        <h2><a href="#">Shop Men's Collection</a></h2>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 text-center">
                                <div class="featured">
                                    <a href="#" class="featured-img" style="background-image: url(images/women.jpg);"></a>
                                    <div class="desc">
                                        <h2><a href="#">Shop Women's Collection</a></h2>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>-->

    <div class="colorlib-product">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 offset-sm-2 text-center colorlib-heading">

                </div>
            </div>
            <div class="row row-pb-md">

                <c:forEach items="${listPro}" var="p">
                    <div class="col-lg-3 mb-4 text-center">
                        <div class="product-entry border">
                            <a href="<c:url value='/ProductDetail'>
                                   <c:param name='pid' value='${p.id}'/>
                               </c:url>" class="prod-img">
                                <img 
                                    src="<c:url value='images/${p.image}'/>" 
                                    class="img-fluid" 
                                    alt="${p.image}">
                            </a>
                            <div class="desc">
                                <h2>
                                    <a href="<c:url value='/ProductDetail'>
                                           <c:param name='pid' value='${p.id}'/>
                                       </c:url>">
                                        <c:out value="${p.name}"/>
                                    </a>
                                </h2>

                                <!-- PH?N GIÁ + NÚT ADD TO CART -->
                                <div class="d-flex justify-content-center align-items-center">
                                    <span class="price">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0"/><span class="vnd">&#8363;</span>
                                    </span>



                                    <!-- ??i ms-2 -> ml-2 (BS4) -->
<!--                                            <a href="<c:url value='/add-to-cart'><c:param name='id' value='${p.id}'/></c:url>"
                                       class="btn btn-sm btn-outline-primary ml-2"
                                       title="Add to Cart">
                                            <i class="icon-shopping-cart"></i>
                                        </a>-->
                                    </div>

                                </div>
                            </div>
                        </div>
                </c:forEach>

            </div>
            <%@ include file="footer.jspf" %>
            </html>

