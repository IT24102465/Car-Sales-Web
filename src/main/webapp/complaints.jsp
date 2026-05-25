<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="login.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<%
    // Get user from session
    User currentUser = (User) session.getAttribute("user");
    java.util.List<ReviewsComplaintsFAQs.model.Complaints> complaints =
            (java.util.List<ReviewsComplaintsFAQs.model.Complaints>) request.getAttribute("complaints");
    Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
    String currentUserEmail = currentUser != null ? currentUser.getEmail() : "";
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Car Complaints</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <header>
        <h1>Car Complaints</h1>
        <nav class="main-nav">
            <a href="reviews.jsp" class="nav-link">Reviews</a>
            <a href="viewComplaints" class="nav-link active">Complaints</a>
            <a href="faq.jsp" class="nav-link">FAQ</a>
        </nav>
    </header>

    <main>
        <section class="review-form">
            <h2>Submit a Complaint</h2>
            <form id="complaintForm" method="post" action="submitComplaint">
                <textarea name="complaintContent" id="complaintContent" placeholder="Please describe your complaint in detail..." required></textarea>
                <button type="submit" class="btn">Submit Complaint</button>
            </form>
        </section>

        <section class="complaints">
            <div class="section-title">
                <h2>Customer Complaints</h2>
                <div class="underline"></div>
            </div>
            <div class="complaint-list">
                <%
                    if (complaints != null && !complaints.isEmpty()) {
                        for (ReviewsComplaintsFAQs.model.Complaints complaint : complaints) {
                            boolean canDelete = (isAdmin != null && isAdmin) ||
                                    (complaint.getUserEmail() != null && complaint.getUserEmail().equals(currentUserEmail));
                %>
                <div class="complaint-card">
                    <% if (isAdmin != null && isAdmin) { %>
                    <p><strong>User Email:</strong> <%= complaint.getUserEmail() %></p>
                    <% } %>
                    <p><strong>Content:</strong> <%= complaint.getContent() %></p>
                    <% if (canDelete) { %>
                    <form method="post" action="deleteComplaint" style="display:inline;">
                        <input type="hidden" name="email" value="<%= complaint.getUserEmail() %>" />
                        <input type="hidden" name="content" value="<%= complaint.getContent() %>" />
                        <button type="submit" class="btn">Delete</button>
                    </form>
                    <% } %>
                </div>
                <%
                    }
                } else {
                %>
                <p>No complaints found.</p>
                <%
                    }
                %>
            </div>
        </section>
    </main>
</div>
</body>
</html>