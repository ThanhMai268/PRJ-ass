<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="colorlib-nav" role="navigation">
  <div class="top-menu">
    <div class="container">
      <div class="row">
        <div class="col-sm-7 col-md-9">
          <div id="colorlib-logo"><a href="index.jsp">Footwear</a></div>
        </div>
        <div class="col-sm-5 col-md-3">
          <form action="search" method="get" class="search-wrap">
            <div class="form-group">
              <input type="search" name="key" class="form-control search" placeholder="Search">
              <button class="btn btn-primary submit-search text-center" type="submit"><i class="icon-search"></i></button>
            </div>
          </form>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-12 text-left menu-1">
          <ul>
            <li class="active"><a href="index.jsp">Home</a></li>
            <li class="has-dropdown">
              <a href="category">Shoe brands</a>
              <ul class="dropdown">
                <li><a href="category?cid=1">Nike</a></li>
                <li><a href="category?cid=2">Adidas</a></li>
                <li><a href="category?cid=3">New Balance</a></li>
                <li><a href="category?cid=4">Merrell</a></li>
                <li><a href="category?cid=5">Puma</a></li>
              </ul>
            </li>
            <li class="cart"><a href="cart.jsp"><i class="icon-shopping-cart"></i> Cart [0]</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</nav>
