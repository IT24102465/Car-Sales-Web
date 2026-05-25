<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="login.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<%
  // Get user from session (for consistency with other JSPs)
  User currentUser = (User) session.getAttribute("user");
%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Car Reviews</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
  <header>
    <h1>Car Reviews</h1>
    <nav class="main-nav">
      <a href="reviews.jsp" class="nav-link active">Reviews</a>
      <a href="complaints.jsp" class="nav-link">Complaints</a>
      <a href="faq.jsp" class="nav-link">FAQ</a>
    </nav>
  </header>

  <main>
    <section class="review-form">
      <h2>Write a Review</h2>
      <form id="reviewForm" method="post" action="submitReview">
        <div class="rating-group">
          <label>Rating:</label>
          <select name="rating" id="reviewRating" required>
            <option value="">Select</option>
            <option value="5">★★★★★</option>
            <option value="4">★★★★☆</option>
            <option value="3">★★★☆☆</option>
            <option value="2">★★☆☆☆</option>
            <option value="1">★☆☆☆☆</option>
          </select>
        </div>
        <textarea name="content" id="reviewContent" placeholder="Share your thoughts about the car..." required></textarea>
        <button type="submit" class="btn">Submit Review</button>
      </form>
    </section>

    <section class="reviews">
      <div class="section-title">
        <h2>What Our Customers Say</h2>
        <div class="underline"></div>
      </div>
      <div class="review-list">
          <%
            java.util.List<ReviewsComplaintsFAQs.model.Reviews> reviews = (java.util.List<ReviewsComplaintsFAQs.model.Reviews>) request.getAttribute("reviews");
            Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
            String currentUserEmail = currentUser != null ? currentUser.getEmail() : "";
            if (reviews != null) {
              for (int i = 0; i < reviews.size(); i++) {
                ReviewsComplaintsFAQs.model.Reviews review = reviews.get(i);
                String reviewContent = review.getContent();
                boolean canDelete = (isAdmin != null && isAdmin) || review.getUserEmail().equals(currentUserEmail);
          %>
          <div class="review-card">
            <p><strong><%= review.getUserEmail() %></strong></p>
            <p>
              <% int stars = review.getRating();
                for (int s = 0; s < stars; s++) { %>★<% }
              for (int s = stars; s < 5; s++) { %>☆<% }
            %>
            </p>
            <p><%= reviewContent %></p>
            <% if (canDelete) { %>
            <form method="post" action="deleteReview" style="display:inline;">
              <input type="hidden" name="email" value="<%= review.getUserEmail() %>" />
              <input type="hidden" name="rating" value="<%= review.getRating() %>" />
              <input type="hidden" name="content" value="<%= review.getContent() %>" />
              <button type="submit" class="btn">Delete</button>
            </form>
            <% } %>
          </div>
          <%
              }
            }
          %>
        </div>
    </section>
  </main>
</div>
</body>
</html>