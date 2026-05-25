<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/car-certification.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-car"></i>SMART CARZONE</a>
        </div>
    </nav>
    
    <div class="container mt-5" style="max-width:400px;">
        <h2 class="mb-4 text-center">Admin Login</h2>
        <div class="card">
            <div class="card-header">
                <i class="fas fa-lock mr-2"></i> Secure Login
            </div>
            <div class="card-body">
                <form action="admin-login" method="post">
                    <div class="form-group">
                        <label><i class="fas fa-user mr-2"></i>Username</label>
                        <input type="text" name="username" class="form-control" required autofocus>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-key mr-2"></i>Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger mt-2"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <button type="submit" class="btn btn-primary btn-block mt-3">
                        <i class="fas fa-sign-in-alt mr-2"></i>Login
                    </button>
                </form>
            </div>
        </div>
        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-link">
                <i class="fas fa-home mr-1"></i> Back to Home
            </a>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <p>&copy; 2025 SMART CARZONE - All Rights Reserved</p>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
