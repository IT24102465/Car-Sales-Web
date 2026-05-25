<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certified Pre-Owned Vehicles | SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="<%= ctx %>/css/styles.css">
    <link rel="stylesheet" href="<%= ctx %>/css/dashboard.css">
    <link rel="stylesheet" href="<%= ctx %>/css/certified.css">
</head>
<body class="certified-page">

<%@include file="navbar.jsp" %>

<section class="hero-section certified-hero-banner text-center">
    <div class="container">
        <h1 class="hero-title animate__animated animate__fadeInDown">SMART CARZONE Certified Pre-Owned</h1>
        <p class="lead animate__animated animate__fadeIn animate__delay-1s">
            Rigorous inspections. Unmatched quality. Complete peace of mind.
        </p>
        <img src="<%= ctx %>/images/certified.png" alt="Certified Badge" class="certified-badge animate__animated animate__fadeInUp animate__delay-1s">
    </div>
</section>

<section class="certified-inspection-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2><i class='bx bx-check-shield'></i> Our 150-Point Inspection Process</h2>
            <p class="lead text-muted">Every certified vehicle undergoes our comprehensive inspection</p>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3">
                <div class="certified-inspection-card">
                    <h3>Mechanical Inspection</h3>
                    <ul>
                        <li>Engine diagnostic scan</li>
                        <li>Transmission performance test</li>
                        <li>Brake system evaluation</li>
                        <li>Suspension component check</li>
                        <li>Fluid level verification</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="certified-inspection-card">
                    <h3>Safety Check</h3>
                    <ul>
                        <li>Airbag system diagnostic</li>
                        <li>Seatbelt functionality test</li>
                        <li>ABS and stability control</li>
                        <li>Tire condition assessment</li>
                        <li>Lighting system inspection</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="certified-inspection-card">
                    <h3>Cosmetic Review</h3>
                    <ul>
                        <li>Interior upholstery evaluation</li>
                        <li>Exterior paint and body</li>
                        <li>Glass and mirror inspection</li>
                        <li>Wheel condition check</li>
                        <li>Undercarriage examination</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="certified-inspection-card">
                    <h3>History Verification</h3>
                    <ul>
                        <li>Clean title confirmation</li>
                        <li>Odometer validation</li>
                        <li>Accident history check</li>
                        <li>Service records review</li>
                        <li>Recall completion</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="certified-process-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2><i class='bx bx-star'></i> Certification Benefits</h2>
            <p class="lead text-muted">Why choose a SMART CARZONE Certified vehicle</p>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>Extended Warranty</h4>
                        <p>Additional coverage beyond the factory warranty period for your peace of mind.</p>
                    </div>
                </div>
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>Roadside Assistance</h4>
                        <p>24/7 support for emergencies throughout your warranty period.</p>
                    </div>
                </div>
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>Buy-Back Guarantee</h4>
                        <p>Our commitment to quality means we stand behind every vehicle we certify.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>Complimentary Maintenance</h4>
                        <p>First service included with every certified vehicle purchase.</p>
                    </div>
                </div>
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>Vehicle History Report</h4>
                        <p>Full disclosure of the vehicle's history so you know exactly what you're getting.</p>
                    </div>
                </div>
                <div class="certified-benefit-item">
                    <i class='bx bx-check-circle certified-benefit-icon'></i>
                    <div class="certified-benefit-content">
                        <h4>7-Day Exchange</h4>
                        <p>Not completely satisfied? Exchange your vehicle within 7 days.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="certified-process-section alt-bg">
    <div class="container">
        <div class="text-center mb-5">
            <h2><i class='bx bx-list-check'></i> Our Certification Process</h2>
            <p class="lead text-muted">How a vehicle earns the SMART CARZONE Certified designation</p>
        </div>
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="certified-process-step">
                    <div class="certified-step-number">1</div>
                    <h3>Initial Screening</h3>
                    <p>We start by selecting only late-model vehicles with proper service history and no major accidents.</p>
                </div>
                <div class="certified-process-step">
                    <div class="certified-step-number">2</div>
                    <h3>Comprehensive Inspection</h3>
                    <p>Our certified technicians perform the 150-point inspection, addressing any issues found.</p>
                </div>
                <div class="certified-process-step">
                    <div class="certified-step-number">3</div>
                    <h3>Reconditioning</h3>
                    <p>All necessary repairs and replacements are completed using quality parts.</p>
                </div>
                <div class="certified-process-step">
                    <div class="certified-step-number">4</div>
                    <h3>Final Quality Control</h3>
                    <p>The vehicle undergoes a final review by our lead technician before certification.</p>
                </div>
                <div class="certified-process-step">
                    <div class="certified-step-number">5</div>
                    <h3>Certification Awarded</h3>
                    <p>Only after passing all checks does the vehicle receive the SMART CARZONE Certified badge.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="certified-cta-section">
    <div class="container">
        <h2>Ready to Drive a Certified Pre-Owned Vehicle?</h2>
        <p class="lead mb-4">Experience the SMART CARZONE difference with our certified vehicles</p>
        <a href="<%= ctx %>/Buynow.jsp" class="certified-btn-white">
            <i class='bx bx-car'></i> Browse Certified Inventory
        </a>
        <a href="<%= ctx %>/contactus.jsp" class="certified-btn-outline-white">
            <i class='bx bx-phone'></i> Contact Our Team
        </a>
    </div>
</section>

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
