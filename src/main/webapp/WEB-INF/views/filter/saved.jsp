<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.ds.LinkedList" %>
<!-- Placeholder for saved filters/favorites view -->
<html>
<head>
    <title>Saved Filters & Favorites</title>
</head>
<body>
    <h2>Saved Filters & Favorites</h2>
    <!-- Content to be implemented -->
    <img src="<%= request.getContextPath() %><% Car car=null; %>/images/<%=
            (car.getImages() != null && !car.getImages().isEmpty())
                ? car.getImages()
                : "placeholder.jpg" %>"
     class="card-img-top"
     alt="Car Image"
     style="height: 200px; object-fit: cover;">
</body>
</html> 