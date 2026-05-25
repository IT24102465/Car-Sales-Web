<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="login.model.User" %>
<%@ page import="carsale.model.Car" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%
    User user = (User) session.getAttribute("user");
    String username = user != null && user.getFullName() != null ? user.getFullName().trim() : null;
    List<Car> cars = (List<Car>) request.getAttribute("cars");
    Logger LOGGER = Logger.getLogger("listings.jsp");

    if (cars == null) {
        cars = new ArrayList<>();
        if (username != null) {
            String appPath = pageContext.getServletContext().getRealPath("");
            File file = new File(appPath, "/SellCarDetails/salecardetails.txt");
            LOGGER.info("Resolved file path in listings.jsp: " + file.getAbsolutePath() + ", Exists: " + file.exists());

            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        LOGGER.info("Processing line: " + line);
                        String[] parts = line.split(" \\| ", -1);
                        if (parts.length >= 15) {
                            String fileUsername = parts[14] != null ? parts[14].trim() : "Unknown";
                            if (fileUsername.equals(username)) {
                                String[] features = parts[7] != null && !parts[7].trim().isEmpty() && !parts[7].equals("None") ? parts[7].split(",") : new String[0];
                                String images = parts.length > 15 && parts[15] != null && !parts[15].trim().isEmpty() ? parts[15].trim() : "None";
                                String price = parts[12] != null ? parts[12].trim() : "Unknown";
                                Car car = new Car(
                                        parts[1] != null ? parts[1].trim() : "",
                                        parts[2] != null ? parts[2].trim() : "",
                                        parts[3] != null ? parts[3].trim() : "",
                                        parts[4] != null ? parts[4].trim() : "",
                                        parts[5] != null ? parts[5].trim() : "",
                                        parts[6] != null ? parts[6].trim() : "",
                                        Arrays.asList(features),
                                        parts[8] != null && !parts[8].trim().isEmpty() && !parts[8].equals("None") ? parts[8].trim() : null,
                                        parts[9] != null ? parts[9].trim() : "",
                                        parts[10] != null ? parts[10].trim() : "",
                                        parts[11] != null ? parts[11].trim() : "",
                                        parts[13] != null ? parts[13].trim() : "",
                                        parts[0] != null ? parts[0].trim() : "",
                                        fileUsername,
                                        images,
                                        price
                                );
                                cars.add(car);
                                LOGGER.info("Added car for user " + username + ": " + (car.getMake() != null ? car.getMake() : "Unknown") + " " + (car.getModel() != null ? car.getModel() : "Unknown") + ", Timestamp: " + car.getTimestamp());
                                if (!images.equals("None")) {
                                    LOGGER.info("Images for car: " + images);
                                }
                            } else {
                                LOGGER.info("Skipping car for user " + fileUsername + " (logged-in user: " + username + ")");
                            }
                        } else {
                            LOGGER.warning("Invalid line format or insufficient parts: " + line + " (parts: " + parts.length + ")");
                        }
                    }
                } catch (IOException e) {
                    LOGGER.severe("Error reading file: " + e.getMessage());
                    request.setAttribute("error", "Error reading file: " + e.getMessage());
                }
            } else {
                LOGGER.warning("File does not exist: " + file.getAbsolutePath());
                request.setAttribute("error", "Car listings file not found.");
            }
        } else {
            LOGGER.warning("No user logged in, cannot load listings");
            request.setAttribute("error", "Please log in to view your car listings.");
        }
    }
    LOGGER.info("Total cars found for user " + username + ": " + cars.size());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Car Listings - SMART CARZONE</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/listings.css">
    <link rel="stylesheet" href="css/sell.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@include file="navbar.jsp"%>

