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

  <!-- Color hi?n t?i: ?u tiên param.color; r?ng l?y firstCid. Ép v? s? ?? so sánh ?n ??nh -->
  <c:set var="selCid"    value="${empty param.color ? firstCid : param.color}"/>
  <c:set var="selCidNum" value="${selCid + 0}"/>

  <!-- 2) Sizes (sid) duy nh?t theo selCid, c?ng dùng marker -->
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

  <!-- Size hi?n t?i: ?u tiên param.size; r?ng l?y firstSid. Ép v? s? ?? so sánh ?n ??nh -->
  <c:set var="selSid"    value="${empty param.size ? firstSid : param.size}"/>
  <c:set var="selSidNum" value="${selSid + 0}"/>

  <!-- 3) Tính stock t?ng cho (selCid, selSid). ? ?ây dùng pd.qid là S? L??NG. N?u qid là FK, thay b?ng tr??ng s? l??ng th?c. -->
  <c:set var="stock" value="0"/>
  <c:forEach var="pd" items="${listprode}">
    <c:if test="${pd.cid == selCidNum && pd.sid == selSidNum}">
      <c:set var="stock" value="${stock + pd.qid}"/>
    </c:if>
  </c:forEach>

  <!-- 4) K?p qty vào [1..stock] -->
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

  <!-- ====== UI: GI? NGUYÊN CLASS CSS C? ====== -->
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
                <!-- N?u có colorMap: ${colorMap[cNum]} -->
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
            <!-- Tính t?n c?a t?ng size ?? disable n?u h?t -->
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
                  <a class="disabled" title="H?t hàng">${s}</a>
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
                    <!-- N?u có sizeMap: ${sizeMap[sNum]} -->
                  </a>
                </c:otherwise>
              </c:choose>
            </li>
          </c:forTokens>
        </c:if>
      </ul>

      <small class="text-muted d-block mt-2">
        <c:choose>
          <c:when test="${stock > 0}">Còn ${stock} s?n ph?m</c:when>
          <c:otherwise>H?t hàng</c:otherwise>
        </c:choose>
      </small>
    </div>
  </div>

  <!-- Quantity: gi? class/id c? ?? JS c?ng/tr? s?n có v?n ch?y -->
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

  <!-- Add to Cart: gi? nguyên class c? -->
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