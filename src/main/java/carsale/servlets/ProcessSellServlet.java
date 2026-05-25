package carsale.servlets;

import login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet("/ProcessSell")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 1024 * 1024 * 5,       // 5MB
        maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class ProcessSellServlet extends HttpServlet {
    private static final String FILE_PATH = "/SellCarDetails/salecardetails.txt";
    private static final Logger LOGGER = Logger.getLogger(ProcessSellServlet.class.getName());


    private String getValueFromPart(Part part) throws IOException {
        if (part == null) return null;
        BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8));
        return reader.lines().collect(Collectors.joining());
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "";
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("No user in session, redirecting to signin");
            response.sendRedirect("signin.jsp?redirect=sell.jsp");
            return;
        }

        // Initialize imagePaths list here (only once)
        List<String> imagePaths = new ArrayList<>();

        try {
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if (part.getName().equals("carImages") && part.getSize() > 0) {
                    String uploadPath = getServletContext().getRealPath("") + "UploadCarImages";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    String fileName = System.currentTimeMillis() + "_" + getFileName(part);
                    part.write(uploadPath + File.separator + fileName);
                    imagePaths.add(fileName);
                }
            }
            session.setAttribute("carImagePaths", imagePaths);
        } catch (Exception e) {
            LOGGER.warning("Error processing file upload: " + e.getMessage());
        }

        // Now get all other form parameters
        String timestamp = getValueFromPart(request.getPart("timestamp"));
        String make = getValueFromPart(request.getPart("make"));
        String model = getValueFromPart(request.getPart("model"));
        String year = request.getParameter("year");
        String mileage = request.getParameter("mileage");
        String condition = request.getParameter("condition");
        String transmission = request.getParameter("transmission");
        String[] featuresArray = request.getParameterValues("features");
        String description = request.getParameter("description");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String price = request.getParameter("price");
        String location = request.getParameter("location");
        String existingImages = request.getParameter("existingImages");
        boolean isEdit = "true".equals(request.getParameter("edit"));

        // Generate timestamp for new listings if not provided
        if (!isEdit && (timestamp == null || timestamp.trim().isEmpty())) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            timestamp = dateFormat.format(new Date());
            LOGGER.info("Generated new timestamp for listing: " + timestamp);
        }

        // Validate required fields
        if (make == null || model == null || year == null || mileage == null || condition == null ||
                transmission == null || name == null || email == null || phone == null || price == null || location == null) {
            LOGGER.warning("Missing required fields in form submission");
            response.sendRedirect("sell.jsp?error=" + java.net.URLEncoder.encode("All required fields must be filled", "UTF-8"));
            return;
        }

        // Handle features
        String features = featuresArray != null && featuresArray.length > 0 ? String.join(",", featuresArray) : "None";
        if (features.isEmpty()) {
            features = "None";
        }

        // Use the imagePaths list we already created (remove the redeclaration)
        String images = existingImages != null && !existingImages.equals("None") ? existingImages : "None";

        // Only append new images if they were uploaded during this request
        if (isEdit && imagePaths != null && !imagePaths.isEmpty()) {
            List<String> imageNames = new ArrayList<>();
            for (String path : imagePaths) {
                String imageName = new File(path).getName();
                // Avoid duplicating existing images
                if (images.equals("None") || !images.contains(imageName)) {
                    imageNames.add(imageName);
                }
            }
            if (!imageNames.isEmpty()) {
                String newImages = String.join(",", imageNames);
                images = images.equals("None") ? newImages : images + "," + newImages;
            }
            LOGGER.info("Processed images for edit: " + images);
        } else if (!isEdit && imagePaths != null && !imagePaths.isEmpty()) {
            // For new listings, use all images from imagePaths
            List<String> imageNames = new ArrayList<>();
            for (String path : imagePaths) {
                imageNames.add(new File(path).getName());
            }
            images = String.join(",", imageNames);
            LOGGER.info("Processed images for new listing: " + images);
        } else {
            LOGGER.info("No new images uploaded, using existing images: " + images);
        }

        // Ensure images is not empty
        if (images.isEmpty()) {
            images = "None";
        }

        // Construct data line
        String username = user.getFullName() != null ? user.getFullName() : "Unknown";
        String data = String.format(
                "%s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s",
                timestamp, make, model, year, mileage, condition, transmission, features,
                description != null ? description : "None", name, email, phone, price, location, username, images
        );

        // Write to file
        String appPath = getServletContext().getRealPath("");
        File file = new File(appPath, FILE_PATH);
        LOGGER.info("Writing to file: " + file.getAbsolutePath());

        try {
            if (isEdit && timestamp != null && !timestamp.isEmpty()) {
                // Update existing entry
                List<String> lines = Files.readAllLines(file.toPath());
                List<String> updatedLines = new ArrayList<>();
                boolean updated = false;
                for (String line : lines) {
                    if (line.startsWith(timestamp + " |")) {
                        updatedLines.add(data);
                        updated = true;
                        LOGGER.info("Updated entry for timestamp: " + timestamp);
                    } else {
                        updatedLines.add(line);
                    }
                }
                if (!updated) {
                    LOGGER.warning("Timestamp not found for update: " + timestamp);
                    updatedLines.add(data); // Fallback: append if not found
                }
                Files.write(file.toPath(), updatedLines);
            } else {
                // New entry
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                    writer.write(data);
                    writer.newLine();
                    LOGGER.info("Appended new entry to file");
                }
            }
        } catch (IOException e) {
            LOGGER.severe("Error writing to file: " + e.getMessage());
            response.sendRedirect("sell.jsp?error=" + java.net.URLEncoder.encode("Error saving car details: " + e.getMessage(), "UTF-8"));
            return;
        }

        // Clean up session
        session.removeAttribute("carImagePaths");

        // Redirect to listings with success message
        response.sendRedirect("listings.jsp?success=" + java.net.URLEncoder.encode("Car listing " + (isEdit ? "updated" : "added") + " successfully", "UTF-8"));
    }
}