<div class="container mt-5">
    <h2 class="text-center mb-4">My Car Listings</h2>
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success alert-dismissible fade show">
        <%= request.getParameter("success") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show">
        <%= request.getAttribute("error") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (user == null) { %>
    <div class="alert alert-info text-center">
        Please <a href="signin.jsp?redirect=AllListings" class="alert-link">log in</a> to view your car listings.
    </div>
    <% } else if (cars.isEmpty()) { %>
    <div class="alert alert-info text-center">
        You have no car listings. <a href="sell.jsp" class="alert-link">Add a new listing</a>.
        (Debug: cars.size=<%= cars.size() %>)
    </div>
    <% } else { %>
    <div class="row">
        <% for (Car car : cars) { %>
        <div class="col-md-6 col-lg-4 car-card">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">
                        <%= car.getYear() != null ? car.getYear() : "Unknown Year" %>
                        <%= car.getMake() != null ? car.getMake() : "Unknown Make" %>
                        <%= car.getModel() != null ? car.getModel() : "Unknown Model" %>
                    </h5>
                    <div class="card-details">
                        <p class="card-text">
                            <strong>Price:</strong> <%= car.getPrice() != null ? "Rs." + car.getPrice() : "Unknown" %><br>
                            <strong>Mileage:</strong> <%= car.getMileage() != null ? car.getMileage() : "Unknown" %> mi<br>
                            <strong>Condition:</strong> <%= car.getCondition() != null ? car.getCondition() : "Unknown" %><br>
                            <strong>Transmission:</strong> <%= car.getTransmission() != null ? car.getTransmission() : "Unknown" %><br>
                            <strong>Features:</strong> <%= car.getFeatures() != null && !car.getFeatures().isEmpty() ? String.join(", ", car.getFeatures()) : "None" %><br>
                            <strong>Description:</strong> <%= car.getDescription() != null ? car.getDescription() : "None" %><br>
                            <strong>Contact:</strong>
                            <%= car.getName() != null ? car.getName() : "Unknown" %>,
                            <%= car.getPhone() != null ? car.getPhone() : "Unknown" %>,
                            <%= car.getEmail() != null ? car.getEmail() : "Unknown" %>,
                            <%= car.getLocation() != null ? car.getLocation() : "Unknown" %>
                        </p>
                    </div>
                    <div class="car-images">
                        <%
                            boolean hasValidImage = false;
                            int imageCount = 0;
                            if (car.getImages() != null && !car.getImages().equals("None") && !car.getImages().trim().isEmpty()) {
                                String[] imageArray = car.getImages().split(",");
                                for (String image : imageArray) {
                                    if (imageCount >= 3) break;
                                    image = image.trim();
                                    if (!image.isEmpty()) {
                                        String imagePath = "UploadCarImages/" + image;
                                        File imageFile = new File(pageContext.getServletContext().getRealPath(""), imagePath);
                                        LOGGER.info("Checking image: " + imageFile.getAbsolutePath() + ", Exists: " + imageFile.exists());
                                        if (imageFile.exists()) {
                                            hasValidImage = true;
                        %>
                        <div class="image-wrapper">
                            <img src="<%= imagePath %>" alt="Car Image" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="showImage('<%= imagePath %>')">
                        </div>
                        <%
                                            imageCount++;
                                        } else {
                                            LOGGER.warning("Image file not found: " + imageFile.getAbsolutePath());
                                        }
                                    }
                                }
                            }
                            while (imageCount < 1) {
                        %>
                        <div class="image-wrapper">
                            <div class="no-image">No Image</div>
                        </div>
                        <%
                                imageCount++;
                            }
                        %>
                    </div>
                    <div class="mt-3">
                        <a href="EditCar?timestamp=<%= java.net.URLEncoder.encode(car.getTimestamp(), StandardCharsets.UTF_8.name()) %>" class="btn btn-primary btn-sm me-2">
                            <i class='bx bx-edit'></i> Edit
                        </a>
                        <form action="DeleteCar" method="POST" style="display: inline;" onsubmit="this.querySelector('button').disabled=true;">
                            <input type="hidden" name="timestamp" value="<%= car.getTimestamp() %>">
                            <button type="submit" class="btn btn-danger btn-sm delete-btn">
                                <i class='bx bx-trash'></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
    <% if (user != null) { %>
    <div class="text-center mt-4">
        <a href="sell.jsp" class="beautiful-button btn-primary">Add New Listing</a>
    </div>
    <% } %>
</div>

<!-- Image Preview Modal -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">Car Image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Car Image" style="max-width: 50%; height: 20%;">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showImage(src) {
        document.getElementById('modalImage').src = src;
    }
</script>
</body>
</html>