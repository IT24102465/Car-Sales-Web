package carsale.servlets;

import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/DeleteCar")
public class DeleteCarServlet extends HttpServlet {
    private static final String FILE_PATH = "/SellCarDetails/salecardetails.txt";
    private static final String IMAGE_DIR = "/CarValuationImages";
    private static final Logger LOGGER = Logger.getLogger(DeleteCarServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Received POST request to /DeleteCar");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("No user in session, redirecting to signin");
            response.sendRedirect("signin.jsp?redirect=AllListings");
            return;
        }

        String username = user.getFullName() != null ? user.getFullName().trim() : null;
        if (username == null) {
            LOGGER.warning("User full name is null, redirecting to signin");
            response.sendRedirect("signin.jsp?redirect=AllListings");
            return;
        }
        LOGGER.info("Processing deletion for user: " + username);

        String timestamp = request.getParameter("timestamp");
        if (timestamp == null || timestamp.trim().isEmpty()) {
            LOGGER.warning("No timestamp provided for deletion");
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Invalid car listing", "UTF-8"));
            return;
        }
        LOGGER.info("Timestamp received: " + timestamp);

        String appPath = getServletContext().getRealPath("");
        File file = new File(appPath, FILE_PATH);
        File imageDir = new File(appPath, IMAGE_DIR);
        LOGGER.info("Resolved file path: " + file.getAbsolutePath() + ", Exists: " + file.exists() + ", Writable: " + file.canWrite());

        if (!file.exists()) {
            LOGGER.warning("File does not exist: " + file.getAbsolutePath());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Car listings file not found", "UTF-8"));
            return;
        }

        if (!file.canWrite()) {
            LOGGER.severe("File is not writable: " + file.getAbsolutePath());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Cannot write to car listings file", "UTF-8"));
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
                    LOGGER.info("Found matching entry for timestamp: " + timestamp + ", Username: " + carUsername);
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

        if (!carUsername.equals(username)) {
            LOGGER.warning("User " + username + " attempted to delete car owned by " + carUsername);
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("You are not authorized to delete this listing", "UTF-8"));
            return;
        }

        try {
            Files.write(file.toPath(), updatedLines);
            LOGGER.info("Successfully deleted entry for timestamp: " + timestamp);
        } catch (IOException e) {
            LOGGER.severe("Error writing to file: " + file.getAbsolutePath() + ", Error: " + e.getMessage());
            response.sendRedirect("listings.jsp?error=" + java.net.URLEncoder.encode("Error deleting car listing: " + e.getMessage(), "UTF-8"));
            return;
        }

        if (imagesToDelete != null && !imagesToDelete.equals("None")) {
            for (String image : imagesToDelete.split(",")) {
                File imageFile = new File(imageDir, image.trim());
                LOGGER.info("Attempting to delete image: " + imageFile.getAbsolutePath() + ", Exists: " + imageFile.exists());
                if (imageFile.exists()) {
                    try {
                        Files.delete(imageFile.toPath());
                        LOGGER.info("Successfully deleted image: " + imageFile.getAbsolutePath());
                    } catch (IOException e) {
                        LOGGER.warning("Failed to delete image: " + imageFile.getAbsolutePath() + ", Error: " + e.getMessage());
                        // Continue despite image deletion failure
                    }
                }
            }
        }

        response.sendRedirect("listings.jsp?success=" + java.net.URLEncoder.encode("Car listing deleted successfully", "UTF-8"));
    }
}