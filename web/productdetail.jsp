<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html>
    <%@ include file="header.jspf" %>


  <!-- ====== Chu?n b? d? li?u t? listprode: colors, sizes, stock, qty ====== -->
  <!-- 1) Colors (cid) duy nh?t b?ng k? thu?t marker ",<cid>," -->
  <c:set var="colorsCSV" value=","/>
  <c:set var="firstCid"  value=""/>
  <c:forEach var="pd" items="${listprode}">
    <c:set var="marker" value=",${pd.cid},"/>
    <c:if test="${fn:indexOf(colorsCSV, marker) == -1}">
      <c:set var="colorsCSV" value="${colorsCSV}${pd.cid},"/>
      <c:if test="${empty firstCid}">
        <c:set var="firstCid" value="${pd.cid}"/>
      </c:if>
    </c:if>
  </c:forEach>

  <!-- Color hi?n t?i: ?u ti�n param.color; r?ng l?y firstCid. �p v? s? ?? so s�nh ?n ??nh -->
  <c:set var="selCid"    value="${empty param.color ? firstCid : param.color}"/>
  <c:set var="selCidNum" value="${selCid + 0}"/>

  <!-- 2) Sizes (sid) duy nh?t theo selCid, c?ng d�ng marker -->
  <c:set var="sizesCSV" value=","/>
  <c:set var="firstSid" value=""/>
  <c:forEach var="pd" items="${listprode}">
    <c:if test="${pd.cid == selCidNum}">
      <c:set var="sMarker" value=",${pd.sid},"/>
      <c:if test="${fn:indexOf(sizesCSV, sMarker) == -1}">
        <c:set var="sizesCSV" value="${sizesCSV}${pd.sid},"/>
        <c:if test="${empty firstSid}">
          <c:set var="firstSid" value="${pd.sid}"/>
        </c:if>
      </c:if>
    </c:if>
  </c:forEach>

  <!-- Size hi?n t?i: ?u ti�n param.size; r?ng l?y firstSid. �p v? s? ?? so s�nh ?n ??nh -->
  <c:set var="selSid"    value="${empty param.size ? firstSid : param.size}"/>
  <c:set var="selSidNum" value="${selSid + 0}"/>

  <!-- 3) T�nh stock t?ng cho (selCid, selSid). ? ?�y d�ng pd.qid l� S? L??NG. N?u qid l� FK, thay b?ng tr??ng s? l??ng th?c. -->
  <c:set var="stock" value="0"/>
  <c:forEach var="pd" items="${listprode}">
    <c:if test="${pd.cid == selCidNum && pd.sid == selSidNum}">
      <c:set var="stock" value="${stock + pd.qid}"/>
    </c:if>
  </c:forEach>

  <!-- 4) K?p qty v�o [1..stock] -->
  <c:set var="qtyReq" value="${empty param.qty ? 1 : param.qty}"/>
  <c:choose>
    <c:when test="${stock <= 0}">
      <c:set var="qty" value="1"/>
    </c:when>
    <c:when test="${qtyReq > stock}">
      <c:set var="qty" value="${stock}"/>
    </c:when>
    <c:when test="${qtyReq < 1}">
      <c:set var="qty" value="1"/>
    </c:when>
    <c:otherwise>
      <c:set var="qty" value="${qtyReq}"/>
    </c:otherwise>
  </c:choose>

  <!-- ====== UI: GI? NGUY�N CLASS CSS C? ====== -->
  <div class="size-wrap">
    <!-- COLOR -->
    <div class="block-26 mb-2">
      <h4>Color</h4>
      <ul>
        <c:if test="${fn:length(colorsCSV) > 1}">
          <c:forTokens var="c" items="${fn:substring(colorsCSV, 1, fn:length(colorsCSV)-1)}" delims=",">
            <c:set var="cNum" value="${c + 0}"/>
            <c:set var="active" value="${cNum == selCidNum}"/>
            <li>
              <a class="${active ? 'active' : ''}"
                 href="<c:url value='/ProductDetail'>
                          <c:param name='pid' value='${pro.id}'/>
                          <c:param name='color' value='${c}'/>
                          <c:param name='size'  value='${selSid}'/>
                          <c:param name='qty'   value='${qty}'/>
                        </c:url>">
                ${c}
                <!-- N?u c� colorMap: ${colorMap[cNum]} -->
              </a>
            </li>
          </c:forTokens>
        </c:if>
      </ul>
    </div>

    <!-- SIZE -->
    <div class="block-26 mb-4">
      <h4>Size</h4>
      <ul>
        <c:if test="${fn:length(sizesCSV) > 1}">
          <c:forTokens var="s" items="${fn:substring(sizesCSV, 1, fn:length(sizesCSV)-1)}" delims=",">
            <c:set var="sNum" value="${s + 0}"/>
            <!-- T�nh t?n c?a t?ng size ?? disable n?u h?t -->
            <c:set var="sStock" value="0"/>
            <c:forEach var="pd" items="${listprode}">
              <c:if test="${pd.cid == selCidNum && pd.sid == sNum}">
                <c:set var="sStock" value="${sStock + pd.qid}"/>
              </c:if>
            </c:forEach>

            <c:set var="isActive"   value="${sNum == selSidNum}"/>
            <c:set var="isDisabled" value="${sStock == 0}"/>

            <li>
              <c:choose>
                <c:when test="${isDisabled}">
                  <a class="disabled" title="H?t h�ng">${s}</a>
                </c:when>
                <c:otherwise>
                  <a class="${isActive ? 'active' : ''}"
                     href="<c:url value='/ProductDetail'>
                              <c:param name='pid' value='${pro.id}'/>
                              <c:param name='color' value='${selCid}'/>
                              <c:param name='size'  value='${s}'/>
                              <c:param name='qty'   value='${qty}'/>
                            </c:url>">
                    ${s}
                    <!-- N?u c� sizeMap: ${sizeMap[sNum]} -->
                  </a>
                </c:otherwise>
              </c:choose>
            </li>
          </c:forTokens>
        </c:if>
      </ul>

      <small class="text-muted d-block mt-2">
        <c:choose>
          <c:when test="${stock > 0}">C�n ${stock} s?n ph?m</c:when>
          <c:otherwise>H?t h�ng</c:otherwise>
        </c:choose>
      </small>
    </div>
  </div>

  <!-- Quantity: gi? class/id c? ?? JS c?ng/tr? s?n c� v?n ch?y -->
  <div class="input-group mb-4">
    <span class="input-group-btn">
      <a class="quantity-left-minus btn" href="<c:url value='/ProductDetail'>
             <c:param name='pid' value='${pro.id}'/>
             <c:param name='color' value='${selCid}'/>
             <c:param name='size'  value='${selSid}'/>
             <c:param name='qty'   value='${qty-1}'/>
           </c:url>">
        <i class="icon-minus2"></i>
      </a>
    </span>

    <input type="text" id="quantity" name="quantity"
           class="form-control input-number"
           value="${qty}" min="1" max="${stock > 0 ? stock : 1}">

    <span class="input-group-btn ml-1">
      <a class="quantity-right-plus btn" href="<c:url value='/ProductDetail'>
             <c:param name='pid' value='${pro.id}'/>
             <c:param name='color' value='${selCid}'/>
             <c:param name='size'  value='${selSid}'/>
             <c:param name='qty'   value='${qty+1}'/>
           </c:url>">
        <i class="icon-plus2"></i>
      </a>
    </span>
  </div>

  <!-- Add to Cart: gi? nguy�n class c? -->
  <div class="row">
    <div class="col-sm-12 text-center">
      <p class="addtocart">
        <a href="<c:url value='/add-to-cart'>
                   <c:param name='id'   value='${pro.id}'/>
                   <c:param name='color' value='${selCid}'/>
                   <c:param name='size'  value='${selSid}'/>
                   <c:param name='qty'   value='${qty}'/>
                 </c:url>"
           class="btn btn-primary btn-addtocart ${stock <= 0 ? 'disabled' : ''}">
          <i class="icon-shopping-cart"></i> Add to Cart
        </a>
      </p>
    </div>
  </div>

  <%@ include file="footer.jspf" %>
</html>

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
                        <form action="${ctx}/Cart" method="post">
                            <input type="hidden" name="action"  value="add">
                            <input type="hidden" name="productId" value="${pro.id}">
                            <input type="hidden" name="sizeId"    value="${selectedSizeId}">
                            <input type="hidden" name="colorId"   value="${selectedColorId}">

                            <c:set var="canAdd" value="${selectedSizeId != null && selectedColorId != null && currentStock > 0}"/>

                            <c:choose>
                                <c:when test="${canAdd}">
                                    <div class="input-group mb-4">
                                        <input type="number" name="quantity" class="form-control input-number"
                                               value="1" min="1" max="${currentStock}" required>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary btn-addtocart">
                                            <i class="icon-shopping-cart"></i> Add to Cart
                                        </button>
                                        <div class="mt-2"><small>Stock: ${currentStock}</small></div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="input-group mb-4">
                                        <input type="number" class="form-control input-number" value="0" min="0" max="0" disabled>
                                    </div>
                                    <div class="text-center">
                                        <button type="button" class="btn btn-secondary" disabled>
                                            <i class="icon-shopping-cart"></i> Choose Size &amp; Color
                                        </button>
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

