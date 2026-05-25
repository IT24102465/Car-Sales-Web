<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - SMART CARZONE</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- Reuse the same navbar from your main page -->
<%@include file="navbar.jsp"%>
<!-- Sign In Hero Section -->
<section class="signin-hero">
    <h1>Welcome Back to SMART CARZONE</h1>
    <p>Sign in to access your account and continue your car buying or selling journey</p>
</section>

<!-- Sign In Form Container -->
<div class="signin-container">
    <div class="signin-header">
        <h2>Sign In to Your Account</h2>
        <p>Enter your credentials to access your personalized dashboard</p>
    </div>

    <form id="signinForm" action="auth" method="POST">
    <input type="hidden" name="action" value="login">
        <!-- Error Message Display -->
        <div class="container mt-3">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show">
                <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>
        </div>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show">
            <%= request.getAttribute("success") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>
        <!-- Email Field - Fixed spacing -->
        <div class="form-group">
            <label for="email">Email Address</label>
            <div class="input-with-icon">
                <i class='bx bx-envelope input-icon'></i>
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email address" required>
            </div>
        </div>

        <!-- Password Field  -->
        <div class="form-group">
            <label for="password">Password</label>
            <div class="input-with-icon password-input">
                <i class='bx bx-lock-alt input-icon'></i>
                <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
            </div>
        </div>

        <!-- Remember Me & Forgot Password -->
        <div class="remember-forgot">
            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember me</label>
            </div>
            <div class="forgot-password">
                <a href="forgot-password.jsp">Forgot password?</a>
            </div>
        </div>

        <!-- Sign In Button -->
        <button type="submit" class="signin-btn">Sign In</button>
        <!-- Sign Up Link -->
        <div class="signup-link">
            Don't have an account? <a href="register.jsp">Create one now</a>
        </div>
    </form>

    <!-- Security Notice -->
    <div class="security-notice">
        <i class='bx bx-shield-alt-2'></i>
        Your information is protected by 256-bit SSL encryption
    </div>
</div>

<!-- Reuse the same footer from your main page -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>

