<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.util.CarLoader" %>
<%@ page import="filter.util.CarImageResolver" %>
<%@ page import="filter.util.CarImageOverrideUrls" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Car Listing | SMART CARZONE</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<%= ctx %>/css/admin.css">
</head>
<body class="admin-page" data-ctx="<%= ctx %>">
<jsp:include page="adminNavbar.jsp"/>
<div class="container admin-content">
  <div class="header">
    <h1>Car Listing</h1>
    <span class="text-muted">Same inventory as Buy Now page</span>
  </div>

  <h2>Current Car Advertisements (<%= request.getAttribute("carList") != null ? ((List<Car>) request.getAttribute("carList")).size() : 0 %>)</h2>
  <table>
    <thead>
    <tr>
      <th>Image</th>
      <th>Make</th>
      <th>Model</th>
      <th>Year</th>
      <th>Condition</th>
      <th>Transmission</th>
      <th>Location</th>
      <th>Price (Rs.)</th>
      <th>Seller</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      List<Car> currentCars = (List<Car>) request.getAttribute("carList");
      if (currentCars != null && !currentCars.isEmpty()) {
        for (Car car : currentCars) {
            String imageUrl = CarLoader.resolveImagePath(ctx, car.getImages(), car);
            String fixedSrc = CarImageOverrideUrls.proxySrc(ctx, car);
            boolean useFixedImage = fixedSrc != null;
    %>
    <tr>
      <td><img class="profile car-card-img car-web-photo" src="<%= imageUrl %>" alt="<%= car.getMake() %> <%= car.getModel() %>"
             referrerpolicy="no-referrer"
             data-make="<%= car.getMake() %>" data-model="<%= car.getModel() %>"
             data-search-make="<%= CarImageResolver.getSearchMake(car) %>"
             data-search-model="<%= CarImageResolver.getSearchModel(car) %>"
             data-year="<%= car.getYear() %>"
             data-car-id="<%= car.getTimestamp() %>"
             <% if (useFixedImage) { %>data-fixed-image="<%= fixedSrc %>"<% } %>/></td>
      <td><%= car.getMake() %></td>
      <td><%= car.getModel() %></td>
      <td><%= car.getYear() %></td>
      <td><%= car.getCondition() %></td>
      <td><%= car.getTransmission() %></td>
      <td><%= car.getLocation() %></td>
      <td><%= car.getPrice() %></td>
      <td><%= car.getName() %></td>
      <td>
        <form method="get" action="<%= ctx %>/viewCar" style="display:inline;">
          <input type="hidden" name="identifier" value="<%= car.getTimestamp() %>">
          <button type="submit" class="view-button">View</button>
        </form>
        <form method="post" action="<%= ctx %>/deleteCar" style="display:inline;">
          <input type="hidden" name="identifier" value="<%= car.getTimestamp() %>">
          <button type="submit" class="delete-button" onclick="return confirm('Are you sure you want to delete this car?');">Delete</button>
        </form>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr><td colspan="10">No cars found.</td></tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
<jsp:include page="/car-image-config.jsp"/>
<script src="<%= ctx %>/js/car-image-loader.js"></script>
</body>
</html>
