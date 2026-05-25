<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Certification - Step 1 | SMART CARZONE</title>
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
        <h1 class="hero-title"><i class='bx bx-car'></i> Car Certification</h1>
        <p class="lead mb-0">Step 1 of 3 — Basic vehicle details</p>
    </div>
</section>

<div class="container certification-content my-5">
    <div class="step-indicator">
        <div class="step active">
            <div class="step-number">1</div>
            <div>Car Details</div>
        </div>
        <div class="step">
            <div class="step-number">2</div>
            <div>Condition</div>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <div>Review & Submit</div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><i class='bx bx-edit'></i> Enter Your Vehicle Information</div>
        <div class="card-body">
            <form action="<%= ctx %>/car-details" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="brand" class="form-label"><i class='bx bx-tag'></i> Brand</label>
                        <input type="text" class="form-control" id="brand" name="brand" required placeholder="e.g., Toyota, Honda">
                    </div>
                    <div class="col-md-6">
                        <label for="model" class="form-label"><i class='bx bx-car'></i> Model</label>
                        <input type="text" class="form-control" id="model" name="model" required placeholder="e.g., Camry, Civic">
                    </div>
                    <div class="col-md-4">
                        <label for="year" class="form-label"><i class='bx bx-calendar'></i> Year</label>
                        <input type="number" class="form-control" id="year" name="year" required min="1900" max="2026" placeholder="e.g., 2018">
                    </div>
                    <div class="col-md-4">
                        <label for="mileage" class="form-label"><i class='bx bx-tachometer'></i> Mileage (km)</label>
                        <input type="number" class="form-control" id="mileage" name="mileage" required min="0" placeholder="e.g., 45000">
                    </div>
                    <div class="col-md-4">
                        <label for="price" class="form-label"><i class='bx bx-money'></i> Price (Rs.)</label>
                        <input type="number" class="form-control" id="price" name="price" required min="0" step="0.01" placeholder="e.g., 1500000">
                    </div>
                    <div class="col-md-6">
                        <label for="location" class="form-label"><i class='bx bx-map'></i> Location</label>
                        <input type="text" class="form-control" id="location" name="location" required placeholder="e.g., Colombo">
                    </div>
                    <div class="col-md-6">
                        <label for="ownerContact" class="form-label"><i class='bx bx-phone'></i> Owner Contact</label>
                        <input type="text" class="form-control" id="ownerContact" name="ownerContact" required placeholder="e.g., 0771234567">
                    </div>
                </div>
                <div class="mt-4 d-flex flex-wrap gap-2">
                    <a href="<%= ctx %>/front.jsp" class="btn btn-outline-secondary">
                        <i class='bx bx-arrow-back'></i> Back to Home
                    </a>
                    <button type="submit" class="btn btn-danger">
                        Continue to Step 2 <i class='bx bx-right-arrow-alt'></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
