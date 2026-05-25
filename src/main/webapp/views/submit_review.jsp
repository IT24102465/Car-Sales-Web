<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Certification - Step 3 | SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="<%= ctx %>/css/styles.css">
    <link rel="stylesheet" href="<%= ctx %>/css/dashboard.css">
    <link rel="stylesheet" href="<%= ctx %>/css/car-certification.css">
</head>
<body class="certification-page">

<jsp:include page="/navbar.jsp" />

<section class="hero-section certification-hero-banner text-center">
    <div class="container">
        <h1 class="hero-title"><i class='bx bx-check-shield'></i> Car Certification</h1>
        <p class="lead mb-0">Step 3 of 3 — Review and submit</p>
    </div>
</section>

<div class="container certification-content my-5">
    <div class="step-indicator">
        <div class="step completed">
            <div class="step-number"><i class='bx bx-check'></i></div>
            <div>Car Details</div>
        </div>
        <div class="step completed">
            <div class="step-number"><i class='bx bx-check'></i></div>
            <div>Condition</div>
        </div>
        <div class="step active">
            <div class="step-number">3</div>
            <div>Review & Submit</div>
        </div>
    </div>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success alert-dismissible fade show">
        <%= request.getAttribute("success") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show">
        <%= request.getAttribute("error") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (session != null && session.getAttribute("brand") != null) { %>
    <div class="card">
        <div class="card-header"><i class='bx bx-list-ul'></i> Review Your Submission</div>
        <div class="card-body">
            <ul class="list-group list-group-flush mb-4">
                <li class="list-group-item"><strong>Brand:</strong> <%= session.getAttribute("brand") %></li>
                <li class="list-group-item"><strong>Model:</strong> <%= session.getAttribute("model") %></li>
                <li class="list-group-item"><strong>Year:</strong> <%= session.getAttribute("year") %></li>
                <li class="list-group-item"><strong>Mileage:</strong> <%= session.getAttribute("mileage") %> km</li>
                <li class="list-group-item"><strong>Price:</strong> Rs. <%= session.getAttribute("price") %></li>
                <li class="list-group-item"><strong>Location:</strong> <%= session.getAttribute("location") %></li>
                <li class="list-group-item"><strong>Owner Contact:</strong> <%= session.getAttribute("ownerContact") %></li>
                <li class="list-group-item">
                    <strong>Damages / Condition Notes:</strong>
                    <pre class="mb-0 mt-2" style="white-space: pre-wrap;"><%= session.getAttribute("damages") %></pre>
                </li>
            </ul>
            <form action="<%= ctx %>/submit-review" method="post" class="d-flex flex-wrap gap-2">
                <a href="<%= ctx %>/damage-info" class="btn btn-outline-secondary">
                    <i class='bx bx-arrow-back'></i> Back to Step 2
                </a>
                <button type="submit" class="btn btn-danger">
                    <i class='bx bx-send'></i> Submit Certification Request
                </button>
            </form>
        </div>
    </div>
    <% } else { %>
    <div class="alert alert-warning text-center">
        <i class='bx bx-info-circle fs-4 d-block mb-2'></i>
        No certification data found. Please start from Step 1.
        <div class="mt-3">
            <a href="<%= ctx %>/car-details" class="btn btn-danger">Start Certification</a>
        </div>
    </div>
    <% } %>
</div>

<jsp:include page="/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
