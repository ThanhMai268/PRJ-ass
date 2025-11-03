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

                <!-- LEFT: single image from pro -->
                <div class="col-sm-8">
                    <div class="product-entry border p-3 text-center">
                        <c:choose>
                            <c:when test="${not empty pro.image}">
                                <img src="<c:out value='${fn:startsWith(pro.image,"http") ? pro.image : (ctx.concat("/images/").concat(pro.image))}'/>"
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
                            
                                        <fmt:formatNumber value="${pro.price}" pattern="#,##0"/><span class="vnd">&#8363;</span>
                                    
                            
                        </p>

                       

                        <!-- Sizes -->
                        <div class="block-26 mb-2">
                            <h4>Size</h4>
                            <ul>
                                <c:forEach var="s" items="${listSize}">
                                    <li><a href="#"><c:out value="${s.sizeValue}"/></a></li>
                                    </c:forEach>
                                    <c:if test="${empty listSize}">
                                    <li><span>Updating...</span></li>
                                    </c:if>
                            </ul>
                        </div>

                        <!-- Colors -->
                        <div class="block-26 mb-4">
                            <h4>Color</h4>
                            <ul>
                                <c:forEach var="cl" items="${listColor}">
                                    <c:choose>
                                        <c:when test="${cl.status == 1}">
                                            <li><a href="#"><c:out value="${cl.colorName}"/></a></li>
                                            </c:when>
                                            <c:otherwise>
                                            <li class="disabled"><span><c:out value="${cl.colorName}"/></span></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${empty listColor}">
                                    <li><span>Updating...</span></li>
                                    </c:if>
                            </ul>
                        </div>

                        <!-- Quantity (HTML nh? c?; không JS) -->
                        <div class="input-group mb-4">
                            <span class="input-group-btn">
                                <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="">
                                    <i class="icon-minus2"></i>
                                </button>
                            </span>
                            <input type="number" id="quantity" name="quantity"
                                   class="form-control input-number"
                                   value="1" min="1" max="100">
                            <span class="input-group-btn ml-1">
                                <button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
                                    <i class="icon-plus2"></i>
                                </button>
                            </span>
                        </div>

                        <!-- Add to cart (gi? nh? c? là link) -->
                        <div class="row">
                            <div class="col-sm-12 text-center">
                                <p class="addtocart">
                                    <a href="${ctx}/cart" class="btn btn-primary btn-addtocart">
                                        <i class="icon-shopping-cart"></i> Add to Cart
                                    </a>
                                </p>
                            </div>
                        </div>

                    </div><!-- /.product-desc -->
                </div><!-- /.col-sm-4 -->

            </div><!-- /.row -->
        </div><!-- /.container -->
    </div><!-- /.colorlib-product -->
    
    <%@ include file="footer.jspf" %>
    <script>
		$(document).ready(function(){

		var quantitiy=0;
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		            
		            $('#quantity').val(quantity + 1);

		          
		            // Increment
		        
		    });

		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
		            if(quantity>0){
		            $('#quantity').val(quantity - 1);
		            }
		    });
		    
		});
	</script>
</html>
