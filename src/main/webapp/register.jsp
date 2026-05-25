<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - SMART CARZONE</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css"> <!-- Assuming your existing styles.css -->
</head>
<body>
<!-- Navbar (Reused from your code) -->
<%@include file="navbar.jsp"%>
<!-- Sign Up Section -->
<section class="signup-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="signup-form">
                    <h2 class="text-center mb-4"><b>Create Your Account</b></h2>
                    <p class="text-center mb-4">Join SMART CARZONE and start your car buying or selling journey today!</p>
                    <form action="auth" method="POST">
                        <input type="hidden" name="action" value="register">

                        <div class="container mt-3">
                            <%-- Error Message --%>
                            <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>
                        </div>
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>

                        <div class="mb-3">
                            <label for="userType" class="form-label">I want to:</label>
                            <select class="form-select" id="userType" name="userType" required>
                                <option value="" selected disabled>Select your role</option>
                                <option value="buyer">Buy Vehicles</option>
                                <option value="seller">Sell Vehicles</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="terms" required>
                            <label class="form-check-label" for="terms">I agree to the <a href="terms.jsp">Terms of Service</a> and <a href="privacy.jsp">Privacy Policy</a></label>
                        </div>
                        <button type="submit" class="beautiful-button form-signup-button w-100">Register</button>
                    </form>
                    <p class="text-center mt-3">Already have an account? <a href="signin.jsp">Sign In</a></p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer (Reused from your code) -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>

