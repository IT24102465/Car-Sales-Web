<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="admin.model.Admin" %>
<%@ page import="login.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    String success = request.getParameter("success");
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">

    <title>View User | SMART CARZONE</title>
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
                    <img src="<%= user.getAvatarUrl() != null ?
                            user.getAvatarUrl() :
                            "https://ui-avatars.com/api/?name=" +
                            user.getFullName().replace(" ", "+") +
                            "&background=random" %>" alt="Profile" class="profile-avatar rounded-circle" id="avatarPreview">
                </div>
            </div>
            <script>
                document.getElementById("avatarUpload").addEventListener("change", function () {
                    document.getElementById("avatarForm").submit();
                });
            </script>

            <h3 class="mt-3"><%=user.getFullName() %></h3>
            <p class="text-muted"><%=user.getEmail() %></p>
            <span class="badge bg-primary">
          <%=user.getUserType()%>
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
                                <div class="col-md-6">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" name="fullName" value="<%= user.getFullName() %>" readonly>
                                </div>
                                </br>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="<%=user.getEmail() %>" readonly>
                                </div>
                                </br>

                                <div class="col-md-6">
                                    <label class="form-label">Phone number</label>
                                    <input type="text" class="form-control" name="phone" value="<%=user.getPhone() %>" readonly>
                                </div>
                                </br>

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