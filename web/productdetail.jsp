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
      <!-- LEFT: images -->
      <div class="col-sm-8">
        <div class="owl-carousel">
          <!-- ?nh chính t? pro -->
          <c:if test="${not empty pro.image}">
            <div class="item">
              <div class="product-entry border">
                <a href="#" class="prod-img">
                  <img src="${pro.image}" class="img-fluid" alt="${pro.name}">
                </a>
              </div>
            </div>
          </c:if>

          <!-- N?u chi ti?t có ?nh (tùy DB), duy?t thêm; tránh trùng -->
          <c:set var="imgCSV" value=","/>
          <c:forEach var="pd" items="${listprode}">
            <c:if test="${not empty pd.image}">
              <c:set var="marker" value=",${pd.image},"/>
              <c:if test="${fn:indexOf(imgCSV, marker) == -1}">
                <c:set var="imgCSV" value="${imgCSV}${pd.image},"/>
                <div class="item">
                  <div class="product-entry border">
                    <a href="#" class="prod-img">
                      <img src="${pd.image}" class="img-fluid" alt="${pro.name}">
                    </a>
                  </div>
                </div>
              </c:if>
            </c:if>
          </c:forEach>
        </div>
      </div>

      <!-- RIGHT: info -->
      <div class="col-sm-4">
        <div class="product-desc">
          <h3><c:out value="${pro.name}" /></h3>

          <p class="price">
            <span>
              <c:choose>
                <c:when test="${not empty pro.price}">$<c:out value="${pro.price}" /></c:when>
                <c:otherwise>Contact</c:otherwise>
              </c:choose>
            </span>
            <span class="rate">
              <i class="icon-star-full"></i>
              <i class="icon-star-full"></i>
              <i class="icon-star-full"></i>
              <i class="icon-star-full"></i>
              <i class="icon-star-half"></i>
              (74 Rating)
            </span>
          </p>

          <p><c:out value="${pro.description}" /></p>

          <!-- SIZE & COLOR from listprode (unique) -->
          <div class="size-wrap">
            <!-- Sizes -->
            <div class="block-26 mb-2">
              <h4>Size</h4>
              <ul>
                <c:set var="sizesCSV" value=","/>
                <c:forEach var="pd" items="${listprode}">
                  <c:if test="${not empty pd.size}">
                    <c:set var="marker" value=",${pd.size},"/>
                    <c:if test="${fn:indexOf(sizesCSV, marker) == -1}">
                      <c:set var="sizesCSV" value="${sizesCSV}${pd.size},"/>
                      <li>
                        <a href="#" data-size="${pd.size}"><c:out value="${pd.size}" /></a>
                      </li>
                    </c:if>
                  </c:if>
                </c:forEach>
              </ul>
            </div>

            <!-- Colors -->
            <div class="block-26 mb-4">
              <h4>Color</h4>
              <ul>
                <c:set var="colorsCSV" value=","/>
                <c:forEach var="pd" items="${listprode}">
                  <!-- ?u tiên tên màu n?u có; n?u không dùng cid -->
                  <c:set var="colorLabel">
                    <c:choose>
                      <c:when test="${not empty pd.color}">${pd.color}</c:when>
                      <c:otherwise>Color #<c:out value="${pd.cid}" /></c:otherwise>
                    </c:choose>
                  </c:set>

                  <c:set var="dedupKey">
                    <c:choose>
                      <c:when test="${not empty pd.color}">${pd.color}</c:when>
                      <c:otherwise>${pd.cid}</c:otherwise>
                    </c:choose>
                  </c:set>

                  <c:if test="${not empty dedupKey}">
                    <c:set var="marker" value=",${dedupKey},"/>
                    <c:if test="${fn:indexOf(colorsCSV, marker) == -1}">
                      <c:set var="colorsCSV" value="${colorsCSV}${dedupKey},"/>
                      <li>
                        <a href="#" data-color="${dedupKey}">
                          <c:out value="${colorLabel}" />
                        </a>
                      </li>
                    </c:if>
                  </c:if>
                </c:forEach>
              </ul>
            </div>
          </div>

          <!-- Quantity -->
          <div class="input-group mb-4">
            <span class="input-group-btn">
              <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="">
                <i class="icon-minus2"></i>
              </button>
            </span>
            <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1" min="1" max="100">
            <span class="input-group-btn ml-1">
              <button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
                <i class="icon-plus2"></i>
              </button>
            </span>
          </div>

          <!-- Add to cart (gi? nguyên; có th? ??i sang form n?u c?n truy?n size/color) -->
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
</html>