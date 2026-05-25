package carsale.servlets;

import carsale.model.Car;
import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/EditCar")
public class EditCarServlet extends HttpServlet {
    private static final String FILE_PATH = "/SellCarDetails/salecardetails.txt";
    private static final String IMAGE_DIR = "/CarValuationImages";
    private static final Logger LOGGER = Logger.getLogger(EditCarServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("No user in session, redirecting to signin");
            response.sendRedirect("signin.jsp?redirect=AllListings");
            return;
        }

        String timestamp = request.getParameter("timestamp");
        if (timestamp == null || timestamp.trim().isEmpty()) {
            LOGGER.warning("No timestamp provided for edit");
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Invalid car listing", "UTF-8"));
            return;
        }

        String appPath = getServletContext().getRealPath("");
        File file = new File(appPath, FILE_PATH);
        LOGGER.info("Resolved file path: " + file.getAbsolutePath() + ", Exists: " + file.exists());

        Car car = null;
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(" \\| ", -1);
                    if (parts.length >= 16 && parts[0].equals(timestamp)) {
                        String[] features = parts[7] != null && !parts[7].trim().isEmpty() && !parts[7].equals("None") ? parts[7].split(",") : new String[0];
                        String images = parts[15] != null && !parts[15].trim().isEmpty() ? parts[15].trim() : "None";
                        String price = parts[12] != null ? parts[12].trim() : "Unknown";
                        car = new Car(
                                parts[1] != null ? parts[1].trim() : "",
                                parts[2] != null ? parts[2].trim() : "",
                                parts[3] != null ? parts[3].trim() : "",
                                parts[4] != null ? parts[4].trim() : "",
                                parts[5] != null ? parts[5].trim() : "",
                                parts[6] != null ? parts[6].trim() : "",
                                Arrays.asList(features),
                                parts[8] != null && !parts[8].equals("None") ? parts[8].trim() : null,
                                parts[9] != null ? parts[9].trim() : "",
                                parts[10] != null ? parts[10].trim() : "",
                                parts[11] != null ? parts[11].trim() : "",
                                parts[13] != null ? parts[13].trim() : "",
                                parts[0] != null ? parts[0].trim() : "",
                                parts[14] != null ? parts[14].trim() : "Unknown",
                                images,
                                price
                        );
                        break;
                    }
                }
            } catch (IOException e) {
                LOGGER.severe("Error reading file: " + e.getMessage());
                response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Error loading car details: " + e.getMessage(), "UTF-8"));
                return;
            }
        } else {
            LOGGER.warning("File does not exist: " + file.getAbsolutePath());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Car listings file not found", "UTF-8"));
            return;
        }

        if (car == null) {
            LOGGER.warning("Car not found for timestamp: " + timestamp);
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Car listing not found", "UTF-8"));
            return;
        }

        // Verify user ownership
        if (!car.getUsername().equals(user.getFullName())) {
            LOGGER.warning("User " + user.getFullName() + " attempted to edit car owned by " + car.getUsername());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("You are not authorized to edit this listing", "UTF-8"));
            return;
        }

        // Store car images in session for editing (consistent with ImageUploadServlet)
        if (car.getImages() != null && !car.getImages().equals("None")) {
            List<String> imagePaths = new ArrayList<>();
            for (String image : car.getImages().split(",")) {
                imagePaths.add(new File(appPath, IMAGE_DIR + "/" + image.trim()).getAbsolutePath());
            }
            session.setAttribute("carImagePaths", imagePaths);
        }

        request.setAttribute("car", car);
        request.getRequestDispatcher("/sell.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("No user in session, redirecting to signin");
            response.sendRedirect("signin.jsp?redirect=AllListings");
            return;
        }

        String action = request.getParameter("action");
        String timestamp = request.getParameter("timestamp");

        if (action == null || !action.equals("delete") || timestamp == null || timestamp.trim().isEmpty()) {
            LOGGER.warning("Invalid delete request: action=" + action + ", timestamp=" + timestamp);
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Invalid delete request", "UTF-8"));
            return;
        }

        String appPath = getServletContext().getRealPath("");
        File file = new File(appPath, FILE_PATH);
        File imageDir = new File(appPath, IMAGE_DIR);
        LOGGER.info("Resolved file path: " + file.getAbsolutePath() + ", Exists: " + file.exists());

        if (!file.exists()) {
            LOGGER.warning("File does not exist: " + file.getAbsolutePath());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Car listings file not found", "UTF-8"));
            return;
        }

        List<String> lines = Files.readAllLines(file.toPath());
        List<String> updatedLines = new ArrayList<>();
        String imagesToDelete = null;
        boolean found = false;
        String carUsername = null;

        for (String line : lines) {
            if (line.startsWith(timestamp + " |")) {
                String[] parts = line.split(" \\| ", -1);
                if (parts.length >= 16) {
                    imagesToDelete = parts[15].trim();
                    carUsername = parts[14].trim();
                    found = true;
                }
                continue;
            }
            updatedLines.add(line);
        }

        if (!found) {
            LOGGER.warning("Car not found for timestamp: " + timestamp);
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Car listing not found", "UTF-8"));
            return;
        }

        // Verify user ownership
        if (!carUsername.equals(user.getFullName())) {
            LOGGER.warning("User " + user.getFullName() + " attempted to delete car owned by " + carUsername);
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("You are not authorized to delete this listing", "UTF-8"));
            return;
        }

        // Write updated lines back to file
        try {
            Files.write(file.toPath(), updatedLines);
            LOGGER.info("Deleted entry for timestamp: " + timestamp);
        } catch (IOException e) {
            LOGGER.severe("Error writing to file: " + e.getMessage());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Error deleting car listing: " + e.getMessage(), "UTF-8"));
            return;
        }

        // Delete associated images
        if (imagesToDelete != null && !imagesToDelete.equals("None")) {
            for (String image : imagesToDelete.split(",")) {
                File imageFile = new File(imageDir, image.trim());
                if (imageFile.exists()) {
                    try {
                        Files.delete(imageFile.toPath());
                        LOGGER.info("Deleted image: " + imageFile.getAbsolutePath());
                    } catch (IOException e) {
                        LOGGER.warning("Failed to delete image: " + imageFile.getAbsolutePath() + ", Error: " + e.getMessage());
                    }
                }
            }
        }

        response.sendRedirect("listings.jsp?success=" + java.net.URLEncoder.encode("Car listing deleted successfully", "UTF-8"));
    }
}