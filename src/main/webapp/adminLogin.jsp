<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - SMART CARZONE</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="signin-container">
    <div class="signin-header">
        <h2>Admin Login</h2>
    </div>

    <form id="signinForm" action="adminLogin" method="POST">
        <input type="hidden" name="action" value="login">
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


        <button type="submit" class="signin-btn">Sign In</button>
    </form>
</div>




<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>