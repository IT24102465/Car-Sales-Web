<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="login.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<%
  // Get user from session
  User currentUser = (User) session.getAttribute("user");
  java.util.List<ReviewsComplaintsFAQs.model.FAQ> faqs =
          (java.util.List<ReviewsComplaintsFAQs.model.FAQ>) request.getAttribute("faqs");
  Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
  String currentUserEmail = currentUser != null ? currentUser.getEmail() : "";
%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Car FAQs</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
  <header>
    <h1>Car FAQs</h1>
    <nav class="main-nav">
      <a href="reviews.jsp" class="nav-link">Reviews</a>
      <a href="viewComplaints" class="nav-link">Complaints</a>
      <a href="viewFAQs" class="nav-link active">FAQ</a>
    </nav>
  </header>

  <main>
    <section class="review-form">
      <h2>Submit a Question</h2>
      <form id="faqForm" method="post" action="submitFAQ">
        <textarea name="faqQuestion" id="faqQuestion" placeholder="Please type your question here..." required></textarea>
        <button type="submit" class="btn">Submit Question</button>
      </form>
    </section>

    <section class="faqs">
      <div class="section-title">
        <h2>Frequently Asked Questions</h2>
        <div class="underline"></div>
      </div>
      <div class="faq-list">
        <%
          if (faqs != null && !faqs.isEmpty()) {
            for (ReviewsComplaintsFAQs.model.FAQ faq : faqs) {
              boolean canDelete = (isAdmin != null && isAdmin) ||
                      (faq.getUserEmail() != null && faq.getUserEmail().equals(currentUserEmail));
        %>
        <div class="faq-card">
          <% if (isAdmin != null && isAdmin) { %>
          <p><strong>User Email:</strong> <%= faq.getUserEmail() %></p>
          <% } %>
          <p><strong>Question:</strong> <%= faq.getQuestion() %></p>
          <% if (canDelete) { %>
          <form method="post" action="deleteFAQ" style="display:inline;">
            <input type="hidden" name="email" value="<%= faq.getUserEmail() %>" />
            <input type="hidden" name="question" value="<%= faq.getQuestion() %>" />
            <button type="submit" class="btn">Delete</button>
          </form>
          <% } %>
        </div>
        <%
          }
        } else {
        %>
        <p>No questions found.</p>
        <%
          }
        %>
      </div>
    </section>
  </main>
</div>
</body>
</html>