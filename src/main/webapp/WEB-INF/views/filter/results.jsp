<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.ds.LinkedList" %>
<%@ page import="java.util.HashSet" %>

<html>
<head>
    <title>Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/filter/filter.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        .favorite-btn {
            background: none;
            border: none;
            color: #dc3545;
            font-size: 24px;
            transition: transform 0.2s ease;
        }

        .favorite-btn.filled i {
            color: #dc3545;
        }

        .favorite-btn i {
            transition: color 0.3s ease;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h2 class="mb-4 text-center">Search Results</h2>

    <%
        LinkedList<Car> results = (LinkedList<Car>) request.getAttribute("cars");
        HashSet<String> favoriteIds = (HashSet<String>) request.getAttribute("favoriteIds");
        if (favoriteIds == null) favoriteIds = new HashSet<>();
        if (results == null || results.size() == 0) {
    %>
    <div class="alert alert-warning text-center">
        No cars found matching your filters.
    </div>
    <%
    } else {
        LinkedList<Car>.LinkedListIterator it = results.iterator();
    %>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <%
            while (it.hasNext()) {
                Car car = it.next();
        %>
        <div class="col">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() %>/images/<%=
                            (car.getImages() != null && !car.getImages().trim().isEmpty()) ? car.getImages().trim() : "placeholder.jpg" %>"
                     class="card-img-top"
                     alt="Car Image"
                     style="height: 200px; object-fit: cover;">

                <div class="card-body">
                    <h5 class="card-title"><%= car.getMake() %> <%= car.getModel() %></h5>
                    <p class="card-text mb-1"><strong>Year:</strong> <%= car.getYear() %></p>
                    <p class="card-text mb-1"><strong>Mileage:</strong> <%= car.getMileage() %> km</p>
                    <p class="card-text mb-1"><strong>Condition:</strong> <%= car.getCondition() %></p>
                    <p class="card-text mb-1"><strong>Transmission:</strong> <%= car.getTransmission() %></p>
                    <p class="card-text mb-1"><strong>Location:</strong> <%= car.getLocation() %></p>
                    <p class="card-text fw-bold text-success mt-2">₹ <%= car.getPrice() %></p>
                </div>

                <div class="card-footer d-flex flex-row gap-2 justify-content-between align-items-center bg-transparent border-top-0">
                    <button type="button" class="favorite-btn <%= favoriteIds.contains(car.getTimestamp()) ? "filled" : "" %>" title="Add to Favorites" data-car-id="<%= car.getTimestamp() %>">
                        <i class='bx <%= favoriteIds.contains(car.getTimestamp()) ? "bxs-heart" : "bx-heart" %>'></i>
                    </button>
                    <button type="button" class="btn btn-info view-details-btn" 
                        data-make="<%= car.getMake() %>"
                        data-model="<%= car.getModel() %>"
                        data-year="<%= car.getYear() %>"
                        data-price="<%= car.getPrice() %>"
                        data-condition="<%= car.getCondition() %>"
                        data-transmission="<%= car.getTransmission() %>"
                        data-features="<%= car.getFeatures() != null ? String.join(", ", car.getFeatures()) : "" %>"
                        data-description="<%= car.getDescription() %>"
                        data-name="<%= car.getName() %>"
                        data-email="<%= car.getEmail() %>"
                        data-phone="<%= car.getPhone() %>"
                        data-location="<%= car.getLocation() %>"
                        data-images="<%= car.getImages() %>"
                        >
                        <i class='bx bx-info-circle'></i> View Details
                    </button>
                    <form method="post" action="<%= request.getContextPath() %>/Buynow.jsp" class="m-0 p-0">
                        <input type="hidden" name="carId" value="<%= car.getTimestamp() %>"/>
                        <button type="submit" class="btn btn-danger">
                            <i class='bx bx-cart'></i> Buy Now
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%
            } // end while
        %>
    </div> <!-- /.row -->
    <%
        } // end else
    %>
</div> <!-- /.container -->

<!-- Modal for Car Details -->
<div class="modal fade" id="carDetailsModal" tabindex="-1" aria-labelledby="carDetailsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="carDetailsModalLabel">Car Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="carDetailsModalBody">
        <!-- Details will be filled by JS -->
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // AJAX for heart icon (favorite)
    document.querySelectorAll('.favorite-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const carId = this.getAttribute('data-car-id');
            const icon = this.querySelector('i');
            const isFavorited = icon.classList.contains('bxs-heart');
            const action = isFavorited ? 'remove' : 'add';
            fetch('<%= request.getContextPath() %>/favorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `carId=${encodeURIComponent(carId)}&action=${action}`
            }).then(res => {
                if (res.ok) {
                    icon.classList.toggle('bx-heart');
                    icon.classList.toggle('bxs-heart');
                } else {
                    alert('Failed to update favorites.');
                }
            });
        });
    });

    // View Details Modal logic
    const detailsModal = new bootstrap.Modal(document.getElementById('carDetailsModal'));
    document.querySelectorAll('.view-details-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const fields = [
                {label: 'Make', value: this.getAttribute('data-make')},
                {label: 'Model', value: this.getAttribute('data-model')},
                {label: 'Year', value: this.getAttribute('data-year')},
                {label: 'Price', value: this.getAttribute('data-price')},
                {label: 'Condition', value: this.getAttribute('data-condition')},
                {label: 'Transmission', value: this.getAttribute('data-transmission')},
                {label: 'Features', value: this.getAttribute('data-features')},
                {label: 'Description', value: this.getAttribute('data-description')},
                {label: 'Seller Name', value: this.getAttribute('data-name')},
                {label: 'Email', value: this.getAttribute('data-email')},
                {label: 'Phone', value: this.getAttribute('data-phone')},
                {label: 'Location', value: this.getAttribute('data-location')},
                {label: 'Images', value: this.getAttribute('data-images')}
            ];
            let html = '<div class="container-fluid">';
            html += '<div class="row">';
            html += '<div class="col-md-6">';
            html += '<ul class="list-group">';
            fields.forEach(f => {
                if (f.value && f.value.trim() !== '') {
                    html += `<li class="list-group-item"><strong>${f.label}:</strong> ${f.value}</li>`;
                }
            });
            html += '</ul>';
            html += '</div>';
            html += '<div class="col-md-6">';
            if (fields[12].value && fields[12].value.trim() !== '') {
                html += `<img src='${'${pageContext.request.contextPath}/images/' + fields[12].value}' class='img-fluid rounded' alt='Car Image'>`;
            }
            html += '</div>';
            html += '</div>';
            html += '</div>';
            document.getElementById('carDetailsModalBody').innerHTML = html;
            detailsModal.show();
        });
    });
</script>
</body>
</html> 