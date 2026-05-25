<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="login.model.User" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
    Car car = (Car) request.getAttribute("car");
    String editTimestamp = request.getParameter("timestamp");
    boolean isEdit = car != null || editTimestamp != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit Car Listing" : "Sell Your Car" %> - SMART CARZONE</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/sell.css">
</head>
<body>
<!-- Navigation -->
<%@include file="navbar.jsp"%>

<!-- Hero Section -->
<section class="sell-hero">
    <div class="container">
        <h1><%= isEdit ? "Edit Your Car Listing" : "Sell Your Car Quickly & Easily" %></h1>
        <p><%= isEdit ? "Update your car's details and images with ease" : "Get top dollar with our instant valuation service" %></p>
        <% if(isLoggedIn) { %>
        <a href="#valuation" class="beautiful-button btn-primary"><%= isEdit ? "Update Listing" : "Get Instant Valuation" %></a>
        <% } else { %>
        <a href="#signin-prompt" class="beautiful-button btn-primary">Sign In to Sell</a>
        <% } %>
    </div>
</section>

<% if(isLoggedIn) { %>
<!-- Selling Process Steps -->
<div class="container">
    <h2 class="text-center my-5" style="font-weight: 800; color: #222; font-size: 2.5rem;">How It Works</h2>
    <div class="sell-steps">
        <div class="step-card">
            <i class='bx bx-car'></i>
            <div class="step-number">1</div>
            <h3>Enter Details</h3>
            <p>Fill out our intuitive form with your car's specifications</p>
        </div>
        <div class="step-card">
            <i class='bx bx-dollar'></i>
            <div class="step-number">2</div>
            <h3>Get Valuation</h3>
            <p>Receive a competitive, real-time market valuation</p>
        </div>
        <div class="step-card">
            <i class='bx bx-check-shield'></i>
            <div class="step-number">3</div>
            <h3>Schedule Inspection</h3>
            <p>Book a convenient time for our team to verify your car</p>
        </div>
        <div class="step-card">
            <i class='bx bx-wallet'></i>
            <div class="step-number">4</div>
            <h3>Complete Sale</h3>
            <p>Get paid securely and swiftly upon sale</p>
        </div>
    </div>
</div>

<!-- Sell Your Car Form -->
<div class="container" id="valuation">
    <div class="sell-form">
        <h2 class="text-center mb-5" style="font-weight: 800; color: #222; font-size: 2.2rem; background: linear-gradient(45deg, #FF0000, #FF5555); -webkit-background-clip: text; background-clip: text; color: transparent;">Sell Your Car</h2>
        <% if (request.getParameter("success") != null) { %>
        <div class="success-message alert alert-success"><%= request.getParameter("success") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
        <div class="error-message alert alert-danger"><%= request.getParameter("error") %></div>
        <% } %>
        <form id="carSellForm" action="ProcessSell" method="POST" enctype="multipart/form-data">
            <% if (isEdit) { %>
            <input type="hidden" name="timestamp" value="<%= car != null ? car.getTimestamp() : editTimestamp %>">
            <input type="hidden" name="edit" value="true">
            <input type="hidden" name="existingImages" value="<%= car != null && car.getImages() != null ? car.getImages() : "None" %>">
            <% } %>
            <div class="form-row">
                <div class="form-group">
                    <label for="make"><i class='bx bx-car'></i> Make <span class="required">*</span></label>
                    <select id="make" name="make" class="form-control" required placeholder="Select Make">
                        <option value="">Select Make</option>
                        <option <%= car != null && "Toyota".equals(car.getMake()) ? "selected" : "" %>>Toyota</option>
                        <option <%= car != null && "Honda".equals(car.getMake()) ? "selected" : "" %>>Honda</option>
                        <option <%= car != null && "BMW".equals(car.getMake()) ? "selected" : "" %>>BMW</option>
                        <option <%= car != null && "Mercedes".equals(car.getMake()) ? "selected" : "" %>>Mercedes</option>
                        <option <%= car != null && "Audi".equals(car.getMake()) ? "selected" : "" %>>Audi</option>
                        <option <%= car != null && "Ford".equals(car.getMake()) ? "selected" : "" %>>Ford</option>
                        <option <%= car != null && "Nissan".equals(car.getMake()) ? "selected" : "" %>>Nissan</option>
                        <option <%= car != null && "Hyundai".equals(car.getMake()) ? "selected" : "" %>>Hyundai</option>
                        <option <%= car != null && "Other".equals(car.getMake()) ? "selected" : "" %>>Other</option>
                    </select>
                    <div class="form-error" id="make-error">Please select the car make.</div>
                </div>
                <div class="form-group">
                    <label for="model"><i class='bx bx-car'></i> Model <span class="required">*</span></label>
                    <input type="text" id="model" name="model" class="form-control" value="<%= car != null ? car.getModel() : "" %>" required placeholder="Enter Model">
                    <div class="form-error" id="model-error">Please enter the car model.</div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="year"><i class='bx bx-calendar'></i> Year <span class="required">*</span></label>
                    <select id="year" name="year" class="form-control" required placeholder="Select Year">
                        <option value="">Select Year</option>
                        <% for (int i = 2025; i >= 1980; i--) { %>
                        <option value="<%= i %>" <%= car != null && String.valueOf(i).equals(car.getYear()) ? "selected" : "" %>><%= i %></option>
                        <% } %>
                    </select>
                    <div class="form-error" id="year-error">Please select the year.</div>
                </div>
                <div class="form-group">
                    <label for="mileage"><i class='bx bx-tachometer'></i> Mileage (mi) <span class="required">*</span></label>
                    <input type="number" id="mileage" name="mileage" class="form-control" min="0" value="<%= car != null ? car.getMileage() : "" %>" required placeholder="Enter Mileage">
                    <div class="form-error" id="mileage-error">Please enter a valid mileage.</div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="condition"><i class='bx bx-check-circle'></i> Condition <span class="required">*</span></label>
                    <select id="condition" name="condition" class="form-control" required placeholder="Select Condition">
                        <option value="">Select Condition</option>
                        <option <%= car != null && "Excellent".equals(car.getCondition()) ? "selected" : "" %>>Excellent</option>
                        <option <%= car != null && "Good".equals(car.getCondition()) ? "selected" : "" %>>Good</option>
                        <option <%= car != null && "Fair".equals(car.getCondition()) ? "selected" : "" %>>Fair</option>
                        <option <%= car != null && "Poor".equals(car.getCondition()) ? "selected" : "" %>>Poor</option>
                    </select>
                    <div class="form-error" id="condition-error">Please select the condition.</div>
                </div>
                <div class="form-group">
                    <label for="transmission"><i class='bx bx-cog'></i> Transmission <span class="required">*</span></label>
                    <select id="transmission" name="transmission" class="form-control" required placeholder="Select Transmission">
                        <option value="">Select Transmission</option>
                        <option <%= car != null && "Automatic".equals(car.getTransmission()) ? "selected" : "" %>>Automatic</option>
                        <option <%= car != null && "Manual".equals(car.getTransmission()) ? "selected" : "" %>>Manual</option>
                    </select>
                    <div class="form-error" id="transmission-error">Please select the transmission.</div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="price"><i class='bx bx-dollar'></i> Price (Rs.) <span class="required">*</span></label>
                    <input type="number" id="price" name="price" class="form-control" min="0" step="0.01" value="<%= car != null && car.getPrice() != null ? car.getPrice() : "" %>" required placeholder="Enter Price">
                    <div class="form-error" id="price-error">Please enter a valid price.</div>
                </div>
            </div>
            <div class="form-group">
                <label><i class='bx bx-list-check'></i> Features</label>
                <div class="features-checkboxes">
                    <%
                        List<String> selectedFeatures = car != null && car.getFeatures() != null ? car.getFeatures() : Arrays.asList();
                        String[] availableFeatures = {"A/C", "ABS", "Airbags", "Alloy Wheels", "Bluetooth", "Navigation", "Power Steering", "Power Windows"};
                        int featureIndex = 1;
                        for (String feature : availableFeatures) {
                    %>
                    <div class="feature-checkbox">
                        <input type="checkbox" id="feature<%= featureIndex %>" name="features" value="<%= feature %>"
                            <%= selectedFeatures.contains(feature) ? "checked" : "" %>>
                        <label for="feature<%= featureIndex %>"><%= feature %></label>
                    </div>
                    <% featureIndex++; } %>
                </div>
            </div>
            <div class="form-group">
                <label for="description"><i class='bx bx-message-detail'></i> Description</label>
                <textarea id="description" name="description" class="form-control" rows="6" placeholder="Share your car's story..."><%= car != null && car.getDescription() != null ? car.getDescription() : "" %></textarea>
            </div>
            <div class="form-group">
                <label><i class='bx bx-image-add'></i> Upload Photos (Max 10) <span class="required">*</span></label>
                <div class="upload-area" id="uploadArea">
                    <div class="upload-icon">
                        <i class='bx bx-cloud-upload'></i>
                    </div>
                    <p>Click to upload or drag and drop</p>
                    <p class="text-muted">JPEG or PNG, max 5MB per image</p>
                    <input type="file" id="carImages" name="carImages" multiple accept=".jpg,.jpeg,.png" style="display:none;" <%= isEdit ? "" : "required" %>>
                </div>
                <div id="previewContainer" class="mt-4 d-flex flex-wrap gap-3">
                    <% if (isEdit && car != null && car.getImages() != null && !car.getImages().equals("None")) {
                        for (String image : car.getImages().split(",")) { %>
                    <div class="image-preview" style="position: relative;">
                        <img src="CarValuationImages/<%= image %>" alt="Car Image" style="width: 140px; height: 90px; object-fit: cover; border-radius: 10px; border: 2px solid rgba(255,0,0,0.2); transition: all 0.3s ease;">
                        <span class="remove-image" style="position: absolute; top: -10px; right: -10px; background: #FF0000; color: white; width: 24px; height: 24px; border-radius: 50%; text-align: center; line-height: 24px; cursor: pointer; display: none;">×</span>
                    </div>
                    <% } } %>
                </div>
                <div class="form-error" id="carImages-error">Please select valid image files (JPEG/PNG, max 5MB each).</div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="name"><i class='bx bx-user'></i> Your Name <span class="required">*</span></label>
                    <input type="text" id="name" name="name" class="form-control" value="<%= car != null ? car.getName() : (user.getFullName() != null ? user.getFullName() : "") %>" required placeholder="Enter Your Name">
                    <div class="form-error" id="name-error">Please enter your name.</div>
                </div>
                <div class="form-group">
                    <label for="email"><i class='bx bx-envelope'></i> Email <span class="required">*</span></label>
                    <input type="email" id="email" name="email" class="form-control" value="<%= car != null ? car.getEmail() : (user.getEmail() != null ? user.getEmail() : "") %>" required readonly placeholder="Enter Email">
                    <div class="form-error" id="email-error">Please enter a valid email.</div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="phone"><i class='bx bx-phone'></i> Phone <span class="required">*</span></label>
                    <input type="tel" id="phone" name="phone" class="form-control" pattern="[0-9]{10,}" value="<%= car != null ? car.getPhone() : "" %>" required placeholder="Enter Phone Number">
                    <div class="form-error" id="phone-error">Please enter a valid phone number (minimum 10 digits).</div>
                </div>
                <div class="form-group">
                    <label for="location"><i class='bx bx-map'></i> Location <span class="required">*</span></label>
                    <input type="text" id="location" name="location" class="form-control" value="<%= car != null ? car.getLocation() : "" %>" required placeholder="Enter Location">
                    <div class="form-error" id="location-error">Please enter your location.</div>
                </div>
            </div>
            <div class="text-center mt-5">
                <button type="submit" class="beautiful-button btn-primary" style="padding: 15px 60px; border-radius: 50px; font-weight: 700; font-size: 1.2rem; background: linear-gradient(45deg, #FF0000, #FF3333); box-shadow: 0 5px 15px rgba(255,0,0,0.4); transition: all 0.3s ease; display: flex; align-items: center; justify-content: center; gap: 10px;">
                    <i class='bx bx-right-arrow-alt' style="font-size: 1.5rem;"></i>
                    <%= isEdit ? "Update Listing" : "Get Instant Valuation" %>
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Why Choose Us -->
<div class="container my-5 why-choose-us">
    <h2 class="text-center mb-5" style="font-weight: 800; color: #222; font-size: 2.5rem;">Why Sell With Us?</h2>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="text-center p-5 bg-white rounded shadow-sm" style="background: linear-gradient(145deg, #ffffff, #f0f0f0); border: 1px solid rgba(255,0,0,0.1);">
                <i class='bx bx-dollar-circle' style="font-size: 3.5rem; color: #ff0000; margin-bottom: 25px;"></i>
                <h4>Top Market Prices</h4>
                <p>Our valuations are based on real-time market data for maximum value</p>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="text-center p-5 bg-white rounded shadow-sm" style="background: linear-gradient(145deg, #ffffff, #f0f0f0); border: 1px solid rgba(255,0,0,0.1);">
                <i class='bx bx-time' style="font-size: 3.5rem; color: #ff0000; margin-bottom: 25px;"></i>
                <h4>Rapid Sales</h4>
                <p>Sell your car in as little as a week with our streamlined process</p>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="text-center p-5 bg-white rounded shadow-sm" style="background: linear-gradient(145deg, #ffffff, #f0f0f0); border: 1px solid rgba(255,0,0,0.1);">
                <i class='bx bx-shield' style="font-size: 3.5rem; color: #ff0000; margin-bottom: 25px;"></i>
                <h4>Secure Payments</h4>
                <p>Receive safe, reliable payments via bank transfer or certified check</p>
            </div>
        </div>
    </div>
</div>
<% } else { %>
<!-- Sign In Prompt -->
<div class="container" id="signin-prompt">
    <div class="login-prompt">
        <div class="alert alert-warning" style="background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255,0,0,0.2);">
            <h2 style="font-weight: 800; color: #222; font-size: 2.2rem;"><i class='bx bx-lock-alt' style="margin-right: 12px; color: #FF0000;"></i>Sign In Required</h2>
            <p style="font-size: 1.1rem; color: #333;">Please sign in to access our premium car selling features.</p>
            <a href="signin.jsp?redirect=sell.jsp" class="btn btn-danger btn-login">
                <i class='bx bx-log-in' style="margin-right: 10px;"></i>Sign In Now
            </a>
            <p style="margin-top: 25px; font-size: 1rem;">
                Don't have an account? <a href="register.jsp" style="color: #FF0000; font-weight: 700;">Create one</a>
            </p>
        </div>
        <div class="sell-steps">
            <div class="step-card">
                <i class='bx bx-user-plus' style="font-size: 3rem; color: #FF0000; margin-bottom: 20px;"></i>
                <div class="step-number">1</div>
                <h3>Create Account</h3>
                <p>Sign up in minutes to start your selling journey</p>
            </div>
            <div class="step-card">
                <i class='bx bx-car' style="font-size: 3rem; color: #FF0000; margin-bottom: 20px;"></i>
                <div class="step-number">2</div>
                <h3>Start Selling</h3>
                <p>List your car instantly with our easy-to-use platform</p>
            </div>
        </div>
    </div>
</div>
<% } %>

<!-- Footer -->
<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    const form = document.getElementById('carSellForm');
    if (form) {
        form.addEventListener('submit', (e) => {
            let isValid = true;
            const fields = [
                { id: 'make', errorId: 'make-error' },
                { id: 'model', errorId: 'model-error' },
                { id: 'year', errorId: 'year-error' },
                { id: 'mileage', errorId: 'mileage-error', type: 'number' },
                { id: 'condition', errorId: 'condition-error' },
                { id: 'transmission', errorId: 'transmission-error' },
                { id: 'price', errorId: 'price-error', type: 'number' },
                { id: 'name', errorId: 'name-error' },
                { id: 'email', errorId: 'email-error', type: 'email' },
                { id: 'phone', errorId: 'phone-error', type: 'tel' },
                { id: 'location', errorId: 'location-error' },
                { id: 'carImages', errorId: 'carImages-error', type: 'file', skip: <%= isEdit %> }
            ];

            fields.forEach(field => {
                if (field.skip) return;
                const input = document.getElementById(field.id);
                const error = document.getElementById(field.errorId);

                if (!input.value.trim() ||
                    (field.type === 'number' && input.value <= 0) ||
                    (field.type === 'email' && !/^\S+@\S+\.\S+$/.test(input.value)) ||
                    (field.type === 'tel' && !/^\d{10,}$/.test(input.value)) ||
                    (field.type === 'file' && input.files.length === 0)) {
                    error.style.display = 'block';
                    error.style.animation = 'shake 0.3s ease';
                    isValid = false;
                } else {
                    error.style.display = 'none';
                }
            });

            if (!isValid) {
                e.preventDefault();
            }
        });
    }

    // Image preview and upload area interaction
    const uploadArea = document.getElementById('uploadArea');
    const carImagesInput = document.getElementById('carImages');
    const previewContainer = document.getElementById('previewContainer');
    const maxFileSize = 5 * 1024 * 1024; // 5MB
    const maxFiles = 10;

    if (uploadArea && carImagesInput) {
        uploadArea.addEventListener('click', () => carImagesInput.click());
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#FF0000';
            uploadArea.style.background = 'rgba(255,245,245,0.95)';
            uploadArea.style.transform = 'scale(1.02)';
        });
        uploadArea.addEventListener('dragleave', () => {
            uploadArea.style.borderColor = 'rgba(255,0,0,0.4)';
            uploadArea.style.background = 'rgba(255,255,255,0.85)';
            uploadArea.style.transform = 'scale(1)';
        });
        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = 'rgba(255,0,0,0.4)';
            uploadArea.style.background = 'rgba(255,255,255,0.85)';
            uploadArea.style.transform = 'scale(1)';
            carImagesInput.files = e.dataTransfer.files;
            carImagesInput.dispatchEvent(new Event('change'));
        });

        carImagesInput.addEventListener('change', () => {
            previewContainer.innerHTML = '';
            const files = carImagesInput.files;
            const error = document.getElementById('carImages-error');

            if (files.length > maxFiles) {
                error.textContent = `Please select up to ${maxFiles} images.`;
                error.style.display = 'block';
                error.style.animation = 'shake 0.3s ease';
                carImagesInput.value = '';
                return;
            }

            let validFiles = true;
            Array.from(files).forEach(file => {
                if (!file.type.match('image/(jpeg|png)')) {
                    validFiles = false;
                    error.textContent = 'Only JPEG and PNG images are allowed.';
                    error.style.display = 'block';
                    error.style.animation = 'shake 0.3s ease';
                } else if (file.size > maxFileSize) {
                    validFiles = false;
                    error.textContent = 'Each image must be less than 5MB.';
                    error.style.display = 'block';
                    error.style.animation = 'shake 0.3s ease';
                } else {
                    const previewDiv = document.createElement('div');
                    previewDiv.className = 'image-preview';
                    previewDiv.style.position = 'relative';
                    previewDiv.style.animation = 'slideIn 0.5s ease';
                    const img = document.createElement('img');
                    img.src = URL.createObjectURL(file);
                    img.style.width = '140px';
                    img.style.height = '90px';
                    img.style.objectFit = 'cover';
                    img.style.borderRadius = '10px';
                    img.style.border = '2px solid rgba(255,0,0,0.2)';
                    img.style.transition = 'all 0.3s ease';
                    img.addEventListener('mouseover', () => {
                        img.style.transform = 'scale(1.1)';
                        img.style.boxShadow = '0 5px 15px rgba(255,0,0,0.3)';
                    });
                    img.addEventListener('mouseout', () => {
                        img.style.transform = 'scale(1)';
                        img.style.boxShadow = 'none';
                    });
                    previewDiv.appendChild(img);
                    previewContainer.appendChild(previewDiv);
                }
            });

            if (!validFiles) {
                carImagesInput.value = '';
                previewContainer.innerHTML = '';
            } else {
                error.style.display = 'none';
            }
        });
    }
</script>
</body>
</html>