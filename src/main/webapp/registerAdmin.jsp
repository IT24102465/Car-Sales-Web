<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Admin</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= request.getContextPath() %>">
<jsp:include page="adminNavbar.jsp"/>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="signup-form">
                <h2>Register New Admin</h2>
                <form action="registerAdmin" method="post" enctype="multipart/form-data" class="form-section">
                    <div class="mb-3">
                        <label class="form-label">Admin ID</label>
                        <input type="text" class="form-control" name="adminID" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>



                    <div class="mb-3">
                        <label>Profile Picture</label>
                        <input type="file" name="profilePicture" accept=".jpg,.jpeg,.png">
                    </div>
                    <button type="submit" class="beautiful-button form-signup-button w-100">Register</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>




