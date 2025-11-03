<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
    <%@ include file="header.jspf" %>

    <c:set var="ctx" value="${pageContext.request.contextPath}" />

    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col">
                    <p class="bread">
                        <span><a href="${ctx}/Home">Home</a></span> /
                        <span>Product Details</span>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="colorlib-product">
        <div class="container">
            <div class="row row-pb-lg product-detail-wrap">

                <!-- LEFT: image -->
                <div class="col-sm-8">
                    <div class="product-entry border p-3 text-center">
                        <c:choose>
                            <c:when test="${not empty pro.image}">
                                <img src="<c:out value='${fn:startsWith(pro.image, "http") ? pro.image : (ctx.concat("/images/").concat(pro.image))}'/>"
                                     class="img-fluid" alt="${pro.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="${ctx}/images/placeholder.jpg" class="img-fluid" alt="No image">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- RIGHT: info -->
                <div class="col-sm-4">
                    <div class="product-desc">
                        <h3><c:out value="${pro.name}" /></h3>

                        <p class="price">
                            <span>
                                <fmt:formatNumber value="${pro.price}" pattern="#,##0"/>
                                <span class="vnd">&#8363;</span>
                            </span>
                        </p>

                        <div class="block-26 mb-2">
                            <h4>Size</h4>
                            <ul>
                                <c:forEach var="s" items="${listSize}">
                                    <c:set var="activeSize" value="${selectedSizeId == s.sizeID}" />
                                    <c:set var="disabledSize"
                                           value="${ (not empty allowedSizes and not allowedSizes.contains(s.sizeID))
                                                     or (empty allowedSizes and selectedColorId ne null) }" />

                                    <li>
                                        <c:choose>
                                            <c:when test="${disabledSize}">
                                                <span class="disabled"><c:out value="${s.sizeValue}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${selectedColorId ne null}">
                                                        <c:url var="sizeUrl" value="/ProductDetail">
                                                            <c:param name="pid" value="${pro.id}"/>
                                                            <c:param name="sizeId" value="${s.sizeID}"/>
                                                            <c:param name="colorId" value="${selectedColorId}"/>
                                                        </c:url>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url var="sizeUrl" value="/ProductDetail">
                                                            <c:param name="pid" value="${pro.id}"/>
                                                            <c:param name="sizeId" value="${s.sizeID}"/>
                                                        </c:url>
                                                    </c:otherwise>
                                                </c:choose>

                                                <a class="${activeSize ? 'selected' : ''}" href="${sizeUrl}">
                                                    <c:out value="${s.sizeValue}"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>


                        <div class="block-26 mb-4">
                            <h4>Color</h4>
                            <ul>
                                <c:forEach var="cl" items="${listColor}">
                                    <c:set var="activeColor" value="${selectedColorId == cl.colorID}" />
                                    <c:set var="disabledColor"
                                           value="${ (not empty allowedColors and not allowedColors.contains(cl.colorID))
                                                     or (empty allowedColors and selectedSizeId ne null) }" />

                                    <li>
                                        <c:choose>
                                            <c:when test="${disabledColor}">
                                                <span class="disabled"><c:out value="${cl.colorName}"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${selectedSizeId ne null}">
                                                        <c:url var="colorUrl" value="/ProductDetail">
                                                            <c:param name="pid" value="${pro.id}"/>
                                                            <c:param name="sizeId" value="${selectedSizeId}"/>
                                                            <c:param name="colorId" value="${cl.colorID}"/>
                                                        </c:url>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url var="colorUrl" value="/ProductDetail">
                                                            <c:param name="pid" value="${pro.id}"/>
                                                            <c:param name="colorId" value="${cl.colorID}"/>
                                                        </c:url>
                                                    </c:otherwise>
                                                </c:choose>

                                                <a class="${activeColor ? 'selected' : ''}" href="${colorUrl}">
                                                    <c:out value="${cl.colorName}"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>


                        <!-- Quantity + Add to Cart -->
                        <form action="${ctx}/cart/add" method="post">
                            <input type="hidden" name="productId" value="${pro.id}">
                            <input type="hidden" name="sizeId"  value="${selectedSizeId}">
                            <input type="hidden" name="colorId" value="${selectedColorId}">

                            <c:choose>
                                
                                <c:when test="${selectedSizeId != null && selectedColorId != null && currentStock > 0}">
                                    <div class="input-group mb-4">
                                        

                                        
                                        <input type="number" id="quantity" name="quantity"
                                               class="form-control input-number"
                                               value="1" min="1" max="${currentStock}"/>

                                        
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12 text-center">
                                            <p class="addtocart">
                                                
                                                <button type="submit" class="btn btn-primary btn-addtocart">
                                                    <i class="icon-shopping-cart"></i> Add to Cart
                                                </button>
                                            </p>
                                            <div class="mt-2"><small>Stock: ${currentStock}</small></div>
                                        </div>
                                    </div>
                                </c:when>

                                
                                <c:otherwise>
                                    <div class="input-group mb-4">
                                        

                                        <input type="number" id="quantity" name="quantity"
                                               class="form-control input-number"
                                               value="0" min="0" max="0" disabled/>

                                        
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12 text-center">
                                            <p class="addtocart">
                                                <button type="button" class="btn btn-secondary btn-addtocart" disabled>
                                                    <i class="icon-shopping-cart"></i> Choose Size &amp; Color
                                                </button>
                                            </p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="footer.jspf" %>



</html>
