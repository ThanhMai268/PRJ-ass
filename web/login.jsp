<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign In / Sign Up</title>

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,800" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<c:url value='/css/login.css'/>">

    </head>
    <body>

        <!--<h2>Weekly Coding Challenge #1: Sign in/up Form</h2>-->
        <c:if test="${param.errorAddToCart == '1'}">
            <div id="toast" class="toast error"> You must log in before adding products to your cart.</div>
        </c:if>

        <c:if test="${not empty successSignup}">
            <div id="toast" class="toast">${successSignup}</div>
        </c:if>
            
        <c:if test="${not empty errorSignup}">
            <div id="toast" class="toast error">${errorSignup}</div>
        </c:if>
            
        <c:if test="${not empty errorLogin}">
            <div id="toast" class="toast error">${errorLogin}</div>
        </c:if>
        <div class="container" id="container">
            <!-- FORM ĐĂNG KÝ -->
            <div class="form-container sign-up-container">
                <form action="Signup" method="post">
                    <h1>Create Account</h1>

                    <span>or use your email for registration</span>

                    <input type="text"
                           id="email"
                           name="email"
                           placeholder="Email"
                           required
                           pattern="^(admin|[^\s@]+@[^\s@]+\.[^\s@]+)$"
                           title="Nhập email hợp lệ (ví dụ: name@example.com)" />
                    <input type="password" name="pass" placeholder="Password" />
                    <button type="submit">Sign Up</button>
                </form>
            </div>

            <!-- FORM ĐĂNG NHẬP -->
            <div class="form-container sign-in-container">
                <form action="Login" method="post" id="loginForm">
                    <h1>Sign in</h1>
                    <span>or use your account</span>
                    <!-- HIỂN THỊ THÔNG BÁO LỖI -->

                    <!-- CHÚ Ý: type="text" + pattern cho phép 'admin' hoặc email -->
                    <input type="text"
                           id="email"
                           name="email"
                           placeholder="Email"
                           required
                           pattern="^(admin|[^\s@]+@[^\s@]+\.[^\s@]+)$"
                           title="Nhập email hợp lệ (ví dụ: name@example.com)" />

                    <input type="password" name="pass" placeholder="Password" required />
                    <button type="submit">Sign In</button>
                </form>
            </div>

            <!-- OVERLAY -->
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>To keep connected with us please login with your personal info</p>
                        <button class="ghost" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Hello, Friend!</h1>
                        <p>Enter your personal details and start journey with us</p>
                        <button class="ghost" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>



        <script>
            // Nếu servlet gửi flag stayOnSignup = true
            <% Boolean stayOnSignup = (Boolean) request.getAttribute("stayOnSignup"); %>
            <% if (stayOnSignup != null && stayOnSignup) { %>
            document.addEventListener('DOMContentLoaded', function () {
                const container = document.getElementById('container');
                container.classList.add('right-panel-active'); // 👈 bật lại tab Sign Up
            });
            <% } %>
        </script>
        <script src="<c:url value='/js/login.js'/>"></script>
    </body>
</html>
