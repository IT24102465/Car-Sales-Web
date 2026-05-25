<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="admin.model.Admin" %>
<%
    Admin currentUser = (Admin) session.getAttribute("admin");
    String success = request.getParameter("success");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Admin Profile | SMART CARZONE</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= request.getContextPath() %>">
<jsp:include page="adminNavbar.jsp"/>

<div class="container mt-5">
    <%-- Success/Error Messages --%>
    <% if (success != null) { %>
    <div class="alert alert-success alert-dismissible fade show">
        <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    <% if (error != null) { %>
    <div class="alert alert-danger alert-dismissible fade show">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="profile-container">
        <div class="profile-header text-center mb-5">
            <div class="profile-avatar-container mx-auto">
                <div class="avatar-upload">
                    <form id="avatarForm" action="adminChangePicture" method="POST" enctype="multipart/form-data">
                        <img src="<%= currentUser.getProfilePicture() %>?t=<%= System.currentTimeMillis() %>" alt="Profile" class="profile-avatar rounded-circle" id="avatarPreview">
                        <div class="avatar-edit">
                            <input type="file" id="avatarUpload" accept=".png, .jpg, .jpeg" name="profilePicture">
                            <label for="avatarUpload"><i class='bx bx-camera'></i></label>
                        </div>
                    </form>
                </div>

                <script>
                    document.getElementById("avatarUpload").addEventListener("change", function () {
                        document.getElementById("avatarForm").submit();
                    });
                </script>

                <form action="remove-profilePic" method="POST" class="mt-2 remove-photo-form">
                    <button type="button" class="btn btn-sm btn-outline-danger btn-remove-avatar"
                            <%= currentUser.getProfilePicture() == null ? "disabled" : "" %>>
                        Remove Photo
                    </button>
                </form>
            </div>
            <h3 class="mt-3"><%= currentUser.getName() %></h3>
            <p class="text-muted"><%= currentUser.getUsername() %></p>
            <span class="badge bg-primary">
                Admin
            </span>
        </div>

        <div class="row">
            <div class="col-lg-8 mx-auto">
                <%-- Personal Information Form --%>
                <div class="card mb-4">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="mb-0">Personal Information</h5>
                    </div>
                    <div class="card-body">
                        <form id="profileForm" action="adminUpdateProfile" method="POST">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName"
                                           value="<%= currentUser.getName() %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email"
                                           value="<%= currentUser.getUsername() %>" readonly>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </form>
                    </div>
                </div>

                <%-- Change Password Form --%>
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0">Change Password</h5>
                    </div>
                    <div class="card-body">
                        <form id="passwordForm" action="adminChangePassword" method="POST">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword"
                                       name="currentPassword" required>
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword"
                                       name="newPassword" required>
                                <small class="text-muted">Must be 8+ characters with uppercase, number, and special symbol</small>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword"
                                       name="confirmPassword" required>
                            </div>
                            <button type="submit" class="btn btn-warning">Change Password</button>
                        </form>
                    </div>
                </div>

                <%-- Delete Account Section --%>
                <div class="card border-danger mt-4">
                    <div class="card-header bg-danger text-white">
                        <h5 class="mb-0">Delete Account</h5>
                    </div>
                    <div class="card-body">
                        <button type="button" class="btn btn-outline-danger"
                                data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                            Delete My Account
                        </button>

                        <!-- Confirmation Modal -->
                        <div class="modal fade" id="deleteAccountModal" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header bg-danger text-white">
                                        <h5 class="modal-title">Confirm Account Deletion</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form id="deleteAccountForm" action="deleteAdmin" method="POST">
                                        <div class="modal-body">
                                            <div class="alert alert-danger">
                                                <strong>Warning!</strong> This will permanently delete your account and all data.
                                            </div>
                                            <div class="mb-3">
                                                <label for="currentPassword" class="form-label">Enter your current password to confirm:</label>
                                                <input type="password" class="form-control" id="password"
                                                       name="currentPassword" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-danger">
                                                <span id="deleteSpinner" class="spinner-border spinner-border-sm d-none"></span>
                                                Delete Account Permanently
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/profile.js"></script>
</body>
</html>