<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us - SMART CARZONE</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- Reuse the same navbar from your main page -->
<%@include file="navbar.jsp"%>

<!-- Contact Hero Section -->
<section class="contact-hero">
  <h1>We're Here to Help</h1>
  <p>Have questions about buying or selling a car? Our team is ready to assist you.</p>
</section>

<!-- Main Contact Container -->
<div class="contact-container">
  <!-- Contact Information -->
  <div class="contact-info">
    <h2>Contact Information</h2>

    <div class="contact-method">
      <div class="contact-icon">
        <i class='bx bx-map'></i>
      </div>
      <div>
        <h4>Visit Us</h4>
        <p>130B, Pannipittya Road,<br>Battaramulla, Sri Lanka.</p>
      </div>
    </div>

    <div class="contact-method">
      <div class="contact-icon">
        <i class='bx bx-phone'></i>
      </div>
      <div>
        <h4>Call Us</h4>
        <p>Phone: 011 1234 500<br>
          Hotline: 071 2345 678<br>
          Fax: 011 1234 501</p>
      </div>
    </div>

    <div class="contact-method">
      <div class="contact-icon">
        <i class='bx bx-envelope'></i>
      </div>
      <div>
        <h4>Email Us</h4>
        <p>General Inquiries: info@smartcarzone.lk<br>
          Sales: sales@smartcarzone.lk<br>
          Support: support@smartcarzone.lk</p>
      </div>
    </div>

    <div class="business-hours">
      <h3>Business Hours</h3>
      <table>
        <tr>
          <th>Day</th>
          <th>Hours</th>
        </tr>
        <tr>
          <td>Monday - Friday</td>
          <td>8:30 AM - 6:00 PM</td>
        </tr>
        <tr>
          <td>Saturday</td>
          <td>9:00 AM - 5:00 PM</td>
        </tr>
        <tr>
          <td>Sunday</td>
          <td>10:00 AM - 4:00 PM</td>
        </tr>
        <tr>
          <td>Public Holidays</td>
          <td>10:00 AM - 2:00 PM</td>
        </tr>
      </table>
    </div>

    <div style="margin-top: 30px;">
      <h3>Follow Us</h3>
      <div style="display: flex; gap: 15px; margin-top: 15px;">
        <a href="#" style="color: #007bff; font-size: 24px;"><i class='bx bxl-facebook'></i></a>
        <a href="#" style="color: #FF0000; font-size: 24px;"><i class='bx bxl-instagram'></i></a>
        <a href="#" style="color: #007bff; font-size: 24px;"><i class='bx bxl-linkedin'></i></a>
      </div>
    </div>
  </div>

  <!-- Contact Form -->
  <div class="contact-form">
    <h2>Send Us a Message</h2>
    <p>Have questions or need assistance? Fill out the form below and we'll get back to you within 24 hours.</p>

    <form id="contactForm">
      <div class="form-group">
        <label for="name">Full Name*</label>
        <input type="text" id="name" name="name" required>
      </div>

      <div class="form-group">
        <label for="email">Email Address*</label>
        <input type="email" id="email" name="email" required>
      </div>

      <div class="form-group">
        <label for="phone">Phone Number</label>
        <input type="tel" id="phone" name="phone">
      </div>

      <div class="form-group">
        <label for="subject">Subject*</label>
        <select id="subject" name="subject" required>
          <option value="">Select a subject</option>
          <option value="general">General Inquiry</option>
          <option value="sales">Car Sales</option>
          <option value="sell-car">Sell My Car</option>
          <option value="test-drive">Schedule Test Drive</option>
          <option value="finance">Financing Options</option>
          <option value="service">After-Sales Service</option>
          <option value="warranty">Warranty Information</option>
          <option value="other">Other</option>
        </select>
      </div>

      <div class="form-group">
        <label for="message">Your Message*</label>
        <textarea id="message" name="message" required></textarea>
      </div>

      <button type="submit" class="submit-btn">Send Message</button>
    </form>
  </div>
</div>

<!-- Google Map -->
<div class="map-container">
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798511757686!2d79.9194143147204!3d6.914629495003807!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae256db1a6771c5%3A0x2c63e344ab9a7536!2sBattaramulla!5e0!3m2!1sen!2slk!4v1620000000000!5m2!1sen!2slk" allowfullscreen="" loading="lazy"></iframe>
</div>

