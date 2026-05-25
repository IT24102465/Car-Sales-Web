<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, admin.model.Admin" %>
<%@ page import="login.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Listing | SMART CARZONE</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= request.getContextPath() %>">
<jsp:include page="adminNavbar.jsp"/>
<div class="container">
  <div class="header">
    <h1>User Listing</h1>

  </div>

  <h2>Current Users</h2>
  <table>
    <thead>
    <tr>
      <th>Profile</th>
      <th>Email</th>
      <th>Phone</th>
      <th>Name</th>
      <th>Role</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      List<User> currentUsers = (List<User>) request.getAttribute("userList");
      if (currentUsers != null && !currentUsers.isEmpty()) {
        for (User user : currentUsers) {
    %>
    <tr>
      <td><img class="profile" src="<%= user.getAvatarUrl() != null ?
                            user.getAvatarUrl() :
                            "https://ui-avatars.com/api/?name=" +
                            user.getFullName().replace(" ", "+") +
                            "&background=random" %>" alt="Profile" /></td>
      <td><%= user.getEmail() %></td>
      <td><%= user.getPhone() %></td>
      <td><%= user.getFullName() %></td>
      <td><%= user.getUserType() %></td>
      <td>

        <form method="get" action="editUser" style="display:inline;">
          <input type="hidden" name="email" value="<%= user.getEmail() %>">
          <button class="view-button">View</button>
        </form>

        <form method="post" action="deleteUser" style="display:inline;">
          <input type="hidden" name="email" value="<%= user.getEmail() %>">
          <button class="delete-button" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
        </form>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr><td colspan="5">No users found.</td></tr>
    <%
      }
    %>
    </tbody>
</div>
</body>
</html>