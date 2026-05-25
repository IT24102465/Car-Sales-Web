<%@ page import="admin.model.Admin" %>
<%
  Admin currentUser = (Admin) session.getAttribute("admin");
  String profilePic = (String) session.getAttribute("profilePic");
  String ctx = request.getContextPath();
  if (profilePic == null || profilePic.trim().isEmpty()) {
      profilePic = ctx + "/images/profile-user.png";
  }
%>
<nav class="admin-navbar">
  <div class="admin-navbar-inner">
    <div class="admin-navbar-logo">
      <a href="<%= ctx %>/adminDashboard">
        <img src="<%= ctx %>/images/logo1.jpg" alt="SMART CARZONE Logo">
      </a>
    </div>

    <div class="admin-navbar-links">
      <a href="<%= ctx %>/adminDashboard" class="admin-nav-link">Dashboard</a>
      <a href="<%= ctx %>/userListing" class="admin-nav-link">Users</a>
      <a href="<%= ctx %>/carListing" class="admin-nav-link">Cars</a>
    </div>

    <% if (currentUser != null) { %>
    <div class="admin-navbar-right">
      <div class="admin-welcome">
        <span class="admin-welcome-label">Welcome,</span>
        <span class="admin-welcome-name"><%= currentUser.getName() %></span>
      </div>
      <div class="admin-profile-dropdown">
        <button type="button" class="admin-profile-btn" id="profileButton" aria-label="Admin menu">
          <img src="<%= profilePic %>?t=<%= System.currentTimeMillis() %>" alt="Profile" class="admin-profile-pic">
        </button>
        <div class="admin-dropdown-menu" id="profileDropdown">
          <div class="admin-dropdown-header">
            <span id="userName"><%= currentUser.getName() %></span>
            <span id="userEmail"><%= currentUser.getUsername() %></span>
            <span class="admin-role-badge">Administrator</span>
          </div>
          <a href="<%= ctx %>/adminProfile.jsp" class="admin-dropdown-item">
            <i class='bx bx-user'></i> Manage Account
          </a>
          <a href="#" class="admin-dropdown-item admin-logout-btn" id="logoutButton">
            <i class='bx bx-log-out'></i> Logout
          </a>
        </div>
      </div>
    </div>
    <% } %>
  </div>
</nav>
<script src="<%= ctx %>/js/admin-navbar.js"></script>