<!-- Departments Contact -->
<div class="contact-departments">
  <div class="department">
    <h3>Sales Department</h3>
    <p><i class='bx bx-phone'></i> 011 1234 502</p>
    <p><i class='bx bx-envelope'></i> sales@smartcarzone.lk</p>
    <p>Interested in purchasing a vehicle? Our sales team can help you find the perfect car for your needs and budget.</p>
  </div>

  <div class="department">
    <h3>Vehicle Appraisals</h3>
    <p><i class='bx bx-phone'></i> 011 1234 503</p>
    <p><i class='bx bx-envelope'></i> appraisals@smartcarzone.lk</p>
    <p>Looking to sell your car? Get a free, no-obligation valuation from our expert appraisers.</p>
  </div>

  <div class="department">
    <h3>Customer Service</h3>
    <p><i class='bx bx-phone'></i> 011 1234 504</p>
    <p><i class='bx bx-envelope'></i> support@smartcarzone.lk</p>
    <p>Need assistance with your purchase or have questions about our services? Our customer service team is here to help.</p>
  </div>

  <div class="department">
    <h3>Finance Department</h3>
    <p><i class='bx bx-phone'></i> 011 1234 505</p>
    <p><i class='bx bx-envelope'></i> finance@smartcarzone.lk</p>
    <p>Explore flexible financing options and payment plans tailored to your budget with our finance specialists.</p>
  </div>
</div>
<!-- FAQ Section -->
<div class="faq-section">
  <h2 style="text-align: center; margin-bottom: 30px;">Frequently Asked Questions</h2>

  <div class="faq-item">
    <div class="faq-question">
      <span>How do I schedule a test drive?</span>
      <i class='bx bx-chevron-down'></i>
    </div>
    <div class="faq-answer">
      <p>You can schedule a test drive by calling our sales department at 011 1234 502 or by filling out the contact form above. Please let us know which vehicle you're interested in and your preferred date and time.</p>
    </div>
  </div>

  <div class="faq-item">
    <div class="faq-question">
      <span>What documents do I need to sell my car?</span>
      <i class='bx bx-chevron-down'></i>
    </div>
    <div class="faq-answer">
      <p>To sell your car, you'll need the original vehicle registration certificate, your national ID or passport, and any service history records you may have. Our team will guide you through the entire process.</p>
    </div>
  </div>

  <div class="faq-item">
    <div class="faq-question">
      <span>Do you offer financing options?</span>
      <i class='bx bx-chevron-down'></i>
    </div>
    <div class="faq-answer">
      <p>Yes, we work with multiple banks and financial institutions to offer competitive financing options. Our finance team can help you find a payment plan that fits your budget.</p>
    </div>
  </div>

  <div class="faq-item">
    <div class="faq-question">
      <span>What is your warranty policy?</span>
      <i class='bx bx-chevron-down'></i>
    </div>
    <div class="faq-answer">
      <p>All our certified pre-owned vehicles come with a comprehensive warranty that covers major components for 12 months or 20,000 km, whichever comes first. Additional extended warranty options are also available.</p>
    </div>
  </div>

  <div class="faq-item">
    <div class="faq-question">
      <span>How long does the car buying process take?</span>
      <i class='bx bx-chevron-down'></i>
    </div>
    <div class="faq-answer">
      <p>For cash purchases, the process can be completed in as little as one day. If you're financing the vehicle, it typically takes 2-3 business days for loan approval and processing.</p>
    </div>
  </div>
</div>
<script src="js/script.js"></script>

<!-- CTA Section -->
<section style="background-color: #FF0000; padding: 60px 20px; text-align: center; color: white;">
  <h2>Can't Find What You're Looking For?</h2>
  <p style="max-width: 800px; margin: 0 auto 30px;">Our customer service team is available to answer any questions you may have about buying or selling a vehicle with SMART CARZONE.</p>
  <button class="beautiful-button" style="background-color: white; color: #FF0000; margin-right: 15px;">Call Us Now</button>
  <button class="beautiful-button" style="background-color: transparent; border: 2px solid white;">Live Chat</button>
</section>

<!-- Reuse the same footer from your main page -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>

