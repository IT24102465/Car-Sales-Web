<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, admin.model.Admin" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= ctx %>">

<jsp:include page="adminNavbar.jsp"/>

<div class="admin-content">
    <div class="header">
        <h1>Admin Dashboard</h1>
        <a href="<%= ctx %>/registerAdmin.jsp" class="btn-primary">Register New Admin</a>
    </div>

    <h2>Current Admins</h2>
    <table>
        <thead>
        <tr>
            <th>Profile</th>
            <th>ID</th>
            <th>Username</th>
            <th>Name</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Admin> currentAdmins = (List<Admin>) request.getAttribute("adminList");
            if (currentAdmins != null && !currentAdmins.isEmpty()) {
                for (Admin admin : currentAdmins) {
        %>
        <tr>
            <td><img class="profile" src="<%= admin.getProfilePicture() %>" alt="Profile" /></td>
            <td><%= admin.getAdminID() %></td>
            <td><%= admin.getUsername() %></td>
            <td><%= admin.getName() %></td>
            <td>
                <form method="get" action="<%= ctx %>/editAdmin" style="display:inline;">
                    <input type="hidden" name="id" value="<%= admin.getUsername() %>">
                    <button type="submit" class="view-button">View</button>
                </form>
                <form method="post" action="<%= ctx %>/deleteOtherAdmins" style="display:inline;">
                    <input type="hidden" name="id" value="<%= admin.getUsername() %>">
                    <button type="submit" class="delete-button" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="5">No current admins found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <h2>Deleted Admins</h2>
    <table>
        <thead>
        <tr>
            <th>Profile</th>
            <th>ID</th>
            <th>Username</th>
            <th>Name</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Admin> deletedAdmins = (List<Admin>) request.getAttribute("deletedAdminList");
            if (deletedAdmins != null && !deletedAdmins.isEmpty()) {
                for (Admin admin : deletedAdmins) {
        %>
        <tr>
            <td><img class="profile" src="<%= admin.getProfilePicture() %>" alt="Profile" /></td>
            <td><%= admin.getAdminID() %></td>
            <td><%= admin.getUsername() %></td>
            <td><%= admin.getName() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="4">No deleted admins found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
