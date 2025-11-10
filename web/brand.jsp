<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
    <%@ include file="/header.jspf" %>

            <div class="breadcrumbs">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <p class="bread"><span>Home   / ${bid}</span></p>
                        </div>

                        <div class="colorlib-partner">
                            <div class="container">
                                
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
                    </div>
                </div>

                

                <div class="colorlib-product">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-8 offset-sm-2 text-center colorlib-heading colorlib-heading-sm">
                                <!--                            <h2>View All Products</h2>-->
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
                                                    <fmt:formatNumber value="${p.price}" type="currency"/>
                                                </span>

                                                <!-- ??i ms-2 -> ml-2 (BS4) -->
                                                <a href="<c:url value='/add-to-cart'><c:param name='id' value='${p.id}'/></c:url>"
                                                   class="btn btn-sm btn-outline-primary ml-2"
                                                   title="Add to Cart">
                                                        <i class="icon-shopping-cart"></i>
                                                    </a>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>

                        </div>
                        <%@ include file="footer.jspf" %>
</html>

