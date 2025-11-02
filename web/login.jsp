<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign In / Sign Up</title>

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,800" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

    </head>
    <body>

        <!--<h2>Weekly Coding Challenge #1: Sign in/up Form</h2>-->

        <div class="container" id="container">
            <!-- FORM ĐĂNG KÝ -->
            <div class="form-container sign-up-container">
                <form action="#">
                    <h1>Create Account</h1>
                    <!--            <div class="social-container">
                                    <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                                    <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                                </div>-->
                    <span>or use your email for registration</span>
                    <input type="text" placeholder="Name" />
                    <input type="email" placeholder="Email" />
                    <input type="password" placeholder="Password" />
                    <button>Sign Up</button>
                </form>
            </div>

            <!-- FORM ĐĂNG NHẬP -->
            <div class="form-container sign-in-container">
                <form action="Login" method="post" id="loginForm">
                    <h1>Sign in</h1>
                    <span>or use your account</span>
                    <!-- HIỂN THỊ THÔNG BÁO LỖI -->
                    <c:if test="${not empty error}">
                        <p style="color:red; text-align:center; font-weight:bold;">
                            ${error}
                        </p>
                    </c:if>
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

        <script src="${pageContext.request.contextPath}/js/login.js"></script>


    </body>
</html>
