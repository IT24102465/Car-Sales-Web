<%--
  Created by IntelliJ IDEA.
  User: OSHADHA
  Date: 4/8/2025
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Privacy Policy - SMART CARZONE</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- Reuse the same navbar from your main page -->
<%@include file="navbar.jsp"%>

<!-- Privacy Hero Section -->
<section class="privacy-hero">
  <h1>Privacy Policy</h1>
  <p>Your privacy is important to us. Learn how we collect, use, and protect your information.</p>
</section>

<!-- Main Privacy Container -->
<div class="privacy-container">
  <div class="last-updated">
    Last Updated: June 10, 2023
  </div>

  <!-- Table of Contents -->
  <div class="toc">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#introduction">1. Introduction</a></li>
      <li><a href="#definitions">2. Definitions</a></li>
      <li><a href="#data-collection">3. Information We Collect</a></li>
      <li><a href="#how-we-use">4. How We Use Your Information</a></li>
      <li><a href="#data-sharing">5. Sharing of Information</a></li>
      <li><a href="#data-security">6. Data Security</a></li>
      <li><a href="#data-retention">7. Data Retention</a></li>
      <li><a href="#cookies">8. Cookies and Tracking</a></li>
      <li><a href="#user-rights">9. Your Rights</a></li>
      <li><a href="#children">10. Children's Privacy</a></li>
      <li><a href="#third-party">11. Third-Party Links</a></li>
      <li><a href="#international">12. International Transfers</a></li>
      <li><a href="#changes">13. Changes to This Policy</a></li>
      <li><a href="#contact">14. Contact Us</a></li>
    </ul>
  </div>

  <!-- Privacy Sections -->
  <div class="privacy-section" id="introduction">
    <h2>1. Introduction</h2>
    <p>SMART CARZONE ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website or use our services.</p>

    <div class="highlight-box">
      <p><strong>Important:</strong> By accessing or using our services, you agree to the collection and use of information in accordance with this policy. If you do not agree with our policies and practices, please do not use our services.</p>
    </div>
  </div>

  <div class="privacy-section" id="definitions">
    <h2>2. Definitions</h2>
    <p>In this Privacy Policy:</p>
    <ul>
      <li><strong>"Personal Data"</strong> means any information relating to an identified or identifiable individual.</li>
      <li><strong>"Processing"</strong> means any operation performed on Personal Data.</li>
      <li><strong>"Data Subject"</strong> means the individual to whom Personal Data relates.</li>
      <li><strong>"Cookies"</strong> are small data files stored on your device.</li>
      <li><strong>"Service Providers"</strong> are third parties who process data on our behalf.</li>
    </ul>
  </div>

  <div class="privacy-section" id="data-collection">
    <h2>3. Information We Collect</h2>
    <p>We collect several types of information from and about users of our services:</p>

    <div class="data-types">
      <div class="data-type">
        <h4>Personal Information</h4>
        <ul>
          <li>Name and contact details</li>
          <li>Email address and phone number</li>
          <li>Payment information</li>
          <li>Government-issued ID (for verification)</li>
        </ul>
      </div>

      <div class="data-type">
        <h4>Vehicle Information</h4>
        <ul>
          <li>Vehicle identification number (VIN)</li>
          <li>Make, model, and year</li>
          <li>Mileage and condition</li>
          <li>Service history</li>
        </ul>
      </div>

      <div class="data-type">
        <h4>Technical Data</h4>
        <ul>
          <li>IP address and device information</li>
          <li>Browser type and version</li>
          <li>Pages visited and time spent</li>
          <li>Cookies and tracking data</li>
        </ul>
      </div>
    </div>

    <h3>3.1 How We Collect Information</h3>
    <p>We collect information through:</p>
    <ul>
      <li>Direct interactions (forms, registrations, communications)</li>
      <li>Automated technologies (cookies, server logs)</li>
      <li>Third parties (payment processors, analytics providers)</li>
      <li>Publicly available sources</li>
    </ul>
  </div>

  <div class="privacy-section" id="how-we-use">
    <h2>4. How We Use Your Information</h2>
    <p>We use the information we collect for the following purposes:</p>
    <ul>
      <li>To provide and maintain our services</li>
      <li>To process transactions and send notifications</li>
      <li>To verify user identities and prevent fraud</li>
      <li>To improve our website and services</li>
      <li>To develop new products and features</li>
      <li>To communicate with users</li>
      <li>To comply with legal obligations</li>
      <li>To protect our rights and property</li>
    </ul>

    <h3>4.1 Legal Basis for Processing</h3>
    <p>We process Personal Data based on:</p>
    <ul>
      <li>Your consent</li>
      <li>The performance of a contract</li>
      <li>Our legitimate business interests</li>
      <li>Compliance with legal obligations</li>
    </ul>
  </div>

  <div class="privacy-section" id="data-sharing">
    <h2>5. Sharing of Information</h2>
    <p>We may share your information in the following circumstances:</p>

    <div class="data-types">
      <div class="data-type">
        <h4>Service Providers</h4>
        <p>We share data with trusted partners who assist us in operating our website, conducting business, or servicing users.</p>
      </div>

      <div class="data-type">
        <h4>Business Transfers</h4>
        <p>In connection with any merger, sale of company assets, or acquisition.</p>
      </div>

      <div class="data-type">
        <h4>Legal Requirements</h4>
        <p>When required by law or to respond to legal process.</p>
      </div>
    </div>

    <h3>5.1 Third-Party Services</h3>
    <p>We use the following categories of third-party services:</p>
    <ul>
      <li>Payment processors</li>
      <li>Analytics providers</li>
      <li>Marketing platforms</li>
      <li>Customer support tools</li>
      <li>Cloud service providers</li>
    </ul>
  </div>

  <div class="privacy-section" id="data-security">
    <h2>6. Data Security</h2>
    <p>We implement appropriate technical and organizational measures to protect your Personal Data, including:</p>
    <ul>
      <li>SSL/TLS encryption for data transmission</li>
      <li>Regular security assessments</li>
      <li>Access controls and authentication</li>
      <li>Employee training on data protection</li>
    </ul>

    <div class="highlight-box">
      <p><strong>Note:</strong> While we strive to protect your information, no electronic transmission or storage method is 100% secure. We cannot guarantee absolute security.</p>
    </div>
  </div>

  <div class="privacy-section" id="data-retention">
    <h2>7. Data Retention</h2>
    <p>We retain Personal Data only as long as necessary for the purposes outlined in this policy, including:</p>
    <ul>
      <li>To fulfill the purposes for which it was collected</li>
      <li>To comply with legal obligations</li>
      <li>To resolve disputes</li>
      <li>To enforce our agreements</li>
    </ul>
    <p>Typical retention periods:</p>
    <ul>
      <li>Account data: 5 years after last activity</li>
      <li>Transaction records: 7 years for tax purposes</li>
      <li>Marketing data: 2 years from last interaction</li>
    </ul>
  </div>

  <div class="privacy-section" id="cookies">
    <h2>8. Cookies and Tracking</h2>
    <p>We use cookies and similar tracking technologies to:</p>
    <ul>
      <li>Remember user preferences</li>
      <li>Analyze website traffic</li>
      <li>Deliver targeted advertisements</li>
      <li>Improve user experience</li>
    </ul>

    <h3>8.1 Types of Cookies</h3>
    <table class="cookie-table">
      <tr>
        <th>Cookie Type</th>
        <th>Purpose</th>
        <th>Duration</th>
      </tr>
      <tr>
        <td>Essential Cookies</td>
        <td>Necessary for website functionality</td>
        <td>Session</td>
      </tr>
      <tr>
        <td>Performance Cookies</td>
        <td>Collect anonymous usage data</td>
        <td>1 year</td>
      </tr>
      <tr>
        <td>Functionality Cookies</td>
        <td>Remember user preferences</td>
        <td>1 year</td>
      </tr>
      <tr>
        <td>Targeting Cookies</td>
        <td>Used for advertising</td>
        <td>6 months</td>
      </tr>
    </table>

    <h3>8.2 Cookie Management</h3>
    <p>You can control cookies through your browser settings. However, disabling cookies may affect website functionality.</p>
  </div>

  <div class="privacy-section" id="user-rights">
    <h2>9. Your Rights</h2>
    <p>Depending on your jurisdiction, you may have the following rights regarding your Personal Data:</p>

    <div class="rights-list">
      <div class="right-item">
        <h4>Access</h4>
        <p>Request a copy of your Personal Data we hold.</p>
      </div>

      <div class="right-item">
        <h4>Rectification</h4>
        <p>Request correction of inaccurate data.</p>
      </div>

      <div class="right-item">
        <h4>Erasure</h4>
        <p>Request deletion of your Personal Data.</p>
      </div>

      <div class="right-item">
        <h4>Restriction</h4>
        <p>Request limitation of processing.</p>
      </div>

      <div class="right-item">
        <h4>Portability</h4>
        <p>Request transfer of your data to another service.</p>
      </div>

      <div class="right-item">
        <h4>Objection</h4>
        <p>Object to certain processing activities.</p>
      </div>
    </div>

    <p>To exercise these rights, please contact us using the information in Section 14.</p>
  </div>

  <div class="privacy-section" id="children">
    <h2>10. Children's Privacy</h2>
    <p>Our services are not directed to children under 16. We do not knowingly collect Personal Data from children under 16. If we become aware that we have collected Personal Data from a child without parental consent, we will take steps to remove that information.</p>
  </div>

  <div class="privacy-section" id="third-party">
    <h2>11. Third-Party Links</h2>
    <p>Our website may contain links to third-party websites. We are not responsible for the privacy practices or content of these external sites. We encourage you to review the privacy policies of any website you visit.</p>
  </div>

  <div class="privacy-section" id="international">
    <h2>12. International Transfers</h2>
    <p>Your information may be transferred to and maintained on computers located outside of your country, where data protection laws may differ. We ensure appropriate safeguards are in place for such transfers.</p>
  </div>

  <div class="privacy-section" id="changes">
    <h2>13. Changes to This Policy</h2>
    <p>We may update this Privacy Policy periodically. We will notify you of significant changes by posting the new policy on our website and updating the "Last Updated" date. Your continued use of our services after such changes constitutes acceptance of the new policy.</p>
  </div>

  <div class="privacy-section" id="contact">
    <h2>14. Contact Us</h2>
    <p>If you have questions about this Privacy Policy or wish to exercise your rights, please contact us:</p>
    <p><strong>Data Protection Officer</strong><br>
      SMART CARZONE<br>
      130B, Pannipittya Road,<br>
      Battaramulla, Sri Lanka.<br>
      Email: privacy@smartcarzone.lk<br>
      Phone: 011 1234 506</p>
  </div>

  <div class="back-to-top">
    <a href="#top">Back to Top ↑</a>
  </div>
</div>

<!-- Reuse the same footer from your main page -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>

