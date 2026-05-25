package com.carval.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/car-details")
public class CarDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/car_details.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));
        double price = Double.parseDouble(request.getParameter("price"));
        String location = request.getParameter("location");
        String ownerContact = request.getParameter("ownerContact");
        
        // Save to session
        HttpSession session = request.getSession();
        session.setAttribute("brand", brand);
        session.setAttribute("model", model);
        session.setAttribute("year", year);
        session.setAttribute("mileage", mileage);
        session.setAttribute("price", price);
        session.setAttribute("location", location);
        session.setAttribute("ownerContact", ownerContact);
        
        // Redirect to next step
        response.sendRedirect(request.getContextPath() + "/damage-info");
    }
}
