<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
    // Set no-cache headers
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Additional logout handling
    if ("true".equals(request.getParameter("logout"))) {
        // Extra protection - invalidate session again if somehow still exists
        HttpSession session1 = request.getSession(false);
        if (session1 != null) {
            session1.invalidate();
        }
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMART CARZONE-Second hand car sale</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@include file="navbar.jsp"%>

<!-- Hero Section -->
<div class="hero-section">
    <div class="hero-text">
        <h1><b>No More Dreaming, Start Driving - Your Perfect Car is Here!</b></h1>
        <p>Discover unbeatable value and quality with our carefully inspected secondhand cars. Experience the freedom of driving a reliable vehicle without breaking the bank.</p>
    </div>
    <div class="hero-image">
        <img src="images/BN-CIVIC.jpg" alt="Hero Image">
    </div>
</div>

<!-- Carousel Section -->
<div class="carousel-container">
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/Car%20Sale%20-%20Made%20with%20PosterMyWall.jpg" class="d-block w-100" alt="Car Sale">
            </div>
            <div class="carousel-item">
                <img src="images/banner1.png" class="d-block w-100" alt="Luxury Cars">
            </div>
            <div class="carousel-item">
                <img src="images/banner2.png" class="d-block w-100" alt="Car Promo">
            </div>
        </div>

        <!-- Indicators -->
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>

        <!-- Navigation arrows -->
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<!-- Certification Section -->
<div class="certification-section">
    <div class="certification-text">
        <h2><b>Certified Cars You Can Trust</b></h2>
        <p>Our cars undergo rigorous inspections to ensure top-notch quality and reliability. Each vehicle comes with a certification, giving you peace of mind with every purchase.</p>
        <a href="<%= request.getContextPath() %>/certified.jsp" class="beautiful-button">Learn More</a>
    </div>
    <div class="certification-image">
        <img src="images/thumbnail_large-1.jpg" alt="Certified Cars Image">
    </div>
</div>

<!-- Features Section -->
<div class="features-section">
    <div class="features-left">
        <h2><b>Discover Our Exceptional Features for a Seamless Car Buying Experience</b></h2>
    </div>
    <div class="features-right">
        <p>We offer flexible financing options to fit your budget, ensuring you drive away in your dream car. Our comprehensive warranty provides peace of mind, covering essential components for your protection. Enjoy our dedicated after-sales service, designed to assist you long after your purchase.</p>
    </div>
</div>

<!-- Services Section -->
<div class="services-section">
    <div class="services-left">
        <h2><b>Comprehensive Services for Your Vehicle Needs</b></h2>
    </div>
    <div class="services-right">
        <p>We offer a seamless trade-in process to help you upgrade your vehicle effortlessly. Our financing options are flexible, making it easier for you to drive away in your dream car. Plus, we provide detailed vehicle history reports to ensure transparency and peace of mind.</p>
    </div>
</div>

<!-- CTA Section -->
<div class="services-section">
    <div class="services-left">
        <h2><b>Car Certification Service</b></h2>
    </div>
    <div class="services-right">
        <p>"Our certification verifies your vehicle meets strict quality and safety standards, giving buyers peace of mind and increasing resale value."</p>
        <a href="<%= request.getContextPath() %>/car-details" class="rounded-btn valuation-btn">Car Certification</a>
    </div>
</div>

<!-- Features Grid -->
<section class="features">
    <div class="feature">
        <img src="images/finance1.jpg" alt="Car 1">
        <h3>Flexible Financing Options</h3>
        <p>Get the best rates and terms that will pass financial situations.</p>
    </div>
    <div class="feature">
        <img src="images/10-year-warranty.jpg" alt="Car 2">
        <h3>Extended Warranty</h3>
        <p>Our warranty covers critical arrangements, resulting your investment is safeguarded.</p>
    </div>
    <div class="feature">
        <img src="images/aftersale.jpg" alt="Car 3">
        <h3>Dedicated After-Sales Service</h3>
        <p>Our team is here to help you with my questions or concerns.</p>
    </div>
</section>

<!-- Reviews Section -->
<link rel="stylesheet" href="css/reviews.css">
<section class="reviews">
    <div class="section-title">
        <h2>What Our Customers Say</h2>
        <div class="underline"></div>
    </div>

    <div class="review-slider">
        <div class="review-track">
            <!-- Review 1 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="John D." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"Found my perfect car at SMART CARZONE! The buying process was smooth and transparent. Got a great deal on a certified pre-owned vehicle."</p>
                <h4 class="review-author">John D.</h4>
                <p class="review-position">Business Owner</p>
            </div>

            <!-- Review 2 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Sarah M." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"Excellent customer service! The team helped me find a reliable family SUV within my budget. The 360° virtual tour was incredibly helpful."</p>
                <h4 class="review-author">Sarah M.</h4>
                <p class="review-position">Marketing Director</p>
            </div>

            <!-- Review 3 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/men/67.jpg" alt="Michael T." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"Sold my car through SMART CARZONE and got 20% more than other offers. The process was quick and hassle-free. Highly recommend!"</p>
                <h4 class="review-author">Michael T.</h4>
                <p class="review-position">Software Engineer</p>
            </div>

            <!-- Review 4 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/women/28.jpg" alt="Emily R." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"As a first-time buyer, I was nervous, but the team guided me through every step. Love my car and the 7-day return policy gave me peace of mind."</p>
                <h4 class="review-author">Emily R.</h4>
                <p class="review-position">Teacher</p>
            </div>

            <!-- Review 5 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/men/52.jpg" alt="David L." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"The mobile app made car shopping so easy! Compared models, got financing approval, and scheduled test drives all from my phone."</p>
                <h4 class="review-author">David L.</h4>
                <p class="review-position">Financial Analyst</p>
            </div>

            <!-- Review 6 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Jennifer K." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"The certified pre-owned program is fantastic. The extended warranty and thorough inspection made me feel confident in my purchase."</p>
                <h4 class="review-author">Jennifer K.</h4>
                <p class="review-position">Nurse</p>
            </div>

            <!-- Review 7 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="Robert P." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"Third car I've bought from SMART CARZONE. Their loyalty program has real benefits, and they remember my preferences each time."</p>
                <h4 class="review-author">Robert P.</h4>
                <p class="review-position">Sales Manager</p>
            </div>

            <!-- Review 8 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="Lisa W." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"The financing options were the best I found. Low interest rate and flexible terms made my dream car affordable."</p>
                <h4 class="review-author">Lisa W.</h4>
                <p class="review-position">Graphic Designer</p>
            </div>

            <!-- Review 9 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="James B." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"The vehicle history reports are comprehensive. I knew exactly what I was getting. Their after-sales support is exceptional too."</p>
                <h4 class="review-author">James B.</h4>
                <p class="review-position">IT Consultant</p>
            </div>

            <!-- Review 10 -->
            <div class="review-card">
                <img src="https://randomuser.me/api/portraits/women/50.jpg" alt="Amanda S." class="profile-img">
                <div class="stars">★★★★★</div>
                <p class="review-text">"Fixed a minor issue I noticed after purchase immediately at no cost. Their commitment to customer satisfaction is impressive."</p>
                <h4 class="review-author">Amanda S.</h4>
                <p class="review-position">Small Business Owner</p>
            </div>

            <div class="review-card add-review-card">
                <div class="add-review-content">
                    <i class='bx bx-plus-circle' style="font-size: 3rem; color: #FF0000; margin-bottom: 15px;"></i>
                    <h3>Share Your Experience</h3>
                    <p>Tell us about your car buying or selling experience with SMART CARZONE</p>
                    <button class="add-review-btn" onclick="window.location.href='reviews.jsp'">Add Your Review</button>
                </div>
            </div>
        </div>

        <!-- Navigation Arrows -->
        <div class="slider-nav">
            <button id="prevBtn" disabled><i class='bx bx-chevron-left'></i></button>
            <button id="nextBtn"><i class='bx bx-chevron-right'></i></button>
        </div>

        <div class="add-review-content">
            <h3>Share Your Experience</h3>
            <p>We'd love to hear about your experience</p>
            <button class="add-review-btn" onclick="window.location.href='reviews.jsp'">Add Review</button>
        </div>
    </div>

    <!-- Dots Indicators -->
    <div class="slider-dots" id="sliderDots"></div>
</section>
<script src="js/reviews.js"></script>
<!-- Footer -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>
