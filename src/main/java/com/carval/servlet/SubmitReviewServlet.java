package com.carval.servlet;

import com.carval.model.CarCertificationRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/submit-review")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if we have session data (if user came from step 2)
        HttpSession session = request.getSession();
        if (session.getAttribute("damages") == null) {
            // Redirect to step 1 if no session data
            response.sendRedirect(request.getContextPath() + "/car-details");
            return;
        }
        
        request.getRequestDispatcher("/views/submit_review.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get all data from session
        String brand = (String) session.getAttribute("brand");
        String model = (String) session.getAttribute("model");
        int year = (Integer) session.getAttribute("year");
        int mileage = (Integer) session.getAttribute("mileage");
        double price = (Double) session.getAttribute("price");
        String location = (String) session.getAttribute("location");
        String ownerContact = (String) session.getAttribute("ownerContact");
        String damages = (String) session.getAttribute("damages");
        
        // Create car certification request
        CarCertificationRequest carRequest = new CarCertificationRequest(
            brand, model, year, mileage, price, location, ownerContact, damages
        );
        
        // Save to src/main/storage/carcert.txt using absolute path
        String storageDir = "d:" + File.separator + "friends" + File.separator + "car certification" + File.separator + "car-sales-myBranch" + File.separator + "car-sales-myBranch" + File.separator + "src" + File.separator + "main" + File.separator + "java" + File.separator + "storage";
        File storageDirFile = new File(storageDir);
        if (!storageDirFile.exists()) {
            storageDirFile.mkdirs();
        }
        String filePath = storageDir + File.separator + "carcert.txt";
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath, true))) {
            writer.println(carRequest.toStringFormatted());
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save your request. Please try again.");
            request.getRequestDispatcher("/views/submit_review.jsp").forward(request, response);
            return;
        }
        
        // Clear session
        session.invalidate();
        
        // Set success message
        request.setAttribute("success", "Your car certification request has been submitted successfully!");
        request.getRequestDispatcher("/views/submit_review.jsp").forward(request, response);
    }
}
