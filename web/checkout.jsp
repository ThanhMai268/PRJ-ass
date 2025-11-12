<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
  <%@ include file="/header.jspf" %>

  <c:set var="ctx" value="${pageContext.request.contextPath}" />

  <!-- Breadcrumbs -->
  <div class="breadcrumbs">
    <div class="container">
      <div class="row">
        <div class="col">
          <p class="bread">
            <span><a href="${ctx}/Home">Home</a></span> /
            <span>Checkout</span>
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="colorlib-product">
    <div class="container">

      <!-- Steps -->
      <div class="row row-pb-lg">
        <div class="col-sm-10 offset-md-1">
          <div class="process-wrap">
            <div class="process text-center active">
              <p><span>01</span></p>
              <h3>Shopping Cart</h3>
            </div>
            <div class="process text-center active">
              <p><span>02</span></p>
              <h3>Checkout</h3>
            </div>
            <div class="process text-center">
              <p><span>03</span></p>
              <h3>Order Complete</h3>
            </div>
          </div>
        </div>
      </div>

      <!-- Main -->
      <div class="row">
        <!-- LEFT: Billing details -->
        <div class="col-lg-8">
          <c:choose>
            <c:when test="${empty cartItems}">
              <div class="alert alert-warning">
                Your cart is empty. <a href="${ctx}/Cart">Go back to Cart</a>.
              </div>
            </c:when>
            <c:otherwise>
              <form action="${ctx}/PlaceOrder" method="post" class="colorlib-form">
                <h2>Billing Details</h2>

                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="fname">First Name</label>
                      <input type="text" id="fname" name="firstName" class="form-control" placeholder="Your firstname" required>
                    </div>
                  </div>

                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="lname">Last Name</label>
                      <input type="text" id="lname" name="lastName" class="form-control" placeholder="Your lastname" required>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div class="form-group">
                      <label for="address">Address</label>
                      <input type="text" id="address" name="address" class="form-control" placeholder="Enter Your Address" required>
                    </div>
                  </div>

                  <div class="col-md-6">
                    <div class="form-group">
                      <label for="phone">Phone Number</label>
                      <input type="text" id="phone" name="phone" class="form-control" placeholder="" required>
                    </div>
                  </div>
                </div>

                <!-- Place Order (desktop: b?n c?ng có nút bên ph?i; ?? ?? phòng mobile) -->
                <div >
                  <div class="col-12 text-center">
                    <button type="submit" class="btn btn-primary">Place an order</button>
                  </div>
                </div>
              </form>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- RIGHT: Cart total -->
        <div class="col-lg-4">
          <div class="row">
            <div class="col-md-12">
              <div class="cart-detail">
                <h2>Cart Total</h2>

                <c:choose>
                  <c:when test="${empty cartItems}">
                    <p>No items.</p>
                  </c:when>
                  <c:otherwise>
                    <ul>
                      <li>


                        <!-- list items -->
                        <ul>
                          <c:forEach var="it" items="${cartItems}">
                            <li class="d-flex justify-content-between">
                              <span>
                                ${it.quantity} x
                                <c:out value="${it.name}"/>
                                <small>
                                  (<c:out value="${it.sizeValue}"/> /
                                   <c:out value="${it.colorName}"/>)
                                </small>
                              </span>
                              <span>
                                <fmt:formatNumber value="${it.subtotal()}" pattern="#,##0"/>
                                <span class="vnd">&#8363;</span>
                              </span>
                            </li>
                          </c:forEach>
                        </ul>
                      </li>

                      

                      <li class="d-flex justify-content-between">
                        <span>Order Total</span>
                        <span>
                          <fmt:formatNumber value="${cartTotal}" pattern="#,##0"/>
                          <span class="vnd">&#8363;</span>
                        </span>
                      </li>
                    </ul>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>

            <div class="w-100"></div>

            <!-- Place order button (bên ph?i) -->
            <div class="col-md-12 text-center">

              <c:if test="${empty cartItems}">
                <a href="${ctx}/Cart" class="btn btn-secondary">Back to Cart</a>
              </c:if>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <%@ include file="footer.jspf" %>
</html>
