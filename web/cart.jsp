<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE HTML>
<html>
    <%@ include file="/header.jspf" %>
    



    <c:set var="ctx" value="${pageContext.request.contextPath}" />

    <div class="colorlib-product">
        <div class="container">

            <!-- Steps -->
            <div class="row row-pb-lg">
                <div class="col-md-10 offset-md-1">
                    <div class="process-wrap">
                        <div class="process text-center active">
                            <p><span>01</span></p><h3>Shopping Cart</h3>
                        </div>
                        <div class="process text-center">
                            <p><span>02</span></p><h3>Checkout</h3>
                        </div>
                        <div class="process text-center">
                            <p><span>03</span></p><h3>Order Complete</h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Header row -->
            <div class="row row-pb-lg">
                <div class="col-md-12">
                    <div class="product-name d-flex">
                        <div class="one-forth text-left px-4"><span>Product Details</span></div>
                        <div class="one-eight text-center"><span>Price</span></div>
                        <div class="one-eight text-center"><span>Quantity</span></div>
                        <div class="one-eight text-center"><span>Total</span></div>
                        <div class="one-eight text-center px-4"><span>Remove</span></div>
                    </div>

                    <!-- Empty state -->
                    <c:if test="${empty cartItems}">
                        <div class="text-center py-5">
                            <h4>Your cart is empty</h4>
                            <a href="${ctx}/Home" class="btn btn-primary mt-3">Continue Shopping</a>
                        </div>
                    </c:if>

                    <!-- Items -->
                    <c:forEach var="it" items="${cartItems}">
                        <c:url var="detailUrl" value="/ProductDetail">
                            <c:param name="pid" value="${it.productId}" />
                            <c:param name="colorId" value="${it.colorId}" />
                            <c:param name="sizeId"  value="${it.sizeId}" />
                        </c:url>

                        <div class="product-cart d-flex">
                            <div class="one-forth">
                                <div class="product-img"
                                     style="background-image:url('${ctx}/images/${it.imageUrl}');">
                                </div>
                                <div class="display-tc">
                                    <h3><a href="${detailUrl}"><c:out value="${it.name}" /></a></h3>
                                    <small>
                                        Size: <c:out value="${it.sizeValue}" />
                                        &nbsp;|&nbsp;
                                        Color: <c:out value="${it.colorName}" />
                                    </small>
                                </div>
                            </div>

                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="price"><fmt:formatNumber value="${it.price}" pattern="#,##0"/>₫</span>
                                </div>
                            </div>

                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <form action="${ctx}/Cart" method="post" class="d-inline-block qty-form">
                                        <input type="hidden" name="action"    value="add">
                                        <input type="hidden" name="productId" value="${it.productId}">
                                        <input type="hidden" name="colorId"   value="${it.colorId}">
                                        <input type="hidden" name="sizeId"    value="${it.sizeId}">

                                        <input type="hidden" name="quantity" value="${it.quantity}" min="1" max="999999">

                                        <div class="input-group justify-content-center" style="gap:6px;">
                                            <button type="button" class="btn btn-outline-secondary btn-sm qty-btn" data-step="-1" aria-label="Decrease">−</button>
                                            <!-- chỉ hiển thị -->
                                            <span class="qty-display text-center" style="width:80px; display:inline-block;">${it.quantity}</span>
                                            <button type="button" class="btn btn-outline-secondary btn-sm qty-btn" data-step="1" aria-label="Increase">+</button>
                                        </div>
                                    </form>
                                </div>
                            </div>


                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <span class="price">
                                        <fmt:formatNumber value="${it.subtotal()}" pattern="#,##0"/>₫
                                    </span>
                                </div>
                            </div>

                            <div class="one-eight text-center">
                                <div class="display-tc">
                                    <!-- Remove -->
                                    <form action="${ctx}/Cart" method="post">
                                        <input type="hidden" name="action"    value="remove">
                                        <input type="hidden" name="productId" value="${it.productId}">
                                        <input type="hidden" name="colorId"   value="${it.colorId}">
                                        <input type="hidden" name="sizeId"    value="${it.sizeId}">
                                        <button type="submit" name="action" value="remove"
                                                class="btn btn-link p-0 closed-btn" aria-label="Remove">×</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>

            <!-- Totals + actions -->
            <c:if test="${not empty cartItems}">
                <div class="row row-pb-lg">
                    <div class="col-md-12">
                        <div class="total-wrap">
                            <div class="row">
                                <div class="col-sm-8">
                                    <!-- Clear cart -->
                                    <form action="${ctx}/Cart" method="post">
                                        <input type="hidden" name="action" value="clear">
                                        <button type="submit" class="btn btn-outline-danger">Clear Cart</button>
                                    </form>
                                </div>

                                <div class="col-sm-4 text-center">
                                    <div class="total">
                                        <div class="grand-total">

                                            <p>
                                                <span><strong>Total:</strong></span>
                                                <span><fmt:formatNumber value="${cartTotal}" pattern="#,##0"/>₫</span>
                                            </p>
                                        </div>
                                    </div>
                                    <form action="${ctx}/Checkout" method="get" class="mt-3">
                                        <button type="submit" class="btn btn-primary btn-block">Proceed to Checkout</button>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
    <script>
        document.addEventListener('click', function (e) {
            const btn = e.target.closest('.qty-btn');
            if (!btn)
                return;

            const form = btn.closest('.qty-form');
            const input = form.querySelector('input[name="quantity"]'); // input ẩn
            const display = form.querySelector('.qty-display');         // text hiển thị

            const step = parseInt(btn.dataset.step || '0', 10);
            const min = parseInt(input.min || '1', 10);
            const max = parseInt(input.max || '999999', 10);
            let val = parseInt(input.value || '1', 10);

            const next = Math.max(min, Math.min(max, val + step));
            if (next === val)
                return;

            input.value = String(next);
            if (display)
                display.textContent = String(next); // cập nhật text
            form.submit();
        });
    </script>


    <%@ include file="/footer.jspf" %>
</html>
