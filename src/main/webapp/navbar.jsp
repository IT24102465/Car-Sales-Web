<%@ page import="login.model.User" %>
<%
  User currentUser = (User) session.getAttribute("user");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
<nav class="site-navbar">
  <div class="logo">
    <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="SMART CARZONE Logo">
  </div>
  <div class="nav-links">
    <a href="<%= request.getContextPath() %>/front.jsp"><b>HOME</b></a>
    <% if (currentUser != null) { %>
    <% if ("seller".equals(currentUser.getUserType())) { %>
    <a href="<%= request.getContextPath() %>/sell.jsp"><b>SELL</b></a>
    <% } %>
    <% } %>
    <a href="<%= request.getContextPath() %>/Buynow.jsp"><b>BUY NOW</b></a>
    <a href="<%= request.getContextPath() %>/aboutus.jsp"><b>ABOUT US</b></a>
    <a href="<%= request.getContextPath() %>/contactus.jsp"><b>CONTACT US</b></a>
  </div>

  <% if (currentUser != null) { %>
  <div class="welcome-message">
    <div>Welcome,</div>
    <div><%= currentUser.getFullName() %>!</div>
  </div>
  <div class="user-profile">
    <div class="profile-container">
      <div class="profile-dropdown">
        <button class="profile-button" id="profileButton">
          <img src="<%= currentUser.getAvatarUrl() != null ? currentUser.getAvatarUrl() :
            "https://ui-avatars.com/api/?name=" + currentUser.getFullName().replace(" ", "+") + "&background=random" %>"
               alt="Profile" id="profileImage">
        </button>
        <div class="dropdown-content" id="profileDropdown">
          <div class="user-info">
            <span id="userName"><%= currentUser.getFullName() %></span>
            <span id="userEmail"><%= currentUser.getEmail() %></span>
            <span class="user-type-badge <%= "seller".equals(currentUser.getUserType()) ? "seller-badge" : "buyer-badge" %>">
              <%= "seller".equals(currentUser.getUserType()) ? "Seller Account" : "Buyer Account" %>
            </span>
          </div>
          <a href="<%= request.getContextPath() %>/profile.jsp" class="dropdown-option">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
              <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
            </svg>
            Manage Account
          </a>
          <% if ("seller".equals(currentUser.getUserType())) { %>
          <a href="<%= request.getContextPath() %>/listings.jsp" class="dropdown-option">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
              <path d="M2 1a1 1 0 0 0-1 1v4.586a1 1 0 0 0 .293.707l7 7a1 1 0 0 0 1.414 0l4.586-4.586a1 1 0 0 0 0-1.414l-7-7A1 1 0 0 0 6.586 1H2zm4 3.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
            </svg>
            My Listings
          </a>
          <% } else { %>
          <a href="<%= request.getContextPath() %>/view-favorites" class="dropdown-option">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
              <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
            </svg>
            Saved Cars
          </a>
          <% } %>
          <a href="#" class="logout-button" id="logoutButton">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
              <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
              <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
            </svg>
            Logout
          </a>
        </div>
      </div>
    </div>
  </div>
  <% } else { %>
  <div class="auth-buttons">
    <a href="<%= request.getContextPath() %>/signin.jsp" class="beautiful-button signin-button">Sign In</a>
    <a href="<%= request.getContextPath() %>/register.jsp" class="beautiful-button signup-button">Sign Up</a>
  </div>
  <% } %>
</nav>
<script src="<%= request.getContextPath() %>/js/dashboard.js"></script>
