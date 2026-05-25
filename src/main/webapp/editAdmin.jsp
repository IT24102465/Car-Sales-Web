<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="admin.model.Admin" %>
<%
  Admin admin = (Admin) request.getAttribute("admin");
  String success = request.getParameter("success");
  String error = (String) request.getAttribute("error");
%>
<html>
<head>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">

  <title>Edit Admin | SMART CARZONE</title>
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
            <img src="<%= admin.getProfilePicture() %>?t=<%= System.currentTimeMillis() %>" alt="Profile" class="profile-avatar rounded-circle" id="avatarPreview">
        </div>
      </div>
      <script>
        document.getElementById("avatarUpload").addEventListener("change", function () {
          document.getElementById("avatarForm").submit();
        });
      </script>

      <h3 class="mt-3"><%= admin.getName() %></h3>
      <p class="text-muted"><%= admin.getUsername() %></p>
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
            <form id="profileForm" action="editAdmin" method="POST">
              <div class="row mb-3">
                <div class="col-md-6">
                  <label class="form-label">Name</label>
                  <input type="text" class="form-control" name="fullName" value="<%= admin.getName() %>" required>
                </div>
                <div class="col-md-6">
                  <label class="form-label">Email</label>
                  <input type="email" class="form-control" name="email" value="<%= admin.getUsername() %>" readonly>
                </div>

                <div class="col-md-6">
                  <label class="form-label"> Reset Password</label>
                  <input type="password" class="form-control" name="password" placeholder="Enter a new password to reset">
                </div>
              </div>

              <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
          </div>
        </div>

        <div class="card border-danger mt-4">
          <div class="card-header bg-danger text-white">
            <h5 class="mb-0">Delete Account</h5>
          </div>
          <div class="card-body">
            <form action="deleteOtherAdmins" method="post">
              <input type="hidden" name="id" value="<%= admin.getUsername() %>">
              <button type="submit" class="btn btn-outline-danger"
                      data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                Delete Admin Account
              </button>
            </form>
          </div>
        </div>

      </div> <!-- col-lg-8 -->
    </div> <!-- row -->
  </div> <!-- profile-container -->
</div> <!-- container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/profile.js"></script>
</body>
</html>









