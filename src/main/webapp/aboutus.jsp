<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - SMART CARZONE</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- Reuse the same navbar from your main page -->
<%@include file="navbar.jsp"%>

<!-- About Us Hero Section -->
<div class="hero-section" style="background-color: #FF0000; color: white;">
  <div class="hero-text">
    <h1><b>Our Story at SMART CARZONE</b></h1>
    <p>Transforming the way Sri Lanka buys and sells pre-owned vehicles with trust, transparency, and technology.</p>
  </div>
  <div class="hero-image">
    <img src="images/logo1.jpg" alt="About SMART CARZONE">
  </div>
</div>

<!-- Who We Are Section -->
<section class="container" style="padding: 60px 20px;">
  <div class="row">
    <div class="col-md-6">
      <h2>Who We Are</h2>
      <p>Founded in 2010, SMART CARZONE has grown from a small used car lot in Colombo to Sri Lanka's most trusted platform for buying and selling pre-owned vehicles. Our journey has been fueled by a passion for automobiles and a commitment to making car ownership accessible to everyone.</p>
      <p>What sets us apart is our rigorous 150-point inspection process that every vehicle undergoes before being listed on our platform. This ensures that our customers drive away with confidence and peace of mind.</p>
    </div>
    <div class="col-md-6">
      <img src="images/about-team.jpg" alt="SMART CARZONE Team" style="width: 100%; border-radius: 10px;">
    </div>
  </div>
</section>

<!-- Mission and Vision -->
<section class="container mission-vision">
  <div class="mission">
    <h3><i class='bx bx-target-lock'></i> Our Mission</h3>
    <p>To revolutionize the used car industry in Sri Lanka by providing a transparent, hassle-free platform that connects buyers and sellers while ensuring every transaction is fair, secure, and satisfying for all parties involved.</p>
  </div>
  <div class="vision">
    <h3><i class='bx bx-show'></i> Our Vision</h3>
    <p>To become Sri Lanka's most trusted automotive marketplace where anyone can buy or sell a vehicle with complete confidence, backed by our industry-leading standards and customer-first approach.</p>
  </div>
</section>

<!-- Stats Section -->
<section class="stats">
  <div class="stat-item">
    <div class="stat-number">15,000+</div>
    <div class="stat-label">Happy Customers</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">8,500+</div>
    <div class="stat-label">Cars Sold</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">13</div>
    <div class="stat-label">Years in Business</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">98%</div>
    <div class="stat-label">Customer Satisfaction</div>
  </div>
</section>

<!-- Our Team -->
<section class="team-section container">
  <h2 style="text-align: center; margin-bottom: 40px;">Meet Our Leadership Team</h2>
  <div class="row">
    <div class="col-md-3 team-member">
      <img src="images/CEO.jpg" alt="CEO">
      <h4>Rajitha Perera</h4>
      <p>Founder & CEO</p>
      <p>25+ years in automotive industry</p>
    </div>
    <div class="col-md-3 team-member">
      <img src="images/COO.jpg" alt="COO">
      <h4>Nimal Fernando</h4>
      <p>Chief Operating Officer</p>
      <p>Operations & Logistics Expert</p>
    </div>
    <div class="col-md-3 team-member">
      <img src="images/CFO.jpg" alt="CFO">
      <h4>Priyanka Rathnayake</h4>
      <p>Chief Financial Officer</p>
      <p>Financial Strategy & Planning</p>
    </div>
    <div class="col-md-3 team-member">
      <img src="images/CTO.jpg" alt="CTO">
      <h4>Sanjaya Weerasinghe</h4>
      <p>Chief Technology Officer</p>
      <p>Digital Transformation Leader</p>
    </div>
  </div>
</section>

<!-- Our Journey Timeline -->
<section class="container" style="padding: 60px 20px;">
  <h2 style="text-align: center; margin-bottom: 40px;">Our Journey</h2>
  <div class="timeline">
    <div class="timeline-item left">
      <div class="timeline-content">
        <h3>2010</h3>
        <p>Founded as a small used car dealership in Colombo with just 5 vehicles in inventory.</p>
      </div>
    </div>
    <div class="timeline-item right">
      <div class="timeline-content">
        <h3>2013</h3>
        <p>Launched our first website and began offering online listings, revolutionizing used car sales in Sri Lanka.</p>
      </div>
    </div>
    <div class="timeline-item left">
      <div class="timeline-content">
        <h3>2015</h3>
        <p>Introduced our 150-point inspection certification, setting new industry standards for used vehicles.</p>
      </div>
    </div>
    <div class="timeline-item right">
      <div class="timeline-content">
        <h3>2018</h3>
        <p>Expanded to three locations across Sri Lanka with over 200 vehicles in inventory.</p>
      </div>
    </div>
    <div class="timeline-item left">
      <div class="timeline-content">
        <h3>2020</h3>
        <p>Introduced financing options and partnerships with major banks, making car ownership more accessible.</p>
      </div>
    </div>
    <div class="timeline-item right">
      <div class="timeline-content">
        <h3>2023</h3>
        <p>Celebrated our 10,000th vehicle sold and expanded our warranty program.</p>
      </div>
    </div>
  </div>
</section>

<!-- Values Section -->
<section class="container" style="padding: 60px 20px; background-color: #f9f9f9; border-radius: 10px;">
  <h2 style="text-align: center; margin-bottom: 40px;">Our Core Values</h2>
  <div class="row">
    <div class="col-md-4" style="text-align: center; padding: 20px;">
      <i class='bx bx-check-shield' style="font-size: 48px; color: #00FF00;"></i>
      <h4>Integrity</h4>
      <p>We believe in complete transparency in every transaction, with no hidden fees or surprises.</p>
    </div>
    <div class="col-md-4" style="text-align: center; padding: 20px;">
      <i class='bx bx-heart' style="font-size: 48px; color: #FF0000;"></i>
      <h4>Customer First</h4>
      <p>Your satisfaction is our top priority, from the first inquiry to long after your purchase.</p>
    </div>
    <div class="col-md-4" style="text-align: center; padding: 20px;">
      <i class='bx bx-star' style="font-size: 48px; color: #FFCC00;"></i>
      <h4>Excellence</h4>
      <p>We strive for perfection in every vehicle we sell and every service we provide.</p>
    </div>
  </div>
</section>

<!-- CTA Section -->
<section class="cta" style="background-color: #FF0000; padding: 60px 20px; text-align: center; color: white;">
  <h2>Ready to Experience the SMART CARZONE Difference?</h2>
  <p>Whether you're buying or selling, we're here to make the process simple, safe, and satisfying.</p>
  <a href="Buynow.jsp" class="beautiful-button" style="background-color: white; color: #FF0000; margin-right: 15px; text-decoration: none; display: inline-block;">Browse Inventory</a>
  <a href="sell.jsp" class="beautiful-button" style="background-color: transparent; border: 2px solid white; text-decoration: none; display: inline-block;">Sell Your Car</a>
</section>

<!-- Reuse the same footer from your main page -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>

