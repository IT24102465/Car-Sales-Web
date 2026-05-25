<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.ds.LinkedList" %>
<%@ page import="filter.manager.SearchManager" %>
<%@ page import="filter.model.CarFilter" %>
<%@ page import="filter.util.BuyNowHelper" %>
<%
    String selectedMake = request.getParameter("make");
    if (selectedMake == null) selectedMake = "";
    String selectedModel = request.getParameter("model");
    if (selectedModel == null) selectedModel = "";
    String selectedTransmission = request.getParameter("transmission");
    if (selectedTransmission == null) selectedTransmission = "";
    String selectedMinYear = request.getParameter("minYear");
    if (selectedMinYear == null) selectedMinYear = "";
    String selectedMaxYear = request.getParameter("maxYear");
    if (selectedMaxYear == null) selectedMaxYear = "";
    String selectedMinPrice = request.getParameter("minPrice");
    if (selectedMinPrice == null) selectedMinPrice = "";
    String selectedMaxPrice = request.getParameter("maxPrice");
    if (selectedMaxPrice == null) selectedMaxPrice = "";
    String sortByPrice = request.getParameter("sortByPrice");
    boolean sortSelected = "true".equalsIgnoreCase(sortByPrice);

    if (request.getAttribute("cars") == null) {
        CarFilter defaultFilter = new CarFilter();
        LinkedList<Car> allCars = SearchManager.search(defaultFilter, sortSelected, application);
        request.setAttribute("cars", allCars);
        request.setAttribute("favoriteIds", BuyNowHelper.loadFavoriteIds(request, application));
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Now - SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/filter/filter.css">
</head>
<body>

<%@include file="navbar.jsp" %>

<section class="hero-section text-center">
    <div class="container">
        <h1 class="hero-title animate__animated animate__fadeInDown">Find Your Perfect Car</h1>
        <p class="lead animate__animated animate__fadeIn animate__delay-1s">Browse our extensive collection of quality pre-owned vehicles</p>
        <a href="#car-filters" class="btn btn-danger btn-lg mt-3 animate__animated animate__fadeInUp animate__delay-1s">
            <i class='bx bx-car'></i> View Inventory
        </a>
    </div>
</section>

<div class="container my-5" id="car-filters">
    <h2><i class='bx bx-filter-alt'></i> Search & Filter Cars</h2>

    <form action="<%= request.getContextPath() %>/search" method="get">
        <div class="row g-3 mb-3">
            <div class="col-md-3">
                <label class="form-label" for="filter-make">Make</label>
                <select class="form-select" id="filter-make" name="make">
                    <option value="" <%= selectedMake.isEmpty() ? "selected" : "" %>>All Makes</option>
                    <option value="Toyota" <%= "Toyota".equals(selectedMake) ? "selected" : "" %>>Toyota</option>
                    <option value="Honda" <%= "Honda".equals(selectedMake) ? "selected" : "" %>>Honda</option>
                    <option value="BMW" <%= "BMW".equals(selectedMake) ? "selected" : "" %>>BMW</option>
                    <option value="Mercedes" <%= "Mercedes".equals(selectedMake) ? "selected" : "" %>>Mercedes</option>
                    <option value="Audi" <%= "Audi".equals(selectedMake) ? "selected" : "" %>>Audi</option>
                    <option value="Ford" <%= "Ford".equals(selectedMake) ? "selected" : "" %>>Ford</option>
                    <option value="Nissan" <%= "Nissan".equals(selectedMake) ? "selected" : "" %>>Nissan</option>
                    <option value="Hyundai" <%= "Hyundai".equals(selectedMake) ? "selected" : "" %>>Hyundai</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="filter-model">Model</label>
                <select class="form-select" id="filter-model" name="model" data-selected="<%= selectedModel %>">
                    <option value="" <%= selectedModel.isEmpty() ? "selected" : "" %>>Any Model</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="minYear">Min Year</label>
                <select class="form-select" id="minYear" name="minYear">
                    <option value="" <%= selectedMinYear.isEmpty() ? "selected" : "" %>>Any</option>
                    <% for (int y = 2025; y >= 1990; y--) { %>
                    <option value="<%= y %>" <%= String.valueOf(y).equals(selectedMinYear) ? "selected" : "" %>><%= y %></option>
                    <% } %>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="maxYear">Max Year</label>
                <select class="form-select" id="maxYear" name="maxYear">
                    <option value="" <%= selectedMaxYear.isEmpty() ? "selected" : "" %>>Any</option>
                    <% for (int y = 2025; y >= 1990; y--) { %>
                    <option value="<%= y %>" <%= String.valueOf(y).equals(selectedMaxYear) ? "selected" : "" %>><%= y %></option>
                    <% } %>
                </select>
            </div>
        </div>

        <div class="row g-3 mb-3">
            <div class="col-md-3">
                <label class="form-label" for="minPrice">Min Price (Rs.)</label>
                <select class="form-select" id="minPrice" name="minPrice">
                    <option value="" <%= selectedMinPrice.isEmpty() ? "selected" : "" %>>Any</option>
                    <option value="10000" <%= "10000".equals(selectedMinPrice) ? "selected" : "" %>>10,000</option>
                    <option value="20000" <%= "20000".equals(selectedMinPrice) ? "selected" : "" %>>20,000</option>
                    <option value="23000" <%= "23000".equals(selectedMinPrice) ? "selected" : "" %>>23,000</option>
                    <option value="30000" <%= "30000".equals(selectedMinPrice) ? "selected" : "" %>>30,000</option>
                    <option value="34000" <%= "34000".equals(selectedMinPrice) ? "selected" : "" %>>34,000</option>
                    <option value="45000" <%= "45000".equals(selectedMinPrice) ? "selected" : "" %>>45,000</option>
                    <option value="50000" <%= "50000".equals(selectedMinPrice) ? "selected" : "" %>>50,000</option>
                    <option value="100000" <%= "100000".equals(selectedMinPrice) ? "selected" : "" %>>100,000</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="maxPrice">Max Price (Rs.)</label>
                <select class="form-select" id="maxPrice" name="maxPrice">
                    <option value="" <%= selectedMaxPrice.isEmpty() ? "selected" : "" %>>Any</option>
                    <option value="23000" <%= "23000".equals(selectedMaxPrice) ? "selected" : "" %>>23,000</option>
                    <option value="30000" <%= "30000".equals(selectedMaxPrice) ? "selected" : "" %>>30,000</option>
                    <option value="34000" <%= "34000".equals(selectedMaxPrice) ? "selected" : "" %>>34,000</option>
                    <option value="45000" <%= "45000".equals(selectedMaxPrice) ? "selected" : "" %>>45,000</option>
                    <option value="56000" <%= "56000".equals(selectedMaxPrice) ? "selected" : "" %>>56,000</option>
                    <option value="100000" <%= "100000".equals(selectedMaxPrice) ? "selected" : "" %>>100,000</option>
                    <option value="500000" <%= "500000".equals(selectedMaxPrice) ? "selected" : "" %>>500,000</option>
                    <option value="1000000" <%= "1000000".equals(selectedMaxPrice) ? "selected" : "" %>>1,000,000+</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="transmission">Transmission</label>
                <select class="form-select" id="transmission" name="transmission">
                    <option value="" <%= selectedTransmission.isEmpty() ? "selected" : "" %>>Any</option>
                    <option value="Automatic" <%= "Automatic".equals(selectedTransmission) ? "selected" : "" %>>Automatic</option>
                    <option value="Manual" <%= "Manual".equals(selectedTransmission) ? "selected" : "" %>>Manual</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="sortByPrice">Sort By</label>
                <select class="form-select" id="sortByPrice" name="sortByPrice">
                    <option value="" <%= !sortSelected ? "selected" : "" %>>Default</option>
                    <option value="true" <%= sortSelected ? "selected" : "" %>>Price: Low to High</option>
                </select>
            </div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-danger me-2">
                <i class='bx bx-search'></i> Apply Filters
            </button>
            <a href="<%= request.getContextPath() %>/Buynow.jsp" class="btn btn-outline-secondary">
                <i class='bx bx-reset'></i> Reset
            </a>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/filter/car-results.jsp" />

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/car-image-config.jsp"/>
<script src="<%= request.getContextPath() %>/js/car-image-loader.js"></script>
<script src="js/filter/filter.js"></script>
<% if (Boolean.TRUE.equals(request.getAttribute("searched"))) { %>
<script>
    document.getElementById('search-results')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
</script>
<% } %>
</body>
</html>
