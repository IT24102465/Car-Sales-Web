<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%
    Car car = (Car) request.getAttribute("car");
    String success = request.getParameter("success");
    String error = (String) request.getAttribute("error");
%>
<html>
<head>
    <title>View Car</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/sell.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= request.getContextPath() %>">
<jsp:include page="adminNavbar.jsp"/>

<div class="container" id="valuation">
    <div class="sell-form">
        <h2 class="text-center mb-5" style="font-weight: 800; font-size: 2.2rem; background: linear-gradient(45deg, #FF0000, #FF5555); -webkit-background-clip: text; background-clip: text; color: transparent;">Car Details</h2>

        <!-- Car Info -->
        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-car'></i> Make:</label>
                <p><%= car.getMake() %></p>
            </div>
            <div class="form-group">
                <label><i class='bx bx-car'></i> Model:</label>
                <p><%= car.getModel() %></p>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-calendar'></i> Year:</label>
                <p><%= car.getYear() %></p>
            </div>
            <div class="form-group">
                <label><i class='bx bx-tachometer'></i> Mileage:</label>
                <p><%= car.getMileage() %> mi</p>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-check-circle'></i> Condition:</label>
                <p><%= car.getCondition() %></p>
            </div>
            <div class="form-group">
                <label><i class='bx bx-cog'></i> Transmission:</label>
                <p><%= car.getTransmission() %></p>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-dollar'></i> Price:</label>
                <p>Rs. <%= car.getPrice() %></p>
            </div>
        </div>

        <!-- Features -->
        <div class="form-group">
            <label><i class='bx bx-list-check'></i> Features:</label>
            <ul>
                <%
                    List<String> selectedFeatures = car != null && car.getFeatures() != null ? car.getFeatures() : Arrays.asList();
                    for (String feature : selectedFeatures) {
                %>
                <li><i class='bx bx-check'></i> <%= feature %></li>
                <% } %>
            </ul>
        </div>

        <!-- Description -->
        <div class="form-group">
            <label><i class='bx bx-message-detail'></i> Description:</label>
            <p><%= car.getDescription() %></p>
        </div>

        <!-- Car Image -->
        <div class="form-group">
            <label><i class='bx bx-image'></i> Image:</label>
            <div class="admin-image-wrapper">
                <img src="UploadCarImages/<%= car.getImages() %>" alt="Car Image" style="width: 300px; border-radius: 10px;">
            </div>
        </div>

        <!-- Seller Info -->
        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-user'></i> Seller Name:</label>
                <p><%= car.getName() %></p>
            </div>
            <div class="form-group">
                <label><i class='bx bx-envelope'></i> Email:</label>
                <p><%= car.getEmail() %></p>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label><i class='bx bx-phone'></i> Phone:</label>
                <p><%= car.getPhone() %></p>
            </div>
            <div class="form-group">
                <label><i class='bx bx-map'></i> Location:</label>
                <p><%= car.getLocation() %></p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
