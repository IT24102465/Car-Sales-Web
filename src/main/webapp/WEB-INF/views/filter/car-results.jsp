<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="filter.ds.LinkedList" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="filter.util.CarLoader" %>
<%@ page import="filter.util.CarImageResolver" %>
<%@ page import="filter.util.CarImageOverrideUrls" %>

<%
    LinkedList<Car> results = (LinkedList<Car>) request.getAttribute("cars");
    HashSet<String> favoriteIds = (HashSet<String>) request.getAttribute("favoriteIds");
    if (favoriteIds == null) favoriteIds = new HashSet<>();
    if (results != null) {
%>

<%
    boolean searched = Boolean.TRUE.equals(request.getAttribute("searched"));
    String resultsTitle = searched ? "Search Results" : "Available Inventory";
%>
<div class="container my-4" id="search-results">
    <h3 class="mb-4"><i class='bx bx-list-ul'></i> <%= resultsTitle %> (<%= results.size() %>)</h3>

    <% if (results.size() == 0) { %>
    <div class="alert alert-warning text-center">
        No cars found matching your filters.
    </div>
    <% } else {
        LinkedList<Car>.LinkedListIterator it = results.iterator();
    %>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <% while (it.hasNext()) {
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
                    <button type="button" class="favorite-btn <%= favoriteIds.contains(car.getTimestamp()) ? "filled" : "" %>" title="Add to Favorites" data-car-id="<%= car.getTimestamp() %>">
                        <i class='bx <%= favoriteIds.contains(car.getTimestamp()) ? "bxs-heart" : "bx-heart" %>'></i>
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

    <div class="d-flex justify-content-center align-items-center gap-3 mt-4 mb-2">
        <button type="button" class="btn btn-outline-secondary rounded-pill px-3 buy-now-page-arrow" title="Previous page">
            <i class='bx bx-chevron-left'></i>
        </button>
        <div class="text-center">
            <div class="fw-semibold text-dark">Page 1 of 2</div>
        </div>
        <button type="button" class="btn btn-outline-danger rounded-pill px-3 buy-now-page-arrow" title="Next page">
            <i class='bx bx-chevron-right'></i>
        </button>
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

<style>
    .favorite-btn {
        background: none;
        border: none;
        color: #dc3545;
        font-size: 24px;
    }
    .favorite-btn.filled i { color: #dc3545; }
</style>

<script>
(function () {
    const ctx = '<%= request.getContextPath() %>';

    document.querySelectorAll('.favorite-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const carId = this.getAttribute('data-car-id');
            const icon = this.querySelector('i');
            const isFavorited = icon.classList.contains('bxs-heart');
            const action = isFavorited ? 'remove' : 'add';
            fetch(ctx + '/favorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'carId=' + encodeURIComponent(carId) + '&action=' + action
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
<% } %>
