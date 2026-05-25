<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Certification - Step 2 | SMART CARZONE</title>
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
        <h1 class="hero-title"><i class='bx bx-clipboard'></i> Car Certification</h1>
        <p class="lead mb-0">Step 2 of 3 — Vehicle condition</p>
    </div>
</section>

<div class="container certification-content my-5">
    <div class="step-indicator">
        <div class="step completed">
            <div class="step-number"><i class='bx bx-check'></i></div>
            <div>Car Details</div>
        </div>
        <div class="step active">
            <div class="step-number">2</div>
            <div>Condition</div>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <div>Review & Submit</div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><i class='bx bx-error-circle'></i> Describe Any Damages or Issues</div>
        <div class="card-body">
            <form action="<%= ctx %>/damage-info" method="post">
                <div class="mb-3">
                    <label for="damages" class="form-label">
                        List any damages, issues, or comments about the vehicle's condition:
                    </label>
                    <textarea id="damages" name="damages" class="form-control" rows="6" required
                              placeholder="Describe scratches, mechanical issues, service history notes, etc."></textarea>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <a href="<%= ctx %>/car-details" class="btn btn-outline-secondary">
                        <i class='bx bx-arrow-back'></i> Back to Step 1
                    </a>
                    <button type="submit" class="btn btn-danger">
                        Continue to Step 3 <i class='bx bx-right-arrow-alt'></i>
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
