<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.ds.LinkedList" %>
<%@ page import="filter.util.CarLoader" %>
<%@ page import="filter.util.CarImageResolver" %>
<%@ page import="filter.util.CarImageOverrideUrls" %>
<%
    LinkedList<Car> favorites = (LinkedList<Car>) request.getAttribute("favorites");
    int favoriteCount = (favorites != null) ? favorites.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saved Vehicles - SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/filter/filter.css">
</head>
<body>

<%@include file="navbar.jsp" %>

<section class="hero-section text-center">
    <div class="container">
        <h1 class="hero-title animate__animated animate__fadeInDown">Your Saved Vehicles</h1>
        <p class="lead animate__animated animate__fadeIn animate__delay-1s">
            Review and manage cars you've added to favorites
        </p>
    </div>
</section>

<div class="container my-5" id="saved-vehicles">
    <div class="saved-vehicles-header d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
        <h2 class="mb-0"><i class='bx bx-heart'></i> Saved Vehicles (<%= favoriteCount %>)</h2>
        <a href="<%= request.getContextPath() %>/Buynow.jsp" class="btn btn-danger">
            <i class='bx bx-car'></i> Browse Inventory
        </a>
    </div>

    <% if (favorites == null || favorites.size() == 0) { %>
    <div class="alert alert-info text-center" id="empty-favorites-msg">
        <i class='bx bx-info-circle fs-4 d-block mb-2'></i>
        You have not saved any vehicles yet.
        <div class="mt-3">
            <a href="<%= request.getContextPath() %>/Buynow.jsp" class="btn btn-outline-danger">
                <i class='bx bx-search'></i> Find Cars to Save
            </a>
        </div>
    </div>
    <% } else { %>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 saved-vehicles-grid">
        <% LinkedList<Car>.LinkedListIterator it = favorites.iterator();
           while (it.hasNext()) {
               Car car = it.next();
               String carImgUrl = CarLoader.resolveImagePath(request.getContextPath(), car.getImages(), car);
               String fixedSrc = CarImageOverrideUrls.proxySrc(request.getContextPath(), car);
               boolean useFixedImage = fixedSrc != null;
        %>
        <div class="col">
            <div class="card h-100 shadow-sm">
                 <img src="<%= carImgUrl %>"
                      class="card-img-top car-web-photo"
                      alt="<%= car.getMake() %> <%= car.getModel() %>"
                      style="height: 200px; object-fit: cover;"
                      referrerpolicy="no-referrer"
                      data-make="<%= car.getMake() %>"
                      data-model="<%= car.getModel() %>"
                      data-search-make="<%= CarImageResolver.getSearchMake(car) %>"
                      data-search-model="<%= CarImageResolver.getSearchModel(car) %>"
                      data-year="<%= car.getYear() %>"
                      data-car-id="<%= car.getTimestamp() %>"
                      <% if (useFixedImage) { %>data-fixed-image="<%= fixedSrc %>"<% } %>>
                <div class="card-body">
                    <h5 class="card-title"><%= car.getMake() %> <%= car.getModel() %></h5>
                    <p class="card-text mb-1"><strong>Year:</strong> <%= car.getYear() %></p>
                    <p class="card-text mb-1"><strong>Condition:</strong> <%= car.getCondition() %></p>
                    <p class="card-text mb-1"><strong>Transmission:</strong> <%= car.getTransmission() %></p>
                    <p class="card-text mb-1"><strong>Location:</strong> <%= car.getLocation() %></p>
                    <p class="card-text fw-bold text-success mt-2">Rs. <%= car.getPrice() %></p>
                </div>
                <div class="card-footer d-flex flex-row gap-2 justify-content-between align-items-center bg-transparent border-top-0">
                    <button type="button" class="favorite-btn filled" title="Remove from Favorites" data-car-id="<%= car.getTimestamp() %>">
                        <i class='bx bxs-heart'></i>
                    </button>
                    <button type="button" class="btn btn-info view-details-btn"
                        data-car-id="<%= car.getTimestamp() %>"
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
                        data-search-make="<%= CarImageResolver.getSearchMake(car) %>"
                        data-search-model="<%= CarImageResolver.getSearchModel(car) %>"
                        <% if (useFixedImage) { %>data-fixed-image="<%= fixedSrc %>"<% } %>
                        data-images="<%= car.getImages() %>">
                        <i class='bx bx-info-circle'></i> View Details
                    </button>
                    <button type="button" class="btn btn-danger buy-now-btn"
                        data-car-id="<%= car.getTimestamp() %>"
                        data-make="<%= car.getMake() %>"
                        data-model="<%= car.getModel() %>"
                        data-year="<%= car.getYear() %>"
                        data-price="<%= car.getPrice() %>"
                        data-name="<%= car.getName() %>"
                        data-email="<%= car.getEmail() %>"
                        data-phone="<%= car.getPhone() %>"
                        data-location="<%= car.getLocation() %>">
                        <i class='bx bx-cart'></i> Buy Now
                    </button>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<div class="modal fade" id="carDetailsModal" tabindex="-1" aria-labelledby="carDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="carDetailsModalLabel">Car Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="carDetailsModalBody"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="buyNowModal" tabindex="-1" aria-labelledby="buyNowModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0" style="border-radius: 16px; overflow: hidden;">
            <div class="modal-header text-white border-0" style="background: linear-gradient(135deg, #e53935 0%, #b71c1c 100%); padding: 20px 24px;">
                <h5 class="modal-title fw-bold" id="buyNowModalLabel">
                    <i class='bx bx-badge-check' style="font-size: 24px; vertical-align: middle;"></i> Purchase Inquiry
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4" style="background-color: #fdfdfd;">
                <div class="text-center mb-4">
                    <div class="icon-wrap d-inline-flex align-items-center justify-content-center bg-danger bg-opacity-10 text-danger rounded-circle mb-3" style="width: 60px; height: 60px;">
                        <i class='bx bx-phone-call' style="font-size: 32px;"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-1">Contact the Seller</h4>
                    <p class="text-muted small">Reach out to secure this vehicle or schedule a test drive.</p>
                </div>
                
                <div class="card border-0 bg-light p-3 mb-4" style="border-radius: 12px;">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-secondary small">Vehicle</span>
                        <span class="fw-bold text-dark" id="buyNowCarName">Toyota Highlander</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-secondary small">Asking Price</span>
                        <span class="fw-bold text-success" id="buyNowCarPrice">Rs. 23,000</span>
                    </div>
                </div>

                <div class="list-group list-group-flush border-0">
                    <div class="list-group-item d-flex align-items-center border-0 py-3 px-0 bg-transparent">
                        <div class="me-3 text-secondary bg-white shadow-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                            <i class='bx bx-user' style="font-size: 20px;"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Seller Name</div>
                            <div class="fw-semibold text-dark" id="buyNowSellerName">Vishadi</div>
                        </div>
                    </div>
                    <div class="list-group-item d-flex align-items-center border-0 py-3 px-0 bg-transparent">
                        <div class="me-3 text-secondary bg-white shadow-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                            <i class='bx bx-phone' style="font-size: 20px;"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Phone Number</div>
                            <div class="fw-bold text-danger" id="buyNowSellerPhone">0770457072</div>
                        </div>
                    </div>
                    <div class="list-group-item d-flex align-items-center border-0 py-3 px-0 bg-transparent">
                        <div class="me-3 text-secondary bg-white shadow-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                            <i class='bx bx-envelope' style="font-size: 20px;"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Email Address</div>
                            <div class="fw-semibold text-dark" id="buyNowSellerEmail">ramodyavishadi@gmail.com</div>
                        </div>
                    </div>
                    <div class="list-group-item d-flex align-items-center border-0 py-3 px-0 bg-transparent">
                        <div class="me-3 text-secondary bg-white shadow-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                            <i class='bx bx-map' style="font-size: 20px;"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Location</div>
                            <div class="fw-semibold text-dark" id="buyNowSellerLocation">Negombo</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 p-3 bg-light d-flex justify-content-center gap-2">
                <a href="" id="buyNowCallBtn" class="btn btn-danger px-4 py-2 fw-semibold" style="border-radius: 8px;">
                    <i class='bx bx-phone'></i> Call Now
                </a>
                <a href="" id="buyNowEmailBtn" class="btn btn-outline-secondary px-4 py-2 fw-semibold" style="border-radius: 8px;">
                    <i class='bx bx-envelope'></i> Email Seller
                </a>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/car-image-config.jsp"/>
<script src="<%= request.getContextPath() %>/js/car-image-loader.js"></script>
<script>
(function () {
    const ctx = '<%= request.getContextPath() %>';

    document.querySelectorAll('.favorite-btn.filled').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const carId = this.getAttribute('data-car-id');
            const card = this.closest('.col');
            fetch(ctx + '/favorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'carId=' + encodeURIComponent(carId) + '&action=remove'
            }).then(res => {
                if (res.ok) {
                    card.remove();
                    const grid = document.querySelector('.saved-vehicles-grid');
                    if (grid && grid.children.length === 0) {
                        window.location.reload();
                    } else {
                        const heading = document.querySelector('#saved-vehicles h2');
                        if (heading) {
                            const remaining = document.querySelectorAll('.saved-vehicles-grid .col').length;
                            heading.innerHTML = "<i class='bx bx-heart'></i> Saved Vehicles (" + remaining + ")";
                        }
                    }
                } else {
                    alert('Failed to remove from favorites.');
                }
            });
        });
    });

    document.querySelectorAll('.view-details-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const fields = [
                { label: 'Make', value: this.getAttribute('data-make') },
                { label: 'Model', value: this.getAttribute('data-model') },
                { label: 'Year', value: this.getAttribute('data-year') },
                { label: 'Price', value: this.getAttribute('data-price') },
                { label: 'Condition', value: this.getAttribute('data-condition') },
                { label: 'Transmission', value: this.getAttribute('data-transmission') },
                { label: 'Features', value: this.getAttribute('data-features') },
                { label: 'Description', value: this.getAttribute('data-description') },
                { label: 'Seller Name', value: this.getAttribute('data-name') },
                { label: 'Email', value: this.getAttribute('data-email') },
                { label: 'Phone', value: this.getAttribute('data-phone') },
                { label: 'Location', value: this.getAttribute('data-location') }
            ];
            let html = '<div class="container-fluid"><div class="row"><div class="col-md-6"><ul class="list-group">';
            fields.forEach(f => {
                if (f.value && f.value.trim() !== '') {
                    html += '<li class="list-group-item"><strong>' + f.label + ':</strong> ' + f.value + '</li>';
                }
            });
            html += '</ul></div><div class="col-md-6" id="modalCarImageWrap"></div></div></div>';
            document.getElementById('carDetailsModalBody').innerHTML = html;
            const modalImg = document.createElement('img');
            modalImg.className = 'img-fluid rounded w-100 car-web-photo';
            modalImg.style.maxHeight = '320px';
            modalImg.style.objectFit = 'cover';
            const modalFixed = this.getAttribute('data-fixed-image');
            document.getElementById('modalCarImageWrap').appendChild(modalImg);
            if (modalFixed) {
                modalImg.dataset.fixedImage = modalFixed;
            } else {
                modalImg.dataset.searchMake = this.getAttribute('data-search-make') || this.getAttribute('data-make') || '';
                modalImg.dataset.searchModel = this.getAttribute('data-search-model') || this.getAttribute('data-model') || '';
                modalImg.dataset.year = this.getAttribute('data-year') || '';
                modalImg.dataset.carId = (this.getAttribute('data-car-id') || '') + '-modal';
            }
            modalImg.dataset.webPhotoLoaded = '0';
            if (typeof loadCarPhoto === 'function') {
                loadCarPhoto(modalImg);
            }

            const detailsModalEl = document.getElementById('carDetailsModal');
            if (detailsModalEl && typeof bootstrap !== 'undefined') {
                let detailsModal = bootstrap.Modal.getInstance(detailsModalEl);
                if (!detailsModal) {
                    detailsModal = new bootstrap.Modal(detailsModalEl);
                }
                detailsModal.show();
            }
        });
    });

    document.querySelectorAll('.buy-now-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const make = this.getAttribute('data-make') || '';
            const model = this.getAttribute('data-model') || '';
            const year = this.getAttribute('data-year') || '';
            const price = this.getAttribute('data-price') || '';
            const name = this.getAttribute('data-name') || '';
            const email = this.getAttribute('data-email') || '';
            const phone = this.getAttribute('data-phone') || '';
            const location = this.getAttribute('data-location') || '';

            document.getElementById('buyNowCarName').textContent = make + ' ' + model + ' (' + year + ')';
            document.getElementById('buyNowCarPrice').textContent = 'Rs. ' + price;
            document.getElementById('buyNowSellerName').textContent = name;
            document.getElementById('buyNowSellerPhone').textContent = phone;
            document.getElementById('buyNowSellerEmail').textContent = email;
            document.getElementById('buyNowSellerLocation').textContent = location;

            const callBtn = document.getElementById('buyNowCallBtn');
            if (callBtn) {
                callBtn.href = phone ? 'tel:' + phone.replace(/\s+/g, '') : '#';
                callBtn.style.display = phone ? 'inline-block' : 'none';
            }

            const emailBtn = document.getElementById('buyNowEmailBtn');
            if (emailBtn) {
                emailBtn.href = email ? 'mailto:' + email + '?subject=' + encodeURIComponent('Inquiry: ' + make + ' ' + model) : '#';
                emailBtn.style.display = email ? 'inline-block' : 'none';
            }

            const buyNowModalEl = document.getElementById('buyNowModal');
            if (buyNowModalEl && typeof bootstrap !== 'undefined') {
                let buyNowModal = bootstrap.Modal.getInstance(buyNowModalEl);
                if (!buyNowModal) {
                    buyNowModal = new bootstrap.Modal(buyNowModalEl);
                }
                buyNowModal.show();
            }
        });
    });
})();
</script>
</body>
</html>